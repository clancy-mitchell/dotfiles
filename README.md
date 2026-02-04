## Features
* [x] Hyprland
* [x] Waybar
* [x] Evil Emacs
* [x] Stylix  
* [x] Screenshots with Annotations
* [ ] Local X11 Applications (Calling it now this is a DNS issue)
* [ ] X11 Forwarding
* [ ] Screensharing
* [ ] Moonlight


## Installation

##### Install Nix
```
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
. /home/$(whoami)/.nix-profile/etc/profile.d/nix.sh
```

##### Add Nix home manager
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

##### Some setup
```
mkdir -p ~/.config/nix
vi ~/.config/nix/nix.conf
```
and add...
```
experimental-features = nix-command flakes
ssl-cert-file = /etc/pki/tls/certs/ca-bundle.crt
```

##### Home Manager install
```
nix-shell '<home-manager>' -A install
```

##### Switch to flake
```
home-manager switch --flake .#cm
```

##### Fire it up
```
nixGLIntel start-hyprland
```

## Debugging

##### Grubby for integrated Intel Graphics
```
sudo grubby --update-kernel=ALL --remove-args="nomodeset"
sudo grubby --update-kernel=ALL --args="i915.modeset=1 i915.enable_guc=0 nomodeset"
```

