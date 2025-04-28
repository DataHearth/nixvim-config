{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      log_level = "error";
      formatters_by_ft =
        let
          shell = [
            "shfmt"
            "shellcheck"
          ];
          js = [
            "prettier"
            "eslint_d"
          ];
        in
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
          css = [ "prettier" ];
          html = [ "prettier" ];
          json = [ "prettier" ];
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
