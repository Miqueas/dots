function fish_prompt
  set -l s $status
  set -l u $USER
  set -l h $hostname
  set -l cwd (string replace $HOME '~' (pwd))
  set -l uid (id -u)
  set -l pchar "\$"
  set -l branch
  set -l btemplate

  set -l b  (set_color -o)
  set -l r  (set_color normal)
  set -l c1 (set_color -o blue)
  set -l c2 (set_color -o red)
  set -l c3 (set_color -o yellow)
  set -l c4 (set_color -o green)
  set -l c5 (set_color -o cyan)
  set -l c6 (set_color -o magenta)

  [ $uid -eq 0 ]; and set pchar '#'
  [ (jobs) ]; and set pchar "+ $pchar"

  set -l utemplate $b'['$r$c1"$u"$r$b']'$r
  [ $uid -eq 0 ]; and set utemplate $b'['$c2"$u"$r$b']'$r

  set -l htemplate $b'('$r$c3"$h"$r$b')'$r
  set -l stemplate $b'{'$r$c4"$s"$r$b'}'$r
  [ ! $s -eq 0 ]; and set stemplate $b'{'$r$c2"$s"$r$b'}'$r
  set -l ptemplate $c5' in '$r$b"'$cwd'"$r
  set -l ctemplate $b"$pchar"$r

  if [ -d .git ]; or git rev-parse --git-dir 2> /dev/null
    set cwd (basename (pwd))
    set branch (git branch --show-current)
    set btemplate $c6"$branch"$r
    set ptemplate $c5' in '$r$b"'$cwd:$btemplate$b'"$r
  end

  echo -s ''
  echo -s $utemplate ':' $htemplate ' ' $stemplate $ptemplate
  echo -s $ctemplate ' '
end
