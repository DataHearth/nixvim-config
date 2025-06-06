{
  plugins.schemastore = {
    enable = true;
    yaml.enable = true;
    json.enable = true;
  };

  keymaps = [
    {
      action = "<cmd>lua vim.lsp.buf.hover({border = 'rounded'})<cr>";
      key = "<S-k>";
    }
  ];

  autoCmd = [
    # https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports-and-formatting
    {
      pattern = [ "*.go" ];
      callback.__raw = ''
        function()
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                  vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
              end
            end
            vim.lsp.buf.format({async = false})
          end
      '';
      event = "BufWritePre";
    }
  ];

  plugins.lsp = {
    enable = true;

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
      yamlls.enable = true;

      ts_ls = {
        enable = true;
        rootMarkers = [ "package.json" ];
        extraOptions.single_file_support = false;
      };

      taplo = {
        enable = true;
        rootMarkers = [
          "*.toml"
          ".git"
        ];
      };

      gopls = {
        enable = true;
        settings = {
          staticcheck = true;
          gofumpt = true;
          usePlaceholders = true;
          analyses = {
            shadow = true;
          };
        };
      };

      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
    };

    keymaps.lspBuf = {
      "<leader>a" = "code_action";
      "<leader>r" = "rename";
      "<leader>gd" = "definition";
      "<leader>gD" = "declaration";
      "<leader>gr" = "references";
    };
  };
}
