tell application "Finder"
    try
        target of window 1
        make new Finder window to result
    on error
        make new Finder window to home
    end try
end tell
