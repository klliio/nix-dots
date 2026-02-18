{ pkgs, ...}: {
    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
    };

    home.packages = with pkgs; [
        lua-language-server
        nil
        clang
        bash-language-server
        jdt-language-server
        rust-analyzer

        shfmt
        nixfmt-rfc-style
        stylua
        prettierd
        rustfmt

        wl-clipboard # allows copy paste
        fd
        ripgrep
        fzf #  telescope
        nodejs
    ];

    programs.neovim =
    let
        toFile = file: "\n${builtins.readFile file}\n";
    in {
        enable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        withRuby = true;
        withPython3 = true;
        withNodeJs = true;

        plugins = with pkgs.vimPlugins; [
            # misc
            {
                plugin = comment-nvim;
                type = "lua";
                config = "require(\"Comment\").setup()";
            }
            {
                plugin = indent-blankline-nvim;
                type = "lua";
                config = toFile ../../nvim/plugin/indent-blankline.lua;
            }

            # lsp
            {
                plugin = nvim-lspconfig;
                type = "lua";
                config = toFile ../../nvim/plugin/lsp.lua;
            }
            {
                plugin = nvim-cmp;
                type = "lua";
                config = toFile ../../nvim/plugin/cmp.lua;
            }
            {
                plugin = conform-nvim;
                type = "lua";
                config = toFile ../../nvim/plugin/conform.lua;
            }
            neodev-nvim
            cmp_luasnip
            cmp-nvim-lsp
            luasnip
            plenary-nvim

            # navigation
            {
                plugin = telescope-nvim;
                type = "lua";
                config = toFile ../../nvim/plugin/telescope.lua;
            }
            telescope-fzf-native-nvim

            # appearance
            {
                plugin = catppuccin-nvim;
                type = "lua";
                config = toFile ../../nvim/plugin/catppuccin.lua;
            }
            {
                plugin = lualine-nvim;
                type = "lua";
                config = toFile ../../nvim/plugin/lualine.lua;
            }
            which-key-nvim
            nvim-web-devicons
            fidget-nvim
            gitsigns-nvim

            {
                plugin = (nvim-treesitter.withPlugins (p: [
                    p.tree-sitter-nix
                    p.tree-sitter-vim
                    p.tree-sitter-bash
                    p.tree-sitter-lua
                    p.tree-sitter-rust
                    p.tree-sitter-typescript
                    p.tree-sitter-javascript
                    p.tree-sitter-vala
                ]));
                type = "lua";
                config = toFile ../../nvim/plugin/treesitter.lua;
            }
        ];


        extraLuaConfig = ''
            ${builtins.readFile ../../nvim/options.lua}
            ${builtins.readFile ../../nvim/keymaps.lua}
            ${builtins.readFile ../../nvim/commands.lua}
        '';
    };
}
