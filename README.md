# yt2ass
Converting Youtube Karaoke Subtitles for Aegisub

To install :
- Add youtube-converter.lua in autoload aegisub folder

Steps to follow :
- convert to ass via YTSubConverter [name of srv3].srv3 [name of desired ass].ass
- Open in Aegisub, menu "Subtitle", "Sort all styles", "Style name"
- Select and delete all lines with YTSoftShadow style
- menu "Edit", "Find and replace" in find put this regexp (?!\{\\c&HD9D9D9&\})\{[^\}]*\} with the tag serving as a color change in my case it is HD9D9D9, check "Use regular expressions" and click on replace all to remove these tags.
- Delete translation lines if present
- select all the lines, menu "automation", "Youtube Converter"
