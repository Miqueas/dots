function fish_prompt
  set -l s $status
  
  set -l d  (set_color --dim)
  set -l b  (set_color --bold)
  set -l i  (set_color --italics)
  set -l r  (set_color --reverse)
  set -l u  (set_color --underline)
  set -l c0 (set_color normal)
  set -l c1 (set_color blue)
  set -l c2 (set_color cyan)
  set -l c3 (set_color green)
  set -l c4 (set_color magenta)
  set -l c5 (set_color red)
  set -l c6 (set_color yellow)

  set -l pwd (pwd)
  set -l cwd (string replace $HOME '~' $pwd)
  set -l uid (id -u)
  set -l pchar "»"

  set -l time (printf "$b$c1%s$c0" (date "+%H:%M"))
  set -l last (printf "$b$c6%s$c0" (echo $CMD_DURATION | humanize_duration))

  set -l l1 " $time $d∷$c0 $last"
  set -l l2 " $b%s$c0"
  set -l l3 " $b%s$pchar$c0 "

  if set -q MSYSTEM
    set l3 (printf $l3 "$MSYSTEM %s")
  end
  
  if [ $s -eq 0 ]
    set l3 (printf $l3 "")
  else
    set l3 (printf $l3 "$c5$s ")
  end

  if [ -d .git ]; or [ (git rev-parse --git-dir 2> /dev/null) ]
    set -l branch
    set -l rootDir (git rev-parse --show-toplevel)
    # this will show the current directory like: $rootDir/subdir/anotherDir and so
    set cwd (basename $rootDir)(string replace $rootDir '' $pwd)

    if not [ -z (git branch --show-current) ]
      set branch (git branch --show-current)
    else
      set branch (git rev-parse --short HEAD)
    end

    set l2 (printf "$d git[$c0$b$c3$branch$c0$d] $d@$c0$l2" $c4$cwd)
  else
    set l2 (printf $l2 $cwd)
  end

  echo
  echo -s $l1
  echo -s $l2
  echo -s $l3
end