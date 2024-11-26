{
  imports = [ ./plugins ];

  viAlias = true;
  vimAlias = true;
  keymaps = import ./keymaps;
  globals.mapleader = " ";
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

  plugins = {
    barbecue.enable = true; # Symbol bar
    bufferline.enable = true;
    chadtree.enable = true; # Tree navigation
    comment.enable = true; # Comment code
    crates-nvim.enable = true; # Crate auto-complete and verification
    diffview.enable = true; # Git diff view
    earthly.enable = true;
    illuminate.enable = true; # Highlight words
    indent-blankline.enable = true;
    lazygit.enable = true;
    lspkind.enable = true; # Beautify LSP
    lualine.enable = true; # Status line
    neogit.enable = true;
    nix.enable = true;
    nvim-autopairs.enable = true; # Auto close symbols
    todo-comments.enable = true; # Comments highlighting
    ts-autotag.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;
    yazi.enable = true;

    luasnip = {
      enable = true;
      fromVscode = [ { paths = ./snippets; } ];
    };
  };
}
