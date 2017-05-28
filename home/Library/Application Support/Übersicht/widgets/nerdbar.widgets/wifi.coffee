command: "networksetup -getairportnetwork en0 |head -n +1 |cut -c 24-"

refreshFrequency: 30000 # ms

render: (output) ->
  """
  <div class="wifi"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $icon = $(".wifi span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa #{@icon(output)}")

icon: (output) =>
  if output.match /with an AirPort network./
    $icon = $(".wifi span.icon", el)
    $icon.css("right", "255px")
    return "fa-times"
  else
    return "fa-wifi"

style: """
  font-family: Inconsolata-dz
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  color: #d3d3d3
  font: 13px Input
  right: 253px
  top: 3px
"""
