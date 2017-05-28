command: "$HOME/.bin/net-stats"

refreshFrequency: 5000 # ms

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
    console.log(output)
    usage = (bytes) ->
        kb = bytes / 1024
        usageFormat kb

    usageFormat = (kb) ->
        if kb > 1024
            mb = kb / 1024
            "#{parseInt(mb.toFixed(1))} M"
        else
            "#{parseInt(kb.toFixed(2))} K"

    args = output.split " "

    downBytes = (Number) args[0]
    upBytes = (Number) args[1]

    return output


style: """
  font-family: Inconsolata-dz
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  color: #d3d3d3
  font: 13px Input
  right: 505px
  top: 3px
"""
