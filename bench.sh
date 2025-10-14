#!/bin/bash

./setup.sh

oxfmt_format_sort() {
  ./node_modules/.bin/oxfmt --config .oxfmtrc.sort.json "$@"
}
export -f oxfmt_format_sort

hyperfine --ignore-failure --warmup 3 --runs 10 \
  --prepare 'git reset ./repos' \
  --shell=bash \
  'oxfmt_format outline' \
  'oxfmt_format_sort outline'

