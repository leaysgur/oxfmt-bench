#!/bin/bash

WARMUP=3
RUNS=30

# ---

echo "=========================================="
echo "🚀 Sort imports benchmark: Oxfmt vs Oxfmt"
echo "=========================================="

hyperfine --ignore-failure --warmup $WARMUP --runs $RUNS \
  --prepare 'git reset --hard' \
  --shell=bash \
  './oxfmt_bin/oxfmt-sort --config .oxfmtrc.json repos/outline' \
  './oxfmt_bin/oxfmt-sort --config .oxfmtrc.sort.json repos/outline' \
  './oxfmt_bin/oxfmt-sort --config .oxfmtrc.sort_ir.json repos/outline'
echo ""

# Clean up
git reset --hard
