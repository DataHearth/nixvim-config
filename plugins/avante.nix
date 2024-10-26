{ pkgs, ... }:
{
  plugins = {
    copilot-lua.enable = true;
    dressing.enable = true;
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
      };
    };
  };

  extraPlugins = with pkgs; [
    vimPlugins.nui-nvim
    vimPlugins.plenary-nvim
  ];
}
