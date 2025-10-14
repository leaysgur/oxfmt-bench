#!/bin/bash

WARMUP=3
RUNS=30

# ---

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
