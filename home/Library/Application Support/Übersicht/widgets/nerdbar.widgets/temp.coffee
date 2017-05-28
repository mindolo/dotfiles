command: "$HOME/.bin/osx-cpu-temp"

refreshFrequency: 30000 # ms

render: (output) ->
  """
  <div class="temp"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $(".temp span:first-child", el).text("  #{output}")
    $icon = $(".temp span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa fa-thermometer-half")

style: """
  font-family: Inconsolata-dz
  font-family: Lucida Console, Monaco, monospace
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  color: #d3d3d3
  font: 13px Input
  right: 403px
  top: 3px
"""
