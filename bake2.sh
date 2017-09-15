#!/bin/sh

set -e
set -o pipefail

Error () {
  echo "err: $@"
  exit 1
}

# idk how to put this into the case such that it fits in with line 34
dirname=$1

case "$1" in
  # thanks to matti
  "install")
    dir=$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )
    target=/usr/local/bin/bake

    if [ ! -e "$target" ]; then
      ln -s $dir/bake $target
      echo "Created symlink in $target"
    else
      echo "Already exists in $target"
      exit 1
    fi
  ;;

  # this probably won't work as script is in /usr/local/bin
  # "update")
  #   git pull
  # ;;

  "$dirname")
    cd ~/dev
    mkdir $dirname 2>&1 >/dev/null || Error "Fuck"
    cd $dirname
  ;;

  *)
    echo " bake
  install         - places in /usr/local/bin
  frontend        - creates HTML/CSS/JS project
  ruby            - creates basic sinatra webapp
    "
      exit 1
    ;;
esac

case "$2" in
  "frontend")
    echo '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="main.css">
  <title>'"$dirname"'</title>
</head>
<body>
  <h1>LOL</h1>
  <script src="main.js"></script>
</body>
</html>' > index.html

  touch main.css
  touch main.js
  ;;

  "ruby")
    echo 'require "sinatra"

get "/" do
  "bonjour"
end
    ' > app.rb

    # how would I echo the ruby output  
    gem install sinatra
    gem install thin
    ruby app.rb
  ;;

  esac
