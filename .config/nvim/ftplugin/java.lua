local config = {
	cmd = { "jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", "src", "mvnw" }, { upward = true })[1]),
	-- config = {
	-- 	bundles = {
	-- 		vim.fn.glob(
	-- 			"path/to/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
	-- 			1
	-- 		),
	-- 	},
	-- },
}
require("jdtls").start_or_attach(config)
