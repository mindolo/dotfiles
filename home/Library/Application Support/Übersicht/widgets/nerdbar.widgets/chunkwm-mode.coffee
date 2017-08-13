command: "$HOME/.bin/chunkwm-query -p"

refreshFrequency: 60000 # ms

render: (output) ->
  """
  <div class="chunkwm-mode"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $(".chunkwm-mode span:first-child", el).text("  #{output}")
    $icon = $(".chunkwm-mode span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa fa-desktop")

style: """
  font-family: Inconsolata-dz
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  color: #d3d3d3
  font: 13px Input
  height: 16px
  left: 10px
  overflow: hidden
  bottom: 3px
  width: auto
"""
