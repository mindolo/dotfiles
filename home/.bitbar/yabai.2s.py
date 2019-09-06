#!/usr/bin/env python
# -*- coding: utf-8 -*-

# <bitbar.title>Chunkwm</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Matteo Bigoi</bitbar.author>
# <bitbar.dependencies>python</bitbar.dependencies>

import os
import re
import subprocess
import json
import locale

locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')


YABAIRC = os.path.join(os.path.expanduser('~'), '.yabairc')
KARABINERRC = os.path.join(os.path.expanduser('~'), '.config/karabiner/karabiner.json')
DESKTOPSRC = os.path.join(os.path.expanduser('~'), '.chunkwm/desktops.json')


def read_file(path):
    with open(path, 'r') as fd:
        return fd.read()


def get_active_profile():
    content = read_file(YABAIRC)
    search = re.search(r"# active_profile: (\w+)", content)
    if search:
        return search.groups()[0]
    return None


def yabai_query(args):
    yabai_invocation = ['/usr/local/bin/yabai', '-m', 'query']
    yabai_invocation.extend(args)
    results = {}
    try:
       p = subprocess.Popen(yabai_invocation,
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
       stdout, _ = p.communicate()
       if not p.returncode:
           try:
               results = json.loads(stdout)
           except ValueError:
               print "valueerror"
    except Exception as exc:
       print str(exc)

    return results


def get_active_space():
    return yabai_query(['--spaces', '--space'])


def get_active_window():
    return yabai_query(['--windows', '--window'])


def get_active_monitor():
    return yabai_query(['--displays', '--display'])


def get_desktops():
    with open(DESKTOPSRC) as fd:
        return json.load(fd)


active_profile = get_active_profile()
active_space = get_active_space()
active_desktop_name = get_desktops().get('laptop', {}).get(str(active_space['index']))
active_desktop_mode = active_space['type']
active_window = get_active_window()

if active_desktop_mode:
    print('%s - (%s)' % (active_desktop_name, active_desktop_mode))
else:
    print(active_desktop_name)
print('---')
print('Yabai: | color=#ffffff')
print('profile:\t\t\t%s | color=#b0b0b0' % active_profile)
print('window:\t\t\t%s | color=#b0b0b0' % active_window.get('title', 'No active window').encode('utf8'))
print('desktop:\t\t%s - %s (%s) | color=#b0b0b0' %
      (active_space['index'], active_desktop_name, active_space['type']))
print('monitor:\t\t\t%s | color=#b0b0b0' % get_active_monitor()['index'])
