#!/usr/bin/env bash
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
  echo "macOS defaults can only be applied on Darwin."
  exit 1
fi

write_default() {
  command defaults "$@" >/dev/null 2>&1 || true
}

plistbuddy_set() {
  /usr/libexec/PlistBuddy -c "$1" "$2" >/dev/null 2>&1 || true
}

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Applying conservative macOS defaults..."

# General UI
sudo nvram SystemAudioVolume=" " >/dev/null 2>&1 || true
write_default write NSGlobalDomain AppleShowScrollBars -string "Always"
write_default write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
write_default write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
write_default write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
write_default write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
write_default write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
write_default write com.apple.LaunchServices LSQuarantine -bool false
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName >/dev/null 2>&1 || true
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true >/dev/null 2>&1 || true
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist >/dev/null 2>&1 || true

# Text input
write_default write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
write_default write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
write_default write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
write_default write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
write_default write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
write_default write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Trackpad and keyboard
write_default write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
write_default -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
write_default write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
write_default write NSGlobalDomain KeyRepeat -int 2
write_default write NSGlobalDomain InitialKeyRepeat -int 15

# Energy saving
sudo pmset -a lidwake 1 >/dev/null 2>&1 || true
sudo pmset -a autorestart 1 >/dev/null 2>&1 || true
sudo pmset -c displaysleep 15 >/dev/null 2>&1 || true
sudo pmset -c sleep 0 >/dev/null 2>&1 || true
sudo pmset -b displaysleep 4 >/dev/null 2>&1 || true
sudo pmset -b sleep 5 >/dev/null 2>&1 || true
sudo pmset -a standbydelay 86400 >/dev/null 2>&1 || true
sudo pmset -a hibernatemode 0 >/dev/null 2>&1 || true

if [ -e /private/var/vm/sleepimage ]; then
  sudo rm /private/var/vm/sleepimage >/dev/null 2>&1 || true
  sudo touch /private/var/vm/sleepimage >/dev/null 2>&1 || true
  sudo chflags uchg /private/var/vm/sleepimage >/dev/null 2>&1 || true
fi

# Screen and screenshots
write_default write com.apple.screensaver askForPassword -int 1
write_default write com.apple.screensaver askForPasswordDelay -int 0
write_default write com.apple.screencapture type -string "png"
write_default write com.apple.screencapture disable-shadow -bool true
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true >/dev/null 2>&1 || true

# Finder
write_default write NSGlobalDomain AppleShowAllExtensions -bool true
write_default write com.apple.finder ShowStatusBar -bool true
write_default write com.apple.finder ShowPathbar -bool true
write_default write com.apple.finder _FXShowPosixPathInTitle -bool true
write_default write com.apple.finder _FXSortFoldersFirst -bool true
write_default write com.apple.finder FXDefaultSearchScope -string "SCcf"
write_default write com.apple.finder FXEnableExtensionChangeWarning -bool false
write_default write com.apple.desktopservices DSDontWriteNetworkStores -bool true
write_default write com.apple.desktopservices DSDontWriteUSBStores -bool true
chflags nohidden "$HOME/Library" >/dev/null 2>&1 || true
xattr -d com.apple.FinderInfo "$HOME/Library" >/dev/null 2>&1 || true
sudo chflags nohidden /Volumes >/dev/null 2>&1 || true
plistbuddy_set "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" "$HOME/Library/Preferences/com.apple.finder.plist"
plistbuddy_set "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" "$HOME/Library/Preferences/com.apple.finder.plist"
plistbuddy_set "Set :StandardViewSettings:IconViewSettings:showItemInfo true" "$HOME/Library/Preferences/com.apple.finder.plist"

