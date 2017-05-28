write_template ${PROFILE}
MESSAGE+="stopping kwm, "
stop_kwm
MESSAGE+="starting shiftit."
start_shiftit
notify "${MESSAGE}"

