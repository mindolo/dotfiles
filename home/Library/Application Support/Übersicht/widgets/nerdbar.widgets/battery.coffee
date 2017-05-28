command: "pmset -g batt | egrep '([0-9]+\%).*' -o|  cut -f1,2 -d';' |sed 's/%;//'"

refreshFrequency: 120000

render: (output) ->
  """
  <div class="battery"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    bat = parseInt(output)
    $(".battery span:first-child", el).text("  #{@display(output)}%")
    $icon = $(".battery span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa #{@icon(output)}")

display: (output) ->
    split = output.split ' '
    charge = split[0]
    if charge == "100"
      charge="99"
    return charge

icon: (output) =>
  split = output.split ' '

  charge = split[0]
  status = split[1]

  return if status in ["charging\n", "charged\n"]
    "fa-plug"
  else if charge > 90
    "fa-battery-full"
  else if charge > 70
    "fa-battery-three-quarters"
  else if charge > 40
    "fa-battery-half"
  else if charge > 20
    "fa-battery-quarter"
  else
    "fa-battery-empty"

style: """
  font-family: Inconsolata-dz
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  font: 13px Input
  top: 3px
  right: 183px
  color: #d3d3d3
"""
