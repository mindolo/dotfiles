command: "ESC=$(printf \"\e\"); ps -A -o %mem | awk '{s+=$1} END {a=sprintf(\"%.0f\", s); print a \"%\"}'"

refreshFrequency: 30000 # ms

render: (output) ->
  """
  <div class="mem"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $(".mem span:first-child", el).text("  #{output}")
    $icon = $(".mem span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa fa-pie-chart")

style: """
  font-family: Inconsolata-dz
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  color: #d3d3d3
  font: 13px Input
  right: 356px
  top: 3px
"""
