{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      log_level = "error";
      formatters_by_ft = {
        lua = [ "stylua" ];
        go = [
          "gofumpt"
          "golines"
        ];
        javascript = [
          "prettier"
          "eslint_d"
        ];
        typescript = [
          "prettier"
          "eslint_d"
        ];
        css = [ "prettier" ];
        html = [ "prettier" ];
        json = [ "prettier" ];
        nix = [ "nixfmt" ];
        python = [ "ruff_format" ];
        rust = [ "rustfmt" ];
        svelte = [
          "prettier"
          "eslint_d"
        ];
        toml = [ "taplo" ];
        sh = [
          "shfmt"
          "shellcheck"
        ];
        bash = [
          "shfmt"
          "shellcheck"
        ];
        zsh = [
          "shfmt"
          "shellcheck"
        ];
        "_" = [ "trim_whitespace" ];
      };
      format_on_save = {
        lsp_fallback = "fallback";
        timeout_ms = 3000;
      };
    };
  };
}
