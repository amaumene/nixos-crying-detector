{ config, pkgs, lib, ... }:
with import <nixpkgs> {};

{
  imports = [
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/raspberry-pi/4"
    ./services/colin-crying-detector.nix
  ];

  nixpkgs.overlays = [
  (final: super: {
    makeModulesClosure = x:
      super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  boot = {
    tmpOnTmpfs = true;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
  };

  #sdImage.compressImage = false;
 
  time.timeZone = "Asia/Singapore";

  # Required for the Wireless firmware
  hardware.enableRedistributableFirmware = true;

  networking = {
    hostName = "colinou"; # Define your hostname.
    useDHCP = true;
    wireless = {
      enable = true;
      networks = {
        your_wifi_ssid = { psk = "your_wifi_psk"; };
      };
    };
  };

  services.colin-crying-detector.enable = true;
  services.colin-crying-detector.user = "colin";
  services.colin-crying-detector.api-key = "your_pushover_api_key";
  services.colin-crying-detector.user-key = "your_pushover_user_key";

  environment.systemPackages = with pkgs; [
    neovim git mtr tmux iperf3 git sysstat iftop htop 
  ];
  
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

    system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "daily UTC";
    channel = https://nixos.org/channels/nixos-21.11-aarch64;
  };

  users = {
    mutableUsers = false;
    users.alex = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ "your_ssh_key" ];
      extraGroups = [ "wheel" "audio" ]; # Enable ‘sudo’ for the user.
      initialHashedPassword = "your_hashed_password";
    };
    users.colin = {
      isNormalUser = true;
      extraGroups = [ "audio" ];
    };
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

  # Assuming this is installed on top of the disk image.
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
  powerManagement.cpuFreqGovernor = "ondemand";
  system.stateVersion = "21.11";
}
