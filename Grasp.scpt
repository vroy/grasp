set front_app to (path to frontmost application as Unicode text)
tell application front_app
	-- Get the path of the current user and set a few useful paths
        set home_path to POSIX path of (path to home folder as string)
	set screenshots_path to home_path & "Screenshots/"
	set dropbox_path to home_path & "Dropbox/Public/"

        -- @todo Read Dropbox public ID from ENV var
	set dropbox_public_base_url to "http://dl.dropbox.com/u/407791/"

	-- Set the current date and time for later use.
	set now_date to do shell script "date '+%Y-%m-%d'"
	set now_time to do shell script "date '+%Y-%m-%d %H.%M.%S'"

        -- @todo Organize files by directories per day

	-- Run the screencapture command and save the screenshot to the default path.
	set tmp_basename to "Screenshot " & now_time
	set tmp_path to screenshots_path & tmp_basename & ".png"
	do shell script "screencapture -i " & quoted form of tmp_path

        -- Verify if screencapture actually took a file, and if not exit
        tell application "System Events"
             if not (exists file tmp_path) then return
        end tell

	try -- Read the basename of the screenshot from a dialog (default to Screenshot yyyy-mm-dd hh:mm:ss.png)
		display dialog "Screenshot Name" buttons {"Cancel", "OK"} default button 2 default answer tmp_basename with icon 1
		set basename to the text returned of the result
		set basename to basename & ".png"

		-- Rename the tmp file to the entered file.
		set destination to screenshots_path & basename
		do shell script "mv " & quoted form of tmp_path & " " & quoted form of destination
	on error errorMessage
                -- remove file and exit if escaped out of the dialog.
		do shell script "rm " & quoted form of tmp_path
		return
	end try

	try -- Ask to annotate with Preview
		display dialog "Annotate with Preview?" buttons {"Cancel", "OK"} default button 2 with icon 1
	        do shell script "open " & quoted form of destination
	on error errorMessage
		-- ignore
	end try

	try -- Ask to share via dropbox
		display dialog "Share on Dropbox?" buttons {"Cancel", "OK"} default button 2 with icon 1
		do shell script "ln -s " & quoted form of destination & " " & quoted form of (dropbox_path & basename)
		set the clipboard to dropbox_public_base_url & basename
	on error errorMessage
		-- ignore
	end try

end tell
