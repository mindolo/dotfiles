if application "iTerm" is running then
    tell application "iTerm"
        create window with profile "irssi"
    end tell
else
    activate application "iTerm"
end if
