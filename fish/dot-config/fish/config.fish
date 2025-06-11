# Fish Shell Configuration File

set fish_greeting $TERM

# Environment variables
set -gx EDITOR nvim
set -gx BROWSER firefox
set -gx TERMINAL ghostty

set -gx GOPATH ~/.local/go
#set -gx GOROOT /usr/local/go
#
#set -gx CONDA_ROOT ~/.local/anaconda3
set -gx CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1
# Binary search locations. These are prepended in order.  
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fish_add_path ~/.local/bin ~/.cargo/bin $GOPATH/bin
fish_add_path ~/.fzf/bin


# Commands to run in interactive sessions go here
if status is-interactive
  
  # Abbreviations
  abbr mkcv pandoc cv-peter-colebourne.md -o (date +%Y-%m-%d)_cv.pdf \
                                          -V geometry:margin=2cm
  abbr ls eza
  abbr cd z
  abbr nv nvim
  abbr y yazi
  abbr cat bat
  abbr m aerc
  abbr xc 'xclip --selection clip'
  abbr xco 'xclip -o -sel clip'
  abbr lt eza -lT
  abbr la eza -la
  abbr cm chezmoi
  abbr md mkdir -p
  abbr v nvim

  # Loop through all files in the ~/.config/fabric/patterns directory
  for pattern_file in $HOME/.config/fabric/patterns/*
      # Get the base name of the file (i.e., remove the directory path)
      set pattern_name (basename $pattern_file)

      # Create an abbreviation in the form: abbr pattern_name "fabric --pattern pattern_name"
      abbr -a $pattern_name "fabric --pattern $pattern_name"
  end

  function yt
      if test (count $argv) -eq 0 -o (count $argv) -gt 2
          echo "Usage: yt [-t | --timestamps] youtube-link"
          echo "Use the '-t' flag to get the transcript with timestamps."
          return 1
      end

      set transcript_flag "--transcript"
      if test "$argv[1]" = "-t" -o "$argv[1]" = "--timestamps"
          set transcript_flag "--transcript-with-timestamps"
          set argv $argv[2..-1]
      end
      set video_link $argv[1]
      fabric -y $video_link $transcript_flag
  end


  # Integrations (checking they exist first)
  if type -q fzf; fzf --fish | source; end
  if type -q zoxide; zoxide init fish | source; end
  if type -q starship; starship init fish | source; end

  # run tmux if installed and not already running
  if type -q tmux
    if not test -n "$TMUX"
      #tmux attach-session -t default; or tmux new-session -s default
    end
  end
end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/monkey/.local/anaconda3/bin/conda
    eval /home/monkey/.local/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/monkey/.local/anaconda3/etc/fish/conf.d/conda.fish"
        . "/home/monkey/.local/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/monkey/.local/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

