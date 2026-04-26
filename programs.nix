{ lib, config, pkgs, userConfig, ... }:

{
  programs = {

    fzf.enable = true;

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      initContent = ''
        alias ls='eza'
        alias g='git'
        alias vi='TERM=xterm-direct emacsclient -ct'
      '';
    };

    foot = {
      enable = true;
      server.enable = true;
    };

    emacs = {
      enable = true;
      extraPackages = epkgs: with epkgs; [
        general
        magit
        evil-collection
        swiper
        evil
        git-link
        consult 
        projectile
        vertico
        git-link
        nix-mode
        color-identifiers-mode
        which-key
        highlight-thing
        hl-todo
        indent-guide
        whitespace-cleanup-mode
      ];
      extraConfig = builtins.readFile ./conf/init.el;
    };

    eza.enable = true;
    ripgrep.enable = true;

    starship =  {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        continuation_prompt =  ">> ";

     format = lib.concatStrings [
        "$username"
        "$hostname"
        "$localip"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$fill"
        "$git_metrics"
        "$fill "
        "$time"
        "$shlvl"
        "$status"
        "$shell"
        "$all"
        "$character"
      ];

      aws = {
        format = "[$symbol( $profile)($region)($duration)]($style) ";
        symbol = "aws";
      };

      c = {
        format = "[$symbol( $version(-$name))]($style) ";
        symbol = "c";
      };

      character = {
        success_symbol = "[>](green)";
        error_symbol = "[>](red)";
        vimcmd_symbol = "[<](green)";
      };

      cmake = {
        format = "[$symbol( $version)]($style) ";
        symbol = "cmake";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
      };

      conda = {
        format = "[$symbol $environment]($style) ";
        symbol = "conda";
      };

      dart = {
        format = "[$symbol( $version)]($style) ";
        symbol = "dart";
      };

      docker_context = {
        format = "[$symbol $context]($style) ";
        symbol = "docker";
      };

      fill = {
        symbol = "-";
        style = "dimmed white";
      };

      gcloud = {
        format = "[$symbol $account(@$domain)($region)]($style) ";
        symbol = "gcp";
      };

      git_branch = {
        format = "[$branch]($style) ";
      };

      git_commit = {
        tag_symbol = " tag ";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        style = "yellow";

        diverged = "<$behind_count>$ahead_count";

        conflicted = "=$count ";
        ahead = "[>$count](green) ";
        behind = "[<$count](green) ";
        untracked = "?$count ";
        stashed = "*$count ";
        modified = "!$count ";
        staged = "+$count ";
        renamed = "r$count ";
        deleted = "x$count ";
      };

      git_metrics = {
        disabled = false;
        format = "( [+$added]($added_style) )([-$deleted]($deleted_style) )";
      };

      golang = {
        format = "[$symbol( $version)]($style) ";
        symbol = "go";
      };

      gradle = {
        format = "[$symbol( $version)]($style) ";
        symbol = "gradle";
      };

      haskell = {
        format = "[$symbol( $version)]($style) ";
        symbol = "hs";
      };

      helm = {
        format = "[$symbol( $version)]($style) ";
        symbol = "helm";
      };

      java = {
        format = "[$symbol( $version)]($style) ";
        symbol = "java";
      };

      julia = {
        format = "[$symbol( $version)]($style) ";
        symbol = "jl";
      };

      kotlin = {
        format = "[$symbol( $version)]($style) ";
        symbol = "kt";
      };

      kubernetes = {
        format = "[$symbol $context( $namespace)]($style) ";
        symbol = "k8s";
      };

      lua = {
        format = "[$symbol( $version)]($style) ";
        symbol = "lua";
      };

      memory_usage = {
        format = "$symbol [$ram( | $swap)]($style) ";
        symbol = "ram";
      };

      meson = {
        format = "[$symbol $project]($style) ";
        symbol = "meson";
      };

      nix_shell = {
        format = "[$symbol $state( $name)]($style) ";
        symbol = "nix";
      };

      nodejs = {
        format = "[$symbol( $version)]($style) ";
        symbol = "node";
      };

      os = {
        format = "[$symbol]($style) ";
      };

      package = {
        format = "[$symbol $version]($style) ";
        symbol = "pkg";
      };

      purescript = {
        format = "[$symbol( $version)]($style) ";
        symbol = "purs";
      };

      python = {
        format = "[$symbol$pyenv_prefix( $version)($virtualenv)]($style) ";
        symbol = "py";
      };

      ruby = {
        format = "[$symbol( $version)]($style) ";
        symbol = "rb";
      };

      rust = {
        format = "[$symbol( $version)]($style) ";
        symbol = "rs";
      };

      shell = {
        disabled = false;
      };

      shlvl = {
        disabled = false;
        symbol = "lvl ";
      };

      status = {
        disabled = false;
        format = "[$common_meaning]($style) ";
        # TODO: Fix the weird width stuff
        pipestatus = false;
        pipestatus_format = "$pipestatus=> [$common_meaning$signal_name$maybe_int]($style) ";
      };

      sudo = {
        format = "[as $symbol]($style) ";
        symbol = "sudo";
      };

      swift = {
        format = "[$symbol( $version)]($style) ";
        symbol = "swift";
      };

      terraform = {
        format = "[$symbol $workspace]($style) ";
        symbol = "tf";
      };

      time = {
        disabled = false;
        format = "[$time]($style) ";
      };

      username = {
        format = "[$user]($style) ";
      };

      zig = {
        format = "[$symbol( $version)]($style) ";
        symbol = "zig";
      };

      };
    };

    git = {
      enable = true;
      settings.core.editor = "TERM=xterm-direct emacsclient -ct";

      settings.user = {
        name  = userConfig.git.name;
        email = userConfig.git.email;
      };

      settings.alias = {
        a = "add";
        sf = "fuzzy status";
        df = "fuzzy diff";
        aa = "add -A";
        psf = "push --force-with-lease";
        r = "rebase";
        re = "restore";
        pl = "pull";
        st = "status";
        sw = "switch";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --oneline --graph --decorate --all";
      };
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    waybar  = {
      enable = true;
      systemd.enable = true;
      
      settings.mainBar = {
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "network"
          "cpu"
          "memory"
          "clock"
          "date"
        ];
        cpu.format = "CPU: {}%";
        memory.format = "RAM: {}%";
        clock = {
          timezone = "America/Los_Angeles";
          format = "{:%H:%M %A, %B %d, %Y}";
        };
        network = {
          format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          format-disconnected = "{ifname}: Disconnected";
        };
      };
    };
  };
}
