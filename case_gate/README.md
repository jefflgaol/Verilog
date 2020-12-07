# Case Gate
This is a case statement implementation in a conditional procedural assignment to create a device with behavior:
```
maxterm = 3,7,11,15
```
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