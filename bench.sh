#!/bin/bash

WARMUP=3
RUNS=10

run_prettier() {
  local target_dir="$1"
  local config_path="$2"
  local cache_flag="$3"
  # ./node_modules/.bin/prettier --write --experimental-cli "$cache_flag" --config-path "$config_path" "$target_dir/**/*.{js,jsx,ts,tsx}"
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
# 0.4.0 it the latest version but config support is not included yet.
echo "Use the latest oxfmt binary for benchmarking"
cp oxfmt_bin/oxfmt-default node_modules/.pnpm/@oxfmt+darwin-arm64@0.4.0/node_modules/@oxfmt/darwin-arm64/oxfmt
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

echo "=========================================="
echo "🚀 IR transform benchmark: Oxfmt vs Oxfmt"
echo "=========================================="

hyperfine --ignore-failure --warmup $WARMUP --runs $RUNS \
  --prepare 'git reset --hard' \
  --shell=bash \
  './oxfmt_bin/oxfmt-default --config .oxfmtrc.sort.json repos/outline' \
  './oxfmt_bin/oxfmt-3x-transform --config .oxfmtrc.sort.json repos/outline' \
  './oxfmt_bin/oxfmt-5x-transform --config .oxfmtrc.sort.json repos/outline'
echo ""

echo "=========================================="
echo "🚀 TSX detection benchmark: Oxfmt vs Oxfmt"
echo "=========================================="

hyperfine --ignore-failure --warmup $WARMUP --runs $RUNS \
  --prepare 'git reset --hard' \
  --shell=bash \
  './oxfmt_bin/oxfmt-default repos/outline' \
  './oxfmt_bin/oxfmt-tsx  repos/outline'
echo ""

# Clean up
git reset --hard
