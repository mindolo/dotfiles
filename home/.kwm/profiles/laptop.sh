write_template $PROFILE
MESSAGE+="stopping shiftit, "
stop_shiftit
MESSAGE+='starting kwm, '
restart_kwm
MESSAGE+='reloading khd and Dock. '
restart_khd
killall Dock
MESSAGE+='Cycling spaces...'
notify "${MESSAGE}"
# cycle all the spaces in display
cycle_spaces 0
notify "Space cycling completed. Enjoy."
