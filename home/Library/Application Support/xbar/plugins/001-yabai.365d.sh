#!/usr/bin/env bash
# <xbar.title>Yabai minimal status</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>mindolo</xbar.author>
# <xbar.author.github>mindolo</xbar.author.github>
# <xbar.desc>Yabai minimal status plugin
# To ensure autoupdates add the following to your yabai config
#```
#  yabai -m signal --add event=space_changed \
#      action="set SHELL=/bin/sh && open -g \"xbar://app.xbarapp.com/refreshPlugin?path=001-yabai.365d.sh\""
#  yabai -m signal --add event=window_resized \
#      action="set SHELL=/bin/sh && open -g \"xbar://app.xbarapp.com/refreshPlugin?path=001-yabai.365d.sh\""
#  yabai -m signal --add event=window_focused \
#      action="set SHELL=/bin/sh && open -g \"xbar://app.xbarapp.com/refreshPlugin?path=001-yabai.365d.sh\""
#  yabai -m signal --add event=application_activated \
#      action="set SHELL=/bin/sh && open -g \"xbar://app.xbarapp.com/refreshPlugin?path=001-yabai.365d.sh\""
#```
# Spaces should be labeled in yabai.
# </xbar.desc>
# <xbar.dependencies>bash,yabai,jq</xbar.dependencies>

PATH=$PATH:/opt/homebrew/bin

# Get space metadata
space_info=$(yabai -m query --spaces --space || echo "off")

if [ "$space_info" = "off" ]; then
    echo "Yabai Not Running"
    exit 1
else
    eval $(echo $space_info | jq -r '@sh "label=\(.label) tiling_type=\(.type) space_index=\(.index) window_count=\(.windows | length) display_id=\(.display)"')
    echo "$label - ($tiling_type)"
    echo "---"
    echo "Yabai:"
    echo "\tWindow count: $window_count"
    echo "\tDisplay: $display_id"
    echo "\tSpace index: $space_index"
fi
