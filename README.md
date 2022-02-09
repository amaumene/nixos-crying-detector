# nixos-crying-detector

Rough instructions:

On a NixOs machine:
```git clone https://github.com/amaumene/nixos-crying-detector.git```

```cd nixos-crying-detector```

```nix-shell -p nixos-generators```

Edit all the "your_..." on configuration.nix:
```        your_wifi_ssid = { psk = "your_wifi_psk"; };
  services.colin-crying-detector.api-key = "your_pushover_api_key";
  services.colin-crying-detector.user-key = "your_pushover_user_key";
      openssh.authorizedKeys.keys = [ "your_ssh_key" ];
      initialHashedPassword = "your_hashed_password";```

Generate the img and copy it to your SD card
```nixos-generate -f sd-aarch64-installer -c configuration.nix```
