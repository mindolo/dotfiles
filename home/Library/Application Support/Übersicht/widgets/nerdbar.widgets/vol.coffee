command: "osascript -e 'get volume settings' 2> /dev/null |awk '{print $2\" \"$8}' |cut -d':' -f2,3 |sed 's/, muted:/ /'"

refreshFrequency: 30000 # ms

render: (output) ->
  """
  <div class="vol">
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $icon = $(".vol span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa #{@icon(output)}")

icon: (output) =>
    split = output.split ' '
    volume = split[0]
    muted = split[1]
    return if muted == "true\n"
        "fa-volume-off"
    else if volume > 50
        "fa-volume-up"
    else
      "fa-volume-down"

style: """
  font-family: Inconsolata-dz
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  color: #d3d3d3
  font: 13px Input
  font-weight: Bold
  right: 236px
  top: 3px
"""
