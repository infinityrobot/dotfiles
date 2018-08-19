# Display / hide hidden files
alias show_hidden="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hide_hidden="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

# Enable / disable screenshot shadow
alias enable_screenshot_shadow="defaults write com.apple.screencapture disable-shadow NO; killall SystemUIServer"
alias disable_screenshot_shadow="defaults write com.apple.screencapture disable-shadow YES; killall SystemUIServer"

# Enable / disable text selection in QuickLook
alias enable_ql_text_selection="defaults write com.apple.finder QLEnableTextSelection YES; killall Finder"
alias disable_ql_text_selection="defaults write com.apple.finder QLEnableTextSelection NO; killall Finder"

# Get IP addresses
alias get_local_ip="ipconfig getifaddr en0"
alias get_external_ip="curl ipecho.net/plain; echo"

# Enable / disable Dashboard
alias disable_dashboard="defaults write com.apple.dashboard mcx-disabled YES; killall Dock"
alias enable_dashboard="defaults write com.apple.dashboard mcx-disabled NO; killall Dock"

# Print the path
alias path="echo $PATH | tr -s ':' '\n'"

# Restarts.
alias restart_dock="killall Dock"
alias restart_finder="killall Finder"
alias restart_ui="killall SystemUIServer"
