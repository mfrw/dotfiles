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
				-- built from source against zig master; mason only ships tagged
				-- zls releases and zigtools publishes no nightlies, so a mason
				-- zls always lags zig master by a minor version and mis-parses
				-- its AST. rebuild with: git -C ~/zutils/zls pull && zig build -Doptimize=ReleaseSafe
				zls = {
					manual_install = true,
					cmd = { vim.fn.expand("~/zutils/zls/zig-out/bin/zls") },
				},
			}

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

					vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {})
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
					vim.keymap.set("n", "<C-]>", "<cmd>Telescope lsp_definitions<CR>", {})
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
					vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})
					vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
					vim.keymap.set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", {})
					vim.keymap.set("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, {})
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, {})
					vim.keymap.set("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", {})
					vim.keymap.set("n", "<space>ci", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", {})
					vim.keymap.set("n", "<space>co", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", {})

					if client:supports_method("textDocument/inlayHint") then
						vim.keymap.set("n", "<space>ih", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
						end, { desc = "Toggle inlay hints", buffer = bufnr })
					end

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})

			-- Autoformatting Setup
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						lsp_fallback = true,
						quiet = true,
					})
				end,
			})
		end,
	},
}
