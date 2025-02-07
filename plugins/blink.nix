{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "colorful-menu";
      src = pkgs.fetchFromGitHub {
        owner = "xzbdmw";
        repo = "colorful-menu.nvim";
        rev = "37771361ce3bcb99448b9e760ca6f65d5831003e";
        hash = "sha256-52wPIyuyi/eW/V2RsKTgit+//mMxHvcTzDi/gyrNbEg=";
      };
      nvimSkipModule = [
        "repro_cmp"
        "repro_blink"
      ];
    })
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
      package = pkgs.vimPlugins.blink-cmp.overrideAttrs (oldAttrs: {
        version = "0.12.0-not-released";
        src = pkgs.fetchFromGitHub {
          owner = "Saghen";
          repo = "blink.cmp";
          rev = "9f32ef5c3bb44f943238bbcde0c467936475f177"; # Fix a duplication of snippets when using luasnip preset
          hash = "sha256-1arLnPBGRzz7NbNNyRqVPjp5kKU4/g+2Qtd6N7+55TU=";
        };
      });

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
          menu = {
            border = "single";
            draw = {
              columns = [
                [
                  "kind_icon"
                  "label"
                  # "label_description"
                ]
                [
                  "kind"
                ]
              ];
              components = {
                label = {
                  text.__raw = "function(ctx) return require('colorful-menu').blink_components_text(ctx) end";
                  highlight.__raw = "function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end";
                };
              };
            };
          };
          documentation.window.border = "single";
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
