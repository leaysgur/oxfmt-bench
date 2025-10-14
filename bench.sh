#!/bin/bash

echo "Use the latest oxfmt binary for benchmarking"
cp oxfmt_bin/oxfmt-default node_modules/.pnpm/@oxfmt+darwin-arm64@0.4.0/node_modules/@oxfmt/darwin-arm64/oxfmt

run_prettier() {
  ./node_modules/.bin/prettier --write --experimental-cli --no-cache --config-path ./prettierrc 'repos/outline/**/*.{js,jsx,ts,tsx}'
}
export -f run_prettier

run_oxfmt() {
  ./node_modules/.bin/oxfmt --config .oxfmtrc.json repos/outline
}
export -f oxfmt_format_sort

hyperfine --ignore-failure --warmup 1 --runs 10 \
  --prepare 'git reset ./repos' \
  --shell=bash \
  'run_prettier' \
  'run_oxfmt'

