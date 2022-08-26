#!/bin/bash

def_dir="scrapes"

while getopts ":u:d:" opt; do
  case $opt in
    u) url="$OPTARG"
    ;;
    d) dir="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

if [ -z $url ]
then
  echo "Invalid url; -u argument is missing"
  exit 1
fi

if [ -z $dir ] || [ $dir == $def_dir ] || [ $dir == "./$def_dir" ]
then
  def_dir="./$def_dir"
  if [ ! -d "$def_dir" ]; then
    mkdir "$def_dir"
  fi
  name=$(echo $url | awk -F[/:] '{print $4}')
  dir="$def_dir/$name"
fi

npm run scrape -- --url="$url" --dir="$dir"

echo "$url scraped to $dir :)"