# Dock and Mission Control
write_default write com.apple.dock mineffect -string "scale"
write_default write com.apple.dock minimize-to-application -bool true
write_default write com.apple.dock show-process-indicators -bool true
write_default write com.apple.dock launchanim -bool false
write_default write com.apple.dock expose-animation-duration -float 0.1
write_default write com.apple.dock mru-spaces -bool false
write_default write com.apple.dock show-recents -bool false
sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app" >/dev/null 2>&1 || true
sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app" >/dev/null 2>&1 || true

# Safari and WebKit developer ergonomics
write_default write com.apple.Safari AutoOpenSafeDownloads -bool false
write_default write com.apple.Safari ShowFullURLInSmartSearchField -bool true
write_default write com.apple.Safari IncludeDevelopMenu -bool true
write_default write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
write_default write NSGlobalDomain WebKitDeveloperExtras -bool true

# Terminal/TextEdit
write_default write com.apple.terminal StringEncodings -array 4
write_default write com.apple.terminal SecureKeyboardEntry -bool true
write_default write com.apple.Terminal ShowLineMarks -int 0
write_default write com.apple.TextEdit RichText -int 0
write_default write com.apple.TextEdit PlainTextEncoding -int 4
write_default write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Chrome ergonomics
write_default write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
write_default write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
write_default write com.google.Chrome DisablePrintPreview -bool true
write_default write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
write_default write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
write_default write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
write_default write com.google.Chrome.canary DisablePrintPreview -bool true
write_default write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

# Third-party app personal preferences
write_default write com.googlecode.iterm2 PromptOnQuit -bool false
write_default write ~/Library/Preferences/org.gpgtools.gpgmail SignNewEmailsByDefault -bool false
write_default write com.operasoftware.Opera PMPrintingExpandedStateForPrint2 -boolean true
write_default write com.operasoftware.OperaDeveloper PMPrintingExpandedStateForPrint2 -boolean true
write_default write com.irradiatedsoftware.SizeUp StartAtLogin -bool true
write_default write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool false

cp -r init/Preferences.sublime-settings "$HOME/Library/Application Support"/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2>/dev/null || true
cp -r init/spectacle.json "$HOME/Library/Application Support/Spectacle/Shortcuts.json" 2>/dev/null || true

write_default write org.m0k.transmission UseIncompleteDownloadFolder -bool true
write_default write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Documents/Torrents"
write_default write org.m0k.transmission DownloadLocationConstant -bool true
write_default write org.m0k.transmission DownloadAsk -bool false
write_default write org.m0k.transmission MagnetOpenAsk -bool false
write_default write org.m0k.transmission CheckRemoveDownloading -bool true
write_default write org.m0k.transmission DeleteOriginalTorrent -bool true
write_default write org.m0k.transmission WarningDonate -bool false
write_default write org.m0k.transmission WarningLegal -bool false
write_default write org.m0k.transmission BlocklistNew -bool true
write_default write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
write_default write org.m0k.transmission BlocklistAutoUpdate -bool true
write_default write org.m0k.transmission RandomPort -bool true

write_default write com.twitter.twitter-mac AutomaticQuoteSubstitutionEnabled -bool false
write_default write com.twitter.twitter-mac MenuItemBehavior -int 1
write_default write com.twitter.twitter-mac ShowDevelopMenu -bool true
write_default write com.twitter.twitter-mac openLinksInBackground -bool true
write_default write com.twitter.twitter-mac ESCClosesComposeWindow -bool true
write_default write com.twitter.twitter-mac ShowFullNames -bool true
write_default write com.twitter.twitter-mac HideInBackground -bool true
write_default write com.tapbots.TweetbotMac OpenURLsDirectly -bool true

for app in cfprefsd Dock Finder "Google Chrome Canary" "Google Chrome" Opera SizeUp Spectacle SystemUIServer Terminal Transmission Tweetbot Twitter; do
  killall "$app" >/dev/null 2>&1 || true
done

cat <<'EOF'
Done.

Skipped intentionally:
- Dock item resets and hot corners

Review these manually before adding them back.
EOF
