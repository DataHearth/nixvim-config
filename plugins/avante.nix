{ pkgs, ... }:
{
  plugins = {
    dressing.enable = true;
    nui.enable = true;

    avante = {
      enable = true;
      settings = {
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
