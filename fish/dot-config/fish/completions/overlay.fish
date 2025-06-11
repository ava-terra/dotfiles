# Fish completions for overlay command
complete -c overlay -n "__fish_use_subcommand" -a run -d "Run the video overlay process"
complete -c overlay -n "__fish_use_subcommand" -a fish -d "Generate Fish completions"

# Arguments for 'run' subcommand
complete -c overlay -n "__fish_seen_subcommand_from run" -f -a "(__fish_complete_files '*.mp4;*.mov;*.m4v;*.3gp;*.3g2')" -d "Video file"
complete -c overlay -n "__fish_seen_subcommand_from run" -f -a "(__fish_complete_files '*.png;*.jpg;*.jpeg')" -d "Logo file"
complete -c overlay -n "__fish_seen_subcommand_from run" -l logo-width -r -d "Width of the logo in pixels"
complete -c overlay -n "__fish_seen_subcommand_from run" -l rotate -r -d "Rotation angle in degrees"
complete -c overlay -n "__fish_seen_subcommand_from run" -l logo-x -r -d "X-coordinate for logo"
complete -c overlay -n "__fish_seen_subcommand_from run" -l logo-y -r -d "Y-coordinate for logo"
complete -c overlay -n "__fish_seen_subcommand_from run" -l logo-position -r -a "top-left top-right bottom-left bottom-right" -d "Predefined logo position"
complete -c overlay -n "__fish_seen_subcommand_from run" -l subtitle-font-size -r -d "Font size for subtitles"
complete -c overlay -n "__fish_seen_subcommand_from run" -l subtitle-font -r -d "Font name for subtitles"
complete -c overlay -n "__fish_seen_subcommand_from run" -l subtitle-colour -r -d "Hex colour for subtitle text"
complete -c overlay -n "__fish_seen_subcommand_from run" -l subtitle-outline-colour -r -d "Hex colour for subtitle outline"
complete -c overlay -n "__fish_seen_subcommand_from run" -l subtitle-outline-width -r -d "Width of subtitle outline"
complete -c overlay -n "__fish_seen_subcommand_from run" -l subtitle-alignment -r -a "top centre bottom" -d "Subtitle alignment"
complete -c overlay -n "__fish_seen_subcommand_from run" -l subtitle-margin -r -d "Vertical margin for subtitles"