oxfmt_current() {
  ./node_modules/oxfmt-current/bin/oxfmt "$@"
}
export -f oxfmt_current

oxfmt_napi() {
  node ./node_modules/oxfmt-napi/dist/cli.js "$@"
}
export -f oxfmt_napi

# ---

echo "# Compare architecture, just print versions"
hyperfine --ignore-failure --warmup 3 --runs 10 \
  --shell=bash \
  -n oxfmt_current -n oxfmt_napi \
  'oxfmt_current -V' \
  'oxfmt_napi -V'
echo ""

echo "# Compare performance on formatting outline repo with disabling embedded formatting"
hyperfine --ignore-failure --warmup 3 --runs 10 \
  -C 'git reset --hard' \
  --shell=bash \
  -n oxfmt_current -n oxfmt_napi \
  'oxfmt_current ./repos/outline -c ./bench-oxfmt.json' \
  'oxfmt_napi ./repos/outline -c ./bench-oxfmt.json'
echo ""

# Latest napi version is significantly slower than current Rust version,
# - even though embedded formatting is disabled.
# - even though there is no embedded code.
# - even though disabling napi feature at build time.
