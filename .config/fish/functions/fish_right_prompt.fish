function fish_right_prompt
  set -l last_cmd_duration (echo $CMD_DURATION | humanize_duration)
  set -l time (date "+%I:%M %P")

  set -l c0 (set_color normal)
  set -l c1 (set_color yellow)

  set -l DurationTemplate $c1"$last_cmd_duration"$c0
  set -l TimeTemplate "$time"

  echo $DurationTemplate $TimeTemplate
end
