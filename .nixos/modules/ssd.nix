{
  services = {
    # SSD TRIM
    fstrim.enable = true;
    btrfs.autoScrub.enable = true;
  };

  fileSystems."/".options = [ "noatime" "compress=zstd" ];
}
