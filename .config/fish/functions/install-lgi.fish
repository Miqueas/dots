function install-lgi
  set -l versions 5.{1,2,3,4}

  mkdir -p $HOME/Repos
  cd $HOME/Repos
  rm -rf lgi
  git clone https://github.com/lgi-devs/lgi
  cd lgi

  for v in $versions
    rm -rf _BUILD
    meson setup . _BUILD -Dprefix=/usr -Dlua-{pc,bin}=lua$v
    ninja -C _BUILD
    sudo ninja -C _BUILD install
  end

  cd $HOME
end