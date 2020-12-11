# Computer Architecture 8-Bit
This is an implementation of computer architecture (8-bit) based on Quick Start Guide to Verilog by Brock J. LaMeres.

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