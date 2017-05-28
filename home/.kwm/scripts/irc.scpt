if application "iTerm" is running then
    tell application "iTerm"
        create window with profile "irc"
    end tell
else
    activate application "iTerm"
end if
