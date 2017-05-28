command: "ESC=$(printf \"\e\"); df -h / |tail -n+2 | awk '{print $5}'"

refreshFrequency: 3600000

render: (output) ->
  """
  <div class="disk"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $(".disk span:first-child", el).text("  #{output}")
    $icon = $(".disk span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa fa-hdd-o")

style: """
  font-family: Inconsolata-dz
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  color: #d3d3d3
  font: 13px Input
  right: 308px
  top: 3px
"""
