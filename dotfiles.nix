{ config, pkgs, ... }:

{
  home.file = {
    ".config/onedrive/config".text = ''
      sync_dir = "/home/sway/dl"
      skip_dir = "tb"
      skip_dir = "Pictures"
      skip_dir = "Desktop"
      skip_dir = "Attachments"
      skip_dir = "ArrowBackup"
    '';
    
    ".config/lock/config".text = ''
      show-keyboard-layout
      ignore-empty-password
      indicator-idle-visible
  
      color=A3A3A3
      inside-color=000000
      ring-color=0000ff
    '';

    ".config/git/config".text = ''
      [user]
          email = core@4c74356b41.com
          name = Gleb Boushev
      [core]
          eol = lf
          autocrlf = input
          excludesfile = ~/.config/git/ignore
      [pull]
          ff = only
      [core]
      
      [push]
          autoSetupRemote = true
      
      [credential]
          helper = cache
    '';

    ".config/git/config".text = ''
      [user]
          email = core@4c74356b41.com
          name = Gleb Boushev
      [core]
          eol = lf
          autocrlf = input
          excludesfile = ~/.config/git/ignore
      [pull]
          ff = only
      [core]
      
      [push]
          autoSetupRemote = true
      
      [credential]
          helper = cache
    '';
  };

  systemd.user.tmpfiles.rules = [
    "d %h/_git 0755 - - -"
    "d %h/downloads 0755 - - -"
    "d %h/dl 0755 - - -"
    "d %h/.config/git 0755 - - -"
    "d %h/.config/lock 0755 - - -"
    "d %h/.config/onedrive 0755 - - -"
  ];
}
