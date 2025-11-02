# oxfmt-bench

> [!CAUTION]
> This is my personal experimental benchmark playground for `oxfmt`.

## ./bench-oxfmt.sh

```
# Compare architecture, just print versions
Benchmark 1: oxfmt_current
  Time (mean ± σ):      24.6 ms ±   0.3 ms    [User: 19.3 ms, System: 5.0 ms]
  Range (min … max):    24.2 ms …  25.1 ms    10 runs

Benchmark 2: oxfmt_napi
  Time (mean ± σ):      47.1 ms ±   0.4 ms    [User: 43.7 ms, System: 6.9 ms]
  Range (min … max):    46.7 ms …  47.6 ms    10 runs

Summary
  oxfmt_current ran
    1.91 ± 0.03 times faster than oxfmt_napi

# Compare performance on formatting outline repo with disabling embedded formatting
Benchmark 1: oxfmt_current
  Time (mean ± σ):      67.3 ms ±   1.6 ms    [User: 261.5 ms, System: 62.7 ms]
  Range (min … max):    65.3 ms …  70.3 ms    10 runs

Benchmark 2: oxfmt_napi
  Time (mean ± σ):     437.3 ms ±   1.7 ms    [User: 2942.4 ms, System: 84.5 ms]
  Range (min … max):   434.8 ms … 439.1 ms    10 runs

Summary
  oxfmt_current ran
    6.50 ± 0.16 times faster than oxfmt_napi
```
