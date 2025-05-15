{ pkgs, ... }:
{
  extraPlugins = with pkgs; [
    vimPlugins.colorful-menu-nvim
  ];
  extraConfigLua = ''
    require('colorful-menu').setup({})
  '';

  plugins = {
    luasnip = {
      enable = true;
      fromVscode = [ { paths = ../snippets; } ];
    };
    lsp.capabilities = "capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())";

    blink-cmp = {
      enable = true;

      settings = {
        snippets.preset = "luasnip";
        keymap.preset = "enter";
        sources.default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
        cmdline.enabled = false;

        signature = {
          enabled = true;
          window.border = "single";
        };

        completion = {
          ghost_text.enabled = true;
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 500;
            window.border = "single";
          };

          menu = {
            border = "single";

            draw = {
              columns = [
                [
                  "kind_icon"
                  "label"
                ]
                [
                  "kind"
                ]
              ];

              components.label = {
                text.__raw = "function(ctx) return require('colorful-menu').blink_components_text(ctx) end";
                highlight.__raw = "function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end";
              };
            };
          };
          list.selection = {
            preselect = false;
            auto_insert = true;
          };
        };

        appearance = {
          use_nvim_cmp_as_default = true;
          nerd_font_variant = "normal";
          kind_icons = {
            Text = "󰉿";
            Method = "󰊕";
            Function = "󰊕";
            Constructor = "󰒓";

            Field = "󰜢";
            Variable = "󰆦";
            Property = "󰖷";

            Class = "󱡠";
            Interface = "󱡠";
            Struct = "󱡠";
            Module = "󰅩";

            Unit = "󰪚";
            Value = "󰦨";
            Enum = "󰦨";
            EnumMember = "󰦨";

            Keyword = "󰻾";
            Constant = "󰏿";

            Snippet = "󱄽";
            Color = "󰏘";
            File = "󰈔";
            Reference = "󰬲";
            Folder = "󰉋";
            Event = "󱐋";
            Operator = "󰪚";
            TypeParameter = "󰬛";
          };
        };
      };
    };
  };
}
