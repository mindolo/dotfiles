# notify via system notification everything passed to the function
function notify {
  local to_send=$@
  terminal-notifier -title kwm -sender com.apple.systempreferences -message $"${to_send}"
}

# write .khdrc and .kwm/kwmrc file using a simple variable substitution
function write_template {
  local target=$1
  sed "s/__PROFILE__/${target}.kwm/g" ${KWM_CONFIG_TEMPLATE} | tee ${KWM_CONFIG_FILE} > /dev/null
  cat ${KHD_CONFIG_TEMPLATE} ${PROFILE_DIR}/${target}.khd | tee ${KHD_CONFIG_FILE} > /dev/null
}

# stop khd
function stop_khd {
  set +e
  brew services stop khd >/dev/null 2>&1
  if ! $(pgrep khd >/dev/null 2>&1); then
    killall -9 khd >/dev/null 2>&1
  fi
  set -e
}

# stop kwm
function stop_kwm {
  set +e
  brew services stop kwm >/dev/null 2>&1
  if ! $(pgrep kwm >/dev/null 2>&1); then
    killall -9 kwm >/dev/null 2>&1
  fi
  set -e
}

# stop shiftit
function stop_shiftit {
  set +e
  if ! $(pgrep ShiftIt >/dev/null 2>&1); then
    killall -9 ShiftIt >/dev/null 2>&1
  fi
  set -e
}

# restart khd
function restart_khd {
  khd -e "reload" >/dev/null 2>&1 || brew services start khd >/dev/null 2>&1
}

# restart kwm
function restart_kwm {
  set +e
  brew services restart kwm >/dev/null 2>&1
  # block until kwm is actually restarted
  while ! $(kwmc query space list >/dev/null 2>&1) ; do
    sleep 0.1
  done
  set -e
}

# start shiftit
function start_shiftit {
  if [ -z "$(pgrep ShiftIt)" ]; then
    open /Applications/ShiftIt.app
  fi
}

#prettyprint profiles, one per line
function pretty_profiles {
  local to_print=${@}

  for item in ${to_print}; do
    echo -e "\t * ${item}"
  done
}

# sets RESTORE_SPACE, either as the active space when kwm-profile was invoked
# or to the first space on the first display
function set_restore_space {
  set +e
  local active_space=$(kwmc query space active name)
  set -e
  RESTORE_SPACE="1"

  case ${active_space} in
    '[no tag]')
      RESTORE_SPACE="1"
    ;;
    'Connection failed!')
      RESTORE_SPACE="1"
    ;;
    *)
      RESTORE_SPACE=${active_space}
  esac
}

function cycle_spaces {
  local display=${1}

  kwmc display -f ${display}
  # cycle the spaces
  kwmc query space list | \
    cut -d',' -f 1 | \
    xargs -n 1 -I {} -- sh -c "kwmc space -fExperimental {}; sleep 0.5"
  # refocus on saved display
  kwmc space -fExperimental $RESTORE_SPACE
}

# notifies the user and starts the correct profile script
function switch_profile {
    local dst_name=$1
    local dst_script=${PROFILE_DIR}/${1}.sh
    notify "Switch to \`${dst_name}\` initiated..."
    # if any, get the space to restore to.
    set_restore_space
    source ${dst_script}
    notify "Profile switch completed. Enjoy."
}
