{
  plugins.lsp = {
    enable = true;
    postConfig = ''
      local lsp = vim.lsp;
      lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
        border = "rounded",
      })
      lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
        border = "rounded",
      })
    '';

    servers = {
      bashls.enable = true;
      dockerls.enable = true;
      eslint.enable = true;
      html.enable = true;
      htmx.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      nixd.enable = true;
      pyright.enable = true;
      ruff.enable = true;
      svelte.enable = true;
      tailwindcss.enable = true;
      taplo.enable = true;
      ts_ls.enable = true;
      yamlls = {
        enable = true;
        settings = {
          schemas = {
            "https://json.schemastore.org/kestra-0.19.0.json" = "kestra/**/*.{yaml,yml}";
          };
          schemaStore.enable = true;
        };
      };

      gopls = {
        enable = true;

        extraOptions = {
          staticcheck = true;
          gofumpt = true;
          analyses = {
            unusedvariable = true;
          };
        };
      };

      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
    };

    keymaps.lspBuf = {
      "<S-k>" = "hover";
      "<leader>a" = "code_action";
      "<leader>r" = "rename";
      "<leader>gd" = "definition";
      "<leader>gD" = "declaration";
      "<leader>gr" = "references";
    };
  };
}
