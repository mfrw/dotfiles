return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/lazydev.nvim",
			"williamboman/mason.nvim",
			-- required (even with no explicit setup call) so that
			-- mason-tool-installer can translate lspconfig server names
			-- (lua_ls, rust_analyzer, yamlls, ...) into actual mason
			-- package names (lua-language-server, rust-analyzer, ...)
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			-- Autoformatting
			"stevearc/conform.nvim",
		},
		config = function()
			require("lazydev").setup({
				-- library = {
				--   plugins = { "nvim-dap-ui" },
				--   types = true,
				-- },
			})

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local servers = {
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							imports = {
								group = {
									enable = false,
								},
							},
							completion = {
								postfix = {
									enable = false,
								},
							},
							procMacro = {
								enable = true,
							},
							add_return_type = {
								enable = true,
							},
							inlayHints = {
								enable = true,
								showParameterNames = true,
								parameterHintsPrefix = "<- ",
								otherHintsPrefix = "=> ",
							},
							diagnostics = {
								enable = true,
							},
						},
					},
				},
				clangd = {
					-- TODO: Could include cmd, but not sure those were all relevant flags.
					--    looks like something i would have added while i was floundering
					init_options = { clangdFileStatus = true },
					filetypes = { "c" },
				},
			}

			-- zls has to be picked per machine. mason only ships tagged zls
			-- releases and zigtools publishes no nightlies, so a mason zls
			-- lags zig master by a minor version and mis-parses its AST. On
			-- machines tracking zig master, build zls from source with:
			--   git -C ~/zutils/zls pull && zig build -Doptimize=ReleaseSafe
			-- Detect that build rather than hard-coding either choice, so this
			-- file stays identical everywhere: use it when present, otherwise
			-- fall back to whatever mason provides.
			local zls_src = vim.fn.expand("~/zutils/zls/zig-out/bin/zls")
			if vim.uv.fs_stat(zls_src) then
				servers.zls = { manual_install = true, cmd = { zls_src } }
			else
				servers.zls = {}
			end

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				-- "tailwind-language-server",
				"stylua", -- formatter for lua, used by conform.nvim below
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed, autoupdate = true })
			vim.lsp.config("*", {
				capabilities = capabilities,
			})
			-- Configure and enable each LSP server
			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end

				-- Only call vim.lsp.config if there are server-specific settings
				if next(config) ~= nil then
					-- Remove manual_install flag as it's not an LSP config field
					local lsp_config = vim.tbl_deep_extend("force", {}, config)
					lsp_config.manual_install = nil
					vim.lsp.config(name, lsp_config)
				end

				vim.lsp.enable(name)
			end

			local disable_semantic_tokens = {
				-- lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

					-- only map when the server actually advertises the method, so
					-- unsupported keys stay unmapped instead of silently doing
					-- nothing (zls, for example, offers no call hierarchy)
					local function map(keys, fn, desc, method)
						if method and not client:supports_method(method) then
							return
						end
						vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = "lsp: " .. desc })
					end

					-- nvim already ships grn (rename), gra (code action, also in
					-- visual mode), grr (references), gri (implementation), grt
					-- (type definition), grx (run code lens), gO (document
					-- symbols) and i_<C-S> (signature help), plus [d ]d ]D [D and
					-- <C-W>d for diagnostics. Only map what those do not cover.
					map("gd", vim.lsp.buf.definition, "goto definition", "textDocument/definition")
					map(
						"<C-]>",
						"<cmd>Telescope lsp_definitions<CR>",
						"goto definition (telescope)",
						"textDocument/definition"
					)
					map("K", vim.lsp.buf.hover, "hover documentation", "textDocument/hover")
					map("<C-k>", vim.lsp.buf.signature_help, "signature help", "textDocument/signatureHelp")
					map("<space>q", vim.diagnostic.setloclist, "diagnostics to loclist")
					map("<space>ci", vim.lsp.buf.incoming_calls, "incoming calls", "textDocument/prepareCallHierarchy")
					map("<space>co", vim.lsp.buf.outgoing_calls, "outgoing calls", "textDocument/prepareCallHierarchy")
					map(
						"<space>ws",
						"<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
						"workspace symbols",
						"workspace/symbol"
					)
					map("<space>ts", function()
						vim.lsp.buf.typehierarchy("supertypes")
					end, "supertypes", "textDocument/prepareTypeHierarchy")
					map("<space>tb", function()
						vim.lsp.buf.typehierarchy("subtypes")
					end, "subtypes", "textDocument/prepareTypeHierarchy")
					map("<space>ih", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
							{ bufnr = bufnr }
						)
					end, "toggle inlay hints", "textDocument/inlayHint")

					-- highlight the other references to the symbol under the cursor
					if client:supports_method("textDocument/documentHighlight") then
						local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							group = group,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.document_highlight()
							end,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							group = group,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.clear_references()
							end,
						})
					end

					-- prefer LSP folding over the treesitter default (options.lua)
					-- wherever this buffer is displayed
					if client:supports_method("textDocument/foldingRange") then
						for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
							vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
						end
					end

					-- nvim's grx runs the lens under the cursor. enable() installs
					-- its own debounced on_lines refresh, so no autocmd is needed
					-- here (and vim.lsp.codelens.refresh is deprecated in 0.12)
					if client:supports_method("textDocument/codeLens") then
						vim.lsp.codelens.enable(true, { bufnr = bufnr })
					end

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				callback = function(args)
					-- only tear down once the last client leaves the buffer; the
					-- detaching client is still listed at this point
					if #vim.lsp.get_clients({ bufnr = args.buf }) > 1 then
						return
					end
					pcall(vim.api.nvim_del_augroup_by_name, "lsp_document_highlight_" .. args.buf)
					pcall(vim.lsp.buf.clear_references)
				end,
			})

			-- Autoformatting Setup
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				format_on_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { lsp_format = "fallback", quiet = true }
				end,
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, { desc = "disable autoformat-on-save (! for this buffer only)", bang = true })

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, { desc = "re-enable autoformat-on-save" })

			vim.keymap.set("n", "<space>tf", function()
				if vim.g.disable_autoformat then
					vim.cmd.FormatEnable()
					vim.notify("autoformat on save: ON")
				else
					vim.cmd.FormatDisable()
					vim.notify("autoformat on save: OFF")
				end
			end, { desc = "toggle autoformat-on-save" })
		end,
	},
}
