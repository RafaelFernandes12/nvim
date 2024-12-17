local home = os.getenv("HOME")
local workspace_path = home .. "/workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
		"-data",
		workspace_dir,
		"-Dosgi.os=linux", -- Ensures correct OS is detected
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk-amd64",
					},
				},
			},
			signatureHelp = { enabled = true },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = false,
			},
		},
	},

	init_options = {
		bundles = {},
	},
}
require("jdtls").start_or_attach(config)
-- transform these to lua keymaps
vim.api.nvim_set_keymap("n", "<leader>oi", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ev", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ev", "<Cmd>lua require('jdtls').extract_variable()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>em", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>em", "<Cmd>lua require('jdtls').extract_method()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ec", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ec", "<Cmd>lua require('jdtls').extract_constant()<CR>", { noremap = true, silent = true })
