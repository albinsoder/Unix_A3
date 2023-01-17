# Project3Unix Assembly

## Implemented:
* Looptest
* Pi
* Harmonic

## Extra Function:
* GCD

## Compile:
```
$ cd Project3Unix

$ make all

$ make clean all

$ ./x86-64-driver.sh desiredCalcFile.calc
```

## Run:
```
$ cd Project3Unix/bin

$ ./desiredCalcFile
```

## .s Files
The generated .s files are stored in the /lib directory 


## Fixed after feedback


DONE - You should not call make in the driver. 

DONE - "ret" is not allowed to exit the program. You should use a syscall or call "exit", so it return an exit code. 

DONE - I should not need to change paths in your driver to be able to compile a script. It should be possible to write "./x86-64-driver.sh example.calc" with any .calc file. They should not need to be in the testprogs folder. 

DONE - The compiler can't compile the "pi.calc" test file. This file should be possible to compile to be given a passing grade.

DONE - The "looptest.calc" do not produce the correct output. It outputs only 1s in a loop that never ends. 

DONE - 

DONE - You should follow the basic folder structure as stated in the assignment instructions.

DONE - Your symbol table is too small. You know from the instruction that the ".calc" language can only have single characters as variable names. Meaning you know the maximum number of variables in the language. 

DONE - An internal test file was not able to be compiled.

DONE - You have not implemented one of the three functions, which is a requirement for a passing grade (it is not enough just to use a previous value for "gcd". You need to implement the function in assembly).

UNCHANGED - I needed to change your "calcPath" to the following: "./$input", for it to work correctly