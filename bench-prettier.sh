#!/bin/bash

WARMUP=3
RUNS=10

run_prettier() {
  local target_dir="$1"
  local config_path="$2"
  local cache_flag="$3"
  ./node_modules/.bin/prettier --write --experimental-cli "$cache_flag" --config-path "$config_path" "$target_dir/**/*.{js,jsx,ts,tsx}"
}
export -f run_prettier

run_oxfmt() {
  local target_dir="$1"
  local config_path="$2"
  ./node_modules/.bin/oxfmt --config "$config_path" "$target_dir"
}
export -f run_oxfmt

# ---

echo "=========================================="
echo "👀 Installing dependencies"
echo "=========================================="

pnpm i
echo ""

# ---

echo "=========================================="
echo "🚀 Basic benchmark: Prettier vs Oxfmt"
echo "=========================================="

hyperfine --ignore-failure --warmup $WARMUP --runs $RUNS \
  --prepare 'git reset --hard' \
  --shell=bash \
  'run_prettier repos/outline .prettierrc.json --no-cache' \
  'run_prettier repos/outline .prettierrc.json ""'  \
  'run_oxfmt repos/outline .oxfmtrc.json'
echo ""

echo "=========================================="
echo "🚀 Sort benchmark: Prettier vs Oxfmt"
echo "=========================================="

hyperfine --ignore-failure --warmup $WARMUP --runs $RUNS \
  --prepare 'git reset --hard' \
  --shell=bash \
  'run_prettier repos/outline .prettierrc.sort.json --no-cache' \
  'run_prettier repos/outline .prettierrc.sort.json ""' \
  'run_oxfmt repos/outline .oxfmtrc.sort.json'
echo ""

# Clean up
git reset --hard
