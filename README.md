# oxfmt-bench

My personal experimental benchmark playground for `oxfmt`.

## oxfmt_bin

`oxfmt@latest` doesn't support config yet, so using a locally built version.

Hash: 92e1748a3beb8f9998c3f46726b3a773b84b0c0c

And also there are some tweaked version for benchmark.

- default: Default release build
- 3x-transform: Repeats the IR sorting process in `sort-imports` 2 additional times (3 times total)
- 5x-transform: Repeats the IR sorting process in `sort-imports` 4 additional times (5 times total)
- tsx: Performs `source_text.contain("/>")` to detect JSX in `.ts` files

## Results

### ./bench-prettier.sh

```
==========================================
🚀 Basic benchmark: Prettier vs Oxfmt
==========================================
Benchmark 1: run_prettier repos/outline .prettierrc.json --no-cache
  Time (mean ± σ):      5.533 s ±  0.064 s    [User: 11.739 s, System: 2.011 s]
  Range (min … max):    5.456 s …  5.671 s    10 runs

Benchmark 2: run_prettier repos/outline .prettierrc.json ""
  Time (mean ± σ):      4.776 s ±  0.071 s    [User: 12.331 s, System: 1.467 s]
  Range (min … max):    4.622 s …  4.869 s    10 runs

Benchmark 3: run_oxfmt repos/outline .oxfmtrc.json
  Time (mean ± σ):     125.5 ms ±   3.0 ms    [User: 294.1 ms, System: 227.6 ms]
  Range (min … max):   119.7 ms … 130.2 ms    10 runs

Summary
  run_oxfmt repos/outline .oxfmtrc.json ran
   38.06 ± 1.07 times faster than run_prettier repos/outline .prettierrc.json ""
   44.09 ± 1.17 times faster than run_prettier repos/outline .prettierrc.json --no-cache

==========================================
🚀 Sort benchmark: Prettier vs Oxfmt
==========================================
Benchmark 1: run_prettier repos/outline .prettierrc.sort.json --no-cache
  Time (mean ± σ):      5.994 s ±  0.050 s    [User: 18.721 s, System: 2.668 s]
  Range (min … max):    5.938 s …  6.089 s    10 runs

Benchmark 2: run_prettier repos/outline .prettierrc.sort.json ""
  Time (mean ± σ):      5.632 s ±  0.073 s    [User: 26.397 s, System: 2.953 s]
  Range (min … max):    5.537 s …  5.788 s    10 runs

Benchmark 3: run_oxfmt repos/outline .oxfmtrc.sort.json
  Time (mean ± σ):     145.7 ms ±   3.2 ms    [User: 360.3 ms, System: 263.0 ms]
  Range (min … max):   143.0 ms … 153.2 ms    10 runs

Summary
  run_oxfmt repos/outline .oxfmtrc.sort.json ran
   38.65 ± 0.98 times faster than run_prettier repos/outline .prettierrc.sort.json ""
   41.13 ± 0.96 times faster than run_prettier repos/outline .prettierrc.sort.json --no-cache
```

### ./bench-oxfmt.sh

```
==========================================
🚀 IR transform benchmark: Oxfmt vs Oxfmt
==========================================
Benchmark 1: ./oxfmt_bin/oxfmt-default --config .oxfmtrc.json repos/outline
  Time (mean ± σ):     107.2 ms ±   4.7 ms    [User: 332.4 ms, System: 302.4 ms]
  Range (min … max):    95.3 ms … 115.5 ms    30 runs

Benchmark 2: ./oxfmt_bin/oxfmt-default --config .oxfmtrc.sort.json repos/outline
  Time (mean ± σ):     113.1 ms ±   4.2 ms    [User: 371.6 ms, System: 307.5 ms]
  Range (min … max):   105.2 ms … 123.3 ms    30 runs

Benchmark 3: ./oxfmt_bin/oxfmt-3x-transform --config .oxfmtrc.sort.json repos/outline
  Time (mean ± σ):     126.2 ms ±  16.8 ms    [User: 423.8 ms, System: 312.0 ms]
  Range (min … max):   113.2 ms … 181.1 ms    30 runs

  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet system without any interferences from other programs.

Benchmark 4: ./oxfmt_bin/oxfmt-5x-transform --config .oxfmtrc.sort.json repos/outline
  Time (mean ± σ):     142.4 ms ±  28.1 ms    [User: 484.3 ms, System: 319.4 ms]
  Range (min … max):   125.2 ms … 259.1 ms    30 runs

  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet system without any interferences from other programs.

Summary
  ./oxfmt_bin/oxfmt-default --config .oxfmtrc.json repos/outline ran
    1.06 ± 0.06 times faster than ./oxfmt_bin/oxfmt-default --config .oxfmtrc.sort.json repos/outline
    1.18 ± 0.17 times faster than ./oxfmt_bin/oxfmt-3x-transform --config .oxfmtrc.sort.json repos/outline
    1.33 ± 0.27 times faster than ./oxfmt_bin/oxfmt-5x-transform --config .oxfmtrc.sort.json repos/outline

==========================================
🚀 TSX detection benchmark: Oxfmt vs Oxfmt
==========================================
Benchmark 1: ./oxfmt_bin/oxfmt-default repos/outline
  Time (mean ± σ):      87.0 ms ±   1.6 ms    [User: 284.3 ms, System: 239.0 ms]
  Range (min … max):    84.6 ms …  92.1 ms    30 runs

Benchmark 2: ./oxfmt_bin/oxfmt-tsx  repos/outline
  Time (mean ± σ):      95.2 ms ±  14.9 ms    [User: 284.2 ms, System: 240.1 ms]
  Range (min … max):    84.1 ms … 124.9 ms    30 runs

  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet system without any interferences from other programs.

Summary
  ./oxfmt_bin/oxfmt-default repos/outline ran
    1.09 ± 0.17 times faster than ./oxfmt_bin/oxfmt-tsx  repos/outline
```

### ./bench-oxfmt-sort.sh
```
==========================================
🚀 Sort imports benchmark: Oxfmt vs Oxfmt
==========================================
Benchmark 1: ./oxfmt_bin/oxfmt-sort --config .oxfmtrc.json repos/outline
  Time (mean ± σ):     100.9 ms ±  16.0 ms    [User: 251.5 ms, System: 224.5 ms]
  Range (min … max):    87.0 ms … 155.1 ms    30 runs

Benchmark 2: ./oxfmt_bin/oxfmt-sort --config .oxfmtrc.sort.json repos/outline
  Time (mean ± σ):     109.8 ms ±  23.8 ms    [User: 264.0 ms, System: 233.4 ms]
  Range (min … max):    87.7 ms … 179.3 ms    30 runs

Benchmark 3: ./oxfmt_bin/oxfmt-sort --config .oxfmtrc.sort_ir.json repos/outline
  Time (mean ± σ):     115.2 ms ±  21.4 ms    [User: 262.2 ms, System: 236.9 ms]
  Range (min … max):    96.4 ms … 167.5 ms    30 runs

Summary
  ./oxfmt_bin/oxfmt-sort --config .oxfmtrc.json repos/outline ran
    1.09 ± 0.29 times faster than ./oxfmt_bin/oxfmt-sort --config .oxfmtrc.sort.json repos/outline
    1.14 ± 0.28 times faster than ./oxfmt_bin/oxfmt-sort --config .oxfmtrc.sort_ir.json repos/outline
```
