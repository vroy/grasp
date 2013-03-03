set front_app to (path to frontmost application as Unicode text)
tell application front_app
	-- Get the path of the current user and set a few useful paths
        set home_path to POSIX path of (path to home folder as string)
	set screenshots_path to home_path & "Screenshots/"

	-- Set the current date and time for later use.
	set now_time to do shell script "date '+%Y%m%d%H%M%S'"

	-- Run the screencapture command and save the screenshot to the default path.
	set filename to "Screenshot-" & now_time & ".png"
	set full_path to screenshots_path & filename
	do shell script "screencapture -i " & quoted form of full_path

        -- Verify if screencapture actually took a file, and if not exit
        tell application "System Events"
             if not (exists file full_path) then return
        end tell

        do shell script "scp " & quoted form of full_path & " " & "vince@vroy.ca:~/screenshots/"

        set share_url to "http://share.vroy.ca/" & filename
        set the clipboard to share_url

        return share_url
end tell
