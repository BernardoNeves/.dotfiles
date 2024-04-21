return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Notes",
                path = "D:/Notes",
            },
        },
        templates = {
            subdir = "Templates",
        },

    },
}
