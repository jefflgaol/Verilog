# Counter Clock Based
This is a counter using a single procedural block, instead of using several states.

## How to compile?
```
$ iverilog -o main.vvp main.v
```

## How to observe output?
```
$ vvp main.vvp
$ gtkwave <<dumpfile name>>.vcd
```
## Timing diagram
![Timing](screenshot.png)