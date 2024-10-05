{ pkgs, ... }:
{
  imports = [ ./plugins ];

  viAlias = true;
  vimAlias = true;
  globals = {
    mapleader = " ";
  };
  colorscheme = "catppuccin";
  opts = {
    tabstop = 2;
    expandtab = true;
    softtabstop = 2;
    shiftwidth = 2;
    number = true;
    foldlevel = 20;
  };
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      transparent_background = true;
      flavour = "macchiato";
    };
  };
  keymaps = import ./keymaps;
  plugins = {
    barbecue.enable = true; # Symbol bar
    chadtree.enable = true; # Tree navigation
    comment.enable = true; # Comment code
    indent-blankline.enable = true;
    todo-comments.enable = true; # Comments highlighting
    crates-nvim.enable = true; # Crate auto-complete and verification
    diffview.enable = true; # Git diff view
    illuminate.enable = true; # Highlight words
    lspkind.enable = true; # Beautify LSP
    lualine.enable = true; # Status line
    luasnip = {
      enable = true;
      fromVscode = [ { paths = ./snippets; } ];
    }; # Snippets
    neogit.enable = true;
    nix.enable = true;
    nvim-autopairs.enable = true; # Auto close symbols
    which-key.enable = true;
    yazi.enable = true;
    lazygit.enable = true;
    ts-autotag.enable = true;
    bufferline.enable = true;
    earthly.enable = true;
    web-devicons.enable = true;

    # Custom
    harpoon = {
      enable = true;
      package = pkgs.vimUtils.buildVimPlugin {
        name = "harpoon2";
        src = pkgs.fetchFromGitHub {
          owner = "ThePrimeagen";
          repo = "harpoon";
          rev = "0378a6c428a0bed6a2781d459d7943843f374bce";
          hash = "sha256-FZQH38E02HuRPIPAog/nWM55FuBxKp8AyrEldFkoLYk=";
        };
      };
    };
  };
}
