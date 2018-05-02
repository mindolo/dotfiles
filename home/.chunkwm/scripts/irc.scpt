if application "iTerm" is running then
    tell application "iTerm"
        create window with profile "personal_irc"
    end tell
else
    activate application "iTerm"
end if
