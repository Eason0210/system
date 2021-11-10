{ config, pkgs, ... }: {
  system.defaults = {
    NSGlobalDomain = {
      # AppleKeyboardUIMode = 3;
      # ApplePressAndHoldEnabled = false;
      # InitialKeyRepeat = 10;
      # KeyRepeat = 1;
      # _HIHideMenuBar = true;

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;

      "com.apple.keyboard.fnState" = true;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.volume" = "0.0";
      "com.apple.sound.beep.feedback" = 0;
    };

    ".GlobalPreferences" = {
      "com.apple.sound.beep.sound" = "/System/Library/Sounds/Funk.aiff";
    };

    dock = {
      autohide = true;
      showhidden = true;
      launchanim = false;
      # orientation = "right";
    };

    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };
  };
}
