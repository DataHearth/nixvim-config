{
  plugins.telescope = {
    enable = true;

    settings = {
      pickers = {
        find_files.find_command =
          let
            ignore_patterns = [
              ".git"
              "node_modules"
              "__pycache__"
              "target"
              ".direnv"
              ".venv"
              "venv"
              ".ruff_cache"
              "dist"
            ];
          in
          (
            [
              "fd"
              "--hidden"
              "--no-ignore"
            ]
            ++ builtins.concatMap (pattern: [
              "--exclude"
              "**/${pattern}"
            ]) ignore_patterns
          );
      };
    };

    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Find files in workspace";
      };
      "<leader>fg" = {
        action = "git_files";
        options.desc = "Find files in git files";
      };
      "<leader>fc" = {
        action = "live_grep";
        options.desc = "Find files containing a code pattern - regex";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "Find buffered files";
      };
      "<leader>fh" = {
        action = "help_tags";
        options.desc = "Command help tags";
      };
    };
  };
}
