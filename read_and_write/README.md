# Read and Write
This is a demo of read and write functionality to create a device with behavior:
```
maxterm = 1,9,11,13
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