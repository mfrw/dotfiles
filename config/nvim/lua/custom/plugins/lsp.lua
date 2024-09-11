return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/lazydev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Schema information
			-- "b0o/SchemaStore.nvim",
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

			local lspconfig = require("lspconfig")

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
				-- rust_analyzer = true,
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
				-- pyright = { manual_install = true },
				pylsp = {
					settings = {
						pylsp = {
							plugins = {
								pycodestyle = {
									convention = "None",
									ignore = { "W391", "pep8" },
									maxLineLength = 180,
								},
								autopep8 = { enabled = false },
							},
						},
					},
				},
				zls = true,
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
				"stylua",
				"lua_ls",
				"delve",
				-- "tailwind-language-server",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed, autoupdate = true })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
					-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
					-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					-- vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

					-- vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
					-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

					vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {})
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
					vim.keymap.set("n", "<C-]>", "<cmd>Telescope lsp_definitions<CR>", {})
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
					vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})
					vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
					vim.keymap.set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", {})
					vim.keymap.set("n", "<space>e", "<cmd>lua vim.diagnostic.get()<CR>", {})
					vim.keymap.set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", {})
					vim.keymap.set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", {})
					vim.keymap.set("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", {})
					vim.keymap.set("n", "<space>ci", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", {})
					vim.keymap.set("n", "<space>co", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", {})

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
