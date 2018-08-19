#!/bin/bash

# ---------------------------------------------------------------------------- #
# macOS
# ---------------------------------------------------------------------------- #

if [[ "$(uname -s)" == "Darwin" ]]; then

  # Close System Preferences to prevent any settings made here being overridden.
  osascript -e 'tell application "System Preferences" to quit'

  # -------------------------------------------------------------------------- #
  # Security
  # -------------------------------------------------------------------------- #

  # Enable Firewall.
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

  # -------------------------------------------------------------------------- #
  # Hostname
  # -------------------------------------------------------------------------- #

  # Set computer name (as done via System Preferences → Sharing).
  read -p "What would you like your computer to be named? " hostname

  sudo scutil --set ComputerName $hostname
  sudo scutil --set HostName $hostname
  sudo scutil --set LocalHostName $hostname
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $hostname

  # -------------------------------------------------------------------------- #
  # General preferences
  # -------------------------------------------------------------------------- #

  # System Preferences > General > Sidebar icon size - set sidebar icon size to small.
  defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1.

  # Expand save panel by default.
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  # Expand print panel by default.
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  # Save to disk (not to iCloud) by default.
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  # Automatically quit printer app once the print jobs complete.
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

  # Disable the “Are you sure you want to open this application?” dialog.
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window.
  sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

  # -------------------------------------------------------------------------- #
  # Display
  # -------------------------------------------------------------------------- #

  # Enable HiDPI display modes (requires restart).
  sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true

  # -------------------------------------------------------------------------- #
  # Audio
  # -------------------------------------------------------------------------- #

  # Increase sound quality for Bluetooth headphones/headsets.
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

  # -------------------------------------------------------------------------- #
  # Language
  # -------------------------------------------------------------------------- #

  # Set language and text formats.
  defaults write NSGlobalDomain AppleLanguages -array "en"
  defaults write NSGlobalDomain AppleLocale -string "en_AU@currency=AUD"
  defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
  defaults write NSGlobalDomain AppleMetricUnits -bool true

  # -------------------------------------------------------------------------- #
  # Screen savers
  # -------------------------------------------------------------------------- #

  # Require password immediately after sleep or screen saver begins.
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0

  # -------------------------------------------------------------------------- #
  # Finder
  # -------------------------------------------------------------------------- #

  # Allow quitting via ⌘ + Q; doing so will also hide desktop icons.
  defaults write com.apple.finder QuitMenuItem -bool true

  # Disable window animations and Get Info animations.
  defaults write com.apple.finder DisableAllAnimations -bool true

  # Set Home as the default location for new Finder windows.
  # For other paths, use `PfLo` and `file:///full/path/here/`.
  defaults write com.apple.finder NewWindowTarget -string "PfHm"
  defaults write com.apple.finder NewWindowTargetPath -string "file:///Users/${HOME}/"

  # Show icons for hard drives, servers, and removable media on the desktop.
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

  # Finder: show all filename extensions.
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Show status & path bars.
  defaults write com.apple.finder ShowStatusBar -bool true
  defaults write com.apple.finder ShowPathbar -bool true

  # Keep folders on top when sorting by name.
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  # When performing a search, search the current folder by default.
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Avoid creating .DS_Store files on network or USB volumes.
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  # Use column view in all Finder windows by default.
  # Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`, `Nlsv`
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

  # Expand the following File Info panes:
  # “General”, “Open with”, and “Sharing & Permissions”.
  defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

  # Disable warning when changing file extension.
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Show the ~/Library folder.
  chflags nohidden ~/Library

  # -------------------------------------------------------------------------- #
  # QuickLook
  # -------------------------------------------------------------------------- #

  # Enable text selection in QuickLook.
  defaults write com.apple.finder QLEnableTextSelection -bool true

  # -------------------------------------------------------------------------- #
  # Dock
  # -------------------------------------------------------------------------- #

  # Autohide the Dock.
  defaults write com.apple.dock autohide -bool true

  # Set the icon size of Dock items to 42 pixels.
  defaults write com.apple.dock tilesize -int 42

  # Change minimize/maximize window effect.
  defaults write com.apple.dock mineffect -string "scale"

  # Wipe all (default) app icons from the Dock.
  defaults write com.apple.dock persistent-apps -array

  # -------------------------------------------------------------------------- #
  # Dashboard
  # -------------------------------------------------------------------------- #

  # Disable Dashboard.
  defaults write com.apple.dashboard mcx-disabled -bool true

  # Don’t show Dashboard as a Space.
  defaults write com.apple.dock dashboard-in-overlay -bool true

  # -------------------------------------------------------------------------- #
  # Mission Control
  # -------------------------------------------------------------------------- #

  # Hot corners
  # Possible values:
  #  0 - no-op
  #  2 - Mission Control
  #  3 - Show application windows
  #  4 - Desktop
  #  5 - Start screen saver
  #  6 - Disable screen saver
  #  7 - Dashboard
  # 10 - Put display to sleep
  # 11 - Launchpad
  # 12 - Notification Center

  # Top left screen corner → Mission Control
  defaults write com.apple.dock wvous-tl-corner -int 2
  defaults write com.apple.dock wvous-tl-modifier -int 0
  # Top right screen corner → Notification Center
  defaults write com.apple.dock wvous-tr-corner -int 12
  defaults write com.apple.dock wvous-tr-modifier -int 0
  # Bottom right screen corner → Desktop
  defaults write com.apple.dock wvous-br-corner -int 4
  defaults write com.apple.dock wvous-br-modifier -int 0
  # Bottom left screen corner → Show application windows
  defaults write com.apple.dock wvous-bl-corner -int 3
  defaults write com.apple.dock wvous-bl-modifier -int 0

  # System Preferences > Mission Control > Automatically rearrange Spaces based on most recent use.
  defaults write com.apple.dock mru-spaces -bool false

  # -------------------------------------------------------------------------- #
  # Safari & WebKit
  # -------------------------------------------------------------------------- #

  # Privacy - don’t send search queries to Apple.
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true

  # Press Tab to highlight each item on a web page.
  defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

  # Set Safari’s home page to `about:blank` for faster loading.
  defaults write com.apple.Safari HomePage -string "about:blank"

  # Prevent Safari from opening ‘safe’ files automatically after downloading.
  defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

  # Hide Safari’s bookmarks bar by default.
  defaults write com.apple.Safari ShowFavoritesBar -bool false
  defaults write com.apple.Safari ShowSidebarInTopSites -bool false

  # Disable Safari’s thumbnail cache for History and Top Sites.
  defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

  # Enable Safari’s debug menu.
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

  # Make Safari’s search banners default to Contains instead of Starts With.
  defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

  # Remove useless icons from Safari’s bookmarks bar.
  defaults write com.apple.Safari ProxiesInBookmarksBar "()"

  # Enable the Develop menu and the Web Inspector in Safari.
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

  # Add a context menu item for showing the Web Inspector in web views.
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  # Enable continuous spellchecking.
  defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
  # Disable auto-correct
  defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

  # Disable AutoFill.
  defaults write com.apple.Safari AutoFillFromAddressBook -bool false
  defaults write com.apple.Safari AutoFillPasswords -bool false
  defaults write com.apple.Safari AutoFillCreditCardData -bool false
  defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

  # Warn about fraudulent websites.
  defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

  # Disable plug-ins.
  defaults write com.apple.Safari WebKitPluginsEnabled -bool false
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

  # Disable Java.
  defaults write com.apple.Safari WebKitJavaEnabled -bool false
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

  # Block pop-up windows.
  defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

  # Enable “Do Not Track”.
  defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

  # Update extensions automatically.
  defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

  # -------------------------------------------------------------------------- #
  # Trackpad
  # -------------------------------------------------------------------------- #

  # Features.
  defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int = 0;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadHandResting -bool true;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadHorizScroll -bool true;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadMomentumScroll -bool true;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false;

  # Gestures.
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
  defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1
  defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
  defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2;
  defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2;

  # -------------------------------------------------------------------------- #
  # Keyboard
  # -------------------------------------------------------------------------- #

  # Enable full keyboard access for all controls
  # (e.g. enable Tab in modal dialogs)
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  # -------------------------------------------------------------------------- #
  # Menubar
  # -------------------------------------------------------------------------- #

  # Show battery percentage.
  defaults write com.apple.menuextra.battery ShowPercent -string "YES"

  # Show analog clock.
  defaults write com.apple.menuextra.clock IsAnalog -bool true
  defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
  defaults write com.apple.menuextra.clock DateFormat -string "EEE h:mm a"

  # -------------------------------------------------------------------------- #
  # App Store
  # -------------------------------------------------------------------------- #

  # Enable the WebKit Developer Tools in the Mac App Store.
  defaults write com.apple.appstore WebKitDeveloperExtras -bool true

  # Enable Debug Menu in the Mac App Store.
  defaults write com.apple.appstore ShowDebugMenu -bool true

  # Enable the automatic update check.
  defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

  # Check for software updates daily, not just once per week.
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

  # Download newly available updates in background.
  defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

  # Install System data files & security updates.
  defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

  # Automatically download apps purchased on other Macs.
  defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

  # Turn on app auto-update.
  defaults write com.apple.commerce AutoUpdate -bool true

  # Allow the App Store to reboot machine on macOS updates.
  defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

  # -------------------------------------------------------------------------- #
  # Photos
  # -------------------------------------------------------------------------- #

  # Prevent Photos from opening automatically when devices are plugged in.
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

  # -------------------------------------------------------------------------- #
  # Google Chrome
  # -------------------------------------------------------------------------- #

  # Disable the all too sensitive backswipe on trackpads & mice.
  defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
  defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false

  # Use the system-native print preview dialog.
  defaults write com.google.Chrome DisablePrintPreview -bool true

  # Expand the print dialog by default.
  defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

  # -------------------------------------------------------------------------- #
  # Default Apps
  # -------------------------------------------------------------------------- #

  # Remove apps.
  sudo rm -rf /Applications/GarageBand.app
  sudo rm -rf /Applications/iMovie.app
  sudo rm -rf /Applications/Keynote.app
  sudo rm -rf /Applications/Numbers.app
  sudo rm -rf /Applications/Pages.app

  # Remove settings & resources.
  sudo rm -rf /Library/Application\ Support/GarageBand

  # -------------------------------------------------------------------------- #
  # Finalise
  # -------------------------------------------------------------------------- #

  # Restart affected apps.
  for app in "Contacts" "Dock" "Finder" "Mail" "Photos" "Safari" "SystemUIServer"; do killall "$app" >/dev/null 2>&1; done
fi
