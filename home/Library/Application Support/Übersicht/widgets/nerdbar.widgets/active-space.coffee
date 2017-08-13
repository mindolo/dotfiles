command: "$HOME/.bin/chunkwm-query -d"

refreshFrequency: 1000

render: (output) ->
  """
  <div class="ac"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $(".ac span:first-child", el).text("  #{output}")
    $icon = $(".ac span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa #{@icon(output)}")

icon: (output) =>
    return if output == "terminal\n"
        "fa-terminal"
    else if output == "personal_irc\n"
        "fa-commenting"
    else if output == "personal_web\n"
        "fa-chrome"
    else if output == "work_irc\n"
        "fa-commenting"
    else if output == "work_web\n"
        "fa-chrome"
    else if output == "email\n"
        "fa-envelope"
    else if output == "mutt\n"
        "fa-envelope"
    else if output == "calendar\n"
        "fa-calendar"
    else if output == "conference\n"
        "fa-video-camera"
    else if output == "development\n"
        "fa-list-alt"
    else
        "fa-superpowers"

style: """
  font-family: Inconsolata-dz
  -webkit-font-smoothing: antialiased
  text-overflow: ellipsis
  color: #d3d3d3
  font: 13px Input
  height: 16px
  left: 10px
  overflow: hidden
  top: 3px
  width: auto
"""
