#!/usr/bin/env ruby

require 'fileutils'
require 'pathname'
require 'date'
require 'time'

now = Time.now
$day = now.strftime('%Y-%m-%d')
$time = now.strftime("%Y%m%d%H%M%S")

# @todo move to lib folder
def applescript(*args)
  `/usr/bin/osascript <<-EOF

    tell application "Finder"
        activate
        #{args.join(' ')}
    end tell
EOF`
end

# @todo move to lib folder
def dialog(title, default=nil)
  args = [ %(display dialog "#{title}"),
           'buttons {"Cancel", "OK"}',
           'default button 2' ]
  args << %(default answer "#{default}") if default
  args << 'with icon 1'

  res = applescript(*args)

  return nil if res.to_s.strip.empty?

  text = res.match(/text returned:(.*), button/)[1] rescue nil
  button = res.match(/button returned:(.*)$/)[1] rescue nil

  return text || button
end

`screencapture -i Automatic.png`

# Capture screenshot name
screenshot_name, button = dialog("Screenshot Name", "ScreenShot #{$time}")
exit if !screenshot_name

screenshot_name = "#{screenshot_name}.png"

# Create directory structure to save the new screenshot
screenshots = Pathname.new("/").join("Users", "vincentroy8", "Screenshots", $day)
screenshots.mkpath

backups = Pathname.new("/").join("Users", "vincentroy8", "Screenshots", "backups", $day)
backups.mkpath

dropbox = Pathname.new("/").join("Users", "vincentroy8", "Dropbox", "Public")
dropbox.mkpath

screenshot_path = screenshots.join(screenshot_name)

escaped_screenshot_path = screenshot_path.to_s.gsub(' ', '\ ')
escaped_screenshot_name = screenshot_path.basename.to_s.gsub(' ', '\ ')

FileUtils.mv "Automatic.png", screenshot_path
FileUtils.cp screenshot_path, backups


`open #{escaped_screenshot_path}` if dialog("Annotate?")

if dialog("Share?")
  dropbox_link_path = dropbox.join(escaped_screenshot_name)
  `ln -s #{escaped_screenshot_path} #{dropbox_link_path}`
  `echo 'http://dl.dropbox.com/u/407791/#{screenshot_name}' | pbcopy`
end
