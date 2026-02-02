*** I doubt this is the best way to set this up, but it's what I've got for now

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
home-manager switch --flake .#clancy
```


##### Graphics compatibility stuff?
```
nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl && nix-channel --update
```

##### TTY time?
```
nix-env -iA nixgl.auto.nixGLIntel
```
