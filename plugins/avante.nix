{ pkgs, ... }:
{
  plugins = {
    copilot-lua.enable = true;
    dressing.enable = true;
    nui.enable = true;

    avante = {
      enable = true;
      settings = {
        provider = "copilot";
        auto_suggestions_frequency = "copilot";
      };
    };

    render-markdown = {
      enable = true;
      settings = {
        file_types = [ "Avante" ];
        latex.enabled = false;
      };
    };
  };

  extraPlugins = with pkgs; [
    vimPlugins.plenary-nvim
  ];
}
