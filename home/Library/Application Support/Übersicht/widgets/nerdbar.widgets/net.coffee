command: "$HOME/.bin/net-stats"

refreshFrequency: 1000 # ms

render: (output) ->
  """
  <div class="net"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $(".net span:first-child", el).text("  #{@display(output)}")
    $icon = $(".net span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa fa-cloud-download")

display: (output) =>
    args = output.split " "
    return "⬇︎" + args[0] + " ⬆︎"+args[1]

style: """
  font-family: Inconsolata-dz
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  color: #d3d3d3
  font: 13px Input
  right: 505px
  top: 3px
"""
