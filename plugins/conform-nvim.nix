{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      log_level = "error";
      formatters = {
        deno_lint = {
          command = "deno";
          cond.__raw = ''
            function(self, ctx)
              local extensions = {
                astro = "astro",
                svelte = "svelte",
                vue = "vue",
                javascript = "js",
                javascriptreact = "jsx",
                typescript = "ts",
                typescriptreact = "tsx",
              }

              return extensions[vim.bo[ctx.buf].filetype] ~= nil
            end
          '';
          args.__raw = ''
            function(self, ctx)
              local extensions = {
                astro = "astro",
                svelte = "svelte",
                vue = "vue",
                javascript = "js",
                javascriptreact = "jsx",
                typescript = "ts",
                typescriptreact = "tsx",
              }

              return {
                "lint",
                "--fix",
                "--ext="..extensions[vim.bo[ctx.buf].filetype],
                "-",
              }
            end
          '';
        };
      };
      formatters_by_ft =
        let
          shell = [
            "shfmt"
            "shellcheck"
          ];
          js = [
            "deno_fmt"
            # "deno_lint" # Disabled because it blocks deno_fmt
          ];
        in
        # In case I want to use a function to determine the formatters
        # js = ''
        #   function(bufnr)
        #     local ft = vim.bo[bufnr].filetype
        #
        #     local deno_project = vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true, path = vim.fn.expand("%:p:h") })[1]
        #
        #     if (ft == "json" or ft == "html" or ft == "css") and not deno_project then
        #       return { "prettier" }
        #     end
        #
        #     if deno_project then
        #       return { "deno_fmt", "deno_lint" }
        #     end
        #
        #     return { "prettier", "eslint_d" }
        #   end
        # '';
        {
          sh = shell;
          bash = shell;
          zsh = shell;
          javascript = js;
          typescript = js;
          javascriptreact = js;
          typescriptreact = js;
          svelte = js;
          lua = [ "stylua" ];
          go = [
            "gofumpt"
            "golines"
          ];
          css = [ "deno_fmt" ];
          html = [ "deno_fmt" ];
          json = [ "deno_fmt" ];
          nix = [ "nixfmt" ];
          python = [ "ruff_format" ];
          rust = [ "rustfmt" ];
          toml = [ "taplo" ];
          sql = [ "sqlfluff" ];
          "_" = [ "trim_whitespace" ];
        };
      format_on_save = {
        lsp_fallback = "fallback";
        timeout_ms = 3000;
      };
    };
  };
}
