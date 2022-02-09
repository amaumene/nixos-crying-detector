{ config, lib, pkgs, ... }:

let
  colin-crying-detector = pkgs.python3Packages.callPackage ../pkgs/colin-crying-detector.nix {
    fastai = pkgs.python3Packages.callPackage ../pkgs/fastai.nix { 
      torch-rpi4 = pkgs.python3Packages.callPackage ../pkgs/torch-rpi4.nix {};
      torchvision-rpi4 = pkgs.python3Packages.callPackage ../pkgs/torchvision-rpi4.nix { torch-rpi4 = pkgs.python3Packages.callPackage ../pkgs/torch-rpi4.nix {}; };
      nvidia-ml-py3 = pkgs.python3Packages.callPackage ../pkgs/nvidia-ml-py3.nix {};
    };
    librosa = pkgs.python3Packages.callPackage ../pkgs/librosa.nix {};
  };
  cfg = config.services.colin-crying-detector;

in {
  options.services.colin-crying-detector.enable = lib.mkEnableOption "colin-crying-detector";

  options.services.colin-crying-detector.user = lib.mkOption {
    type = lib.types.str;
    default = "colin";
    description = "User account under which colin-crying-detector runs";
  };

  options.services.colin-crying-detector.api-key = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "API Key for pushover.net service";
  };

  options.services.colin-crying-detector.user-key = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "User Key for pushover.net service";
  };
  
  config = lib.mkIf cfg.enable {
          # Describe the systemd service file
          systemd.services.colin-crying-detector = {
              description = "Detect if Colin is crying";
              environment = {
                  PYTHONUNBUFFERED = "1";
              };
  
              after = [ "network-online.target" ];
              wantedBy = [ "network-online.target" ];
  
              serviceConfig = {
	          ExecStart = "${colin-crying-detector}/bin/detect.py -a ${cfg.api-key} -u ${cfg.user-key}";
                  Restart = "always";
                  RestartSec = "5";
		  User = cfg.user;
              };
          };
  };
}
