{ pkgs, ... }:
{
  extraPlugins = with pkgs; [
    vimPlugins.colorful-menu-nvim
  ];
  extraConfigLua = ''
    require('colorful-menu').setup({})
  '';

  plugins = {
    blink-cmp-copilot.enable = true;
    copilot-lua = {
      enable = true;
      settings.opts = {
        suggestion.enabled = false;
        panel.enabled = false;
        filetypes = {
          markdown = true;
          help = true;
        };
      };
    };
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
          "copilot"
        ];

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

        sources.providers = {
          copilot = {
            name = "copilot";
            module = "blink-cmp-copilot";
            score_offset = 100;
            async = true;
            transform_items.__raw = ''
              function(_, items)
                local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                local kind_idx = #CompletionItemKind + 1
                CompletionItemKind[kind_idx] = "Copilot"

                for _, item in ipairs(items) do
                  item.kind = kind_idx
                end

                return items
              end
            '';
          };
        };

        appearance = {
          use_nvim_cmp_as_default = true;
          nerd_font_variant = "normal";
          kind_icons = {
            Copilot = "";
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
