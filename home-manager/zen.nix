{
  inputs,
  config,
  pkgs,
  programs,
  ...
}: let
  mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
    installation_mode = "force_installed";
  });
in {
  imports = [
    inputs.zen-browser.homeModules.default
  ];
  programs.zen-browser = {
    enable = true;
    policies = {
      ExtensionsSettings = mkExtensionSettings {
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = "vimium-ff";
      };
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };
}
