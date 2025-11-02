oxfmt_format() {
  ./node_modules/oxfmt-current/bin/oxfmt "$@"
}
export -f oxfmt_format

oxfmt_napi_format() {
  node ./node_modules/oxfmt-napi/dist/cli.js "$@"
}
export -f oxfmt_napi_format

hyperfine --ignore-failure --warmup 3 --runs 10 \
  --prepare 'git -C outline reset --hard' \
  --shell=bash \
  -n oxfmt -n oxfmt_napi \
  'oxfmt_format outline -c ./bench-oxfmt.json' \
  'oxfmt_napi_format outline -c ./bench-oxfmt.json'
