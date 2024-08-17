{ pkgs, ... }:
{

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    supportedFilesystems = [
      "btrfs"
      "ntfs"
    ];
  };

  # Bluetooth battery
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  # Set your time zone.
  time = {
    timeZone = "Asia/Colombo";
    # hardwareClockInLocalTime = false; # Fix: Messy system time jumps
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };
  environment.gnome.excludePackages = (with pkgs; [ gnome-tour ]);

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
}
