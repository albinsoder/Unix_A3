# RUN: ./x86-64-driver.sh inputCalcFile.calc
# .s File --> ./lib/inputCalcFile.s
# Executable --> ./bin/inputCalcFile
input="$1"
assemblyDir="./lib/"
sExtension=".s"
binDir="./bin/"
calcPath=$(find . -name $input) # find and store inputFile.calc's path

# Compile inputCalcFile.s to executable assembly program
compileAss() {
    fileName=${input/.calc/""}
    binDir+=$fileName
    gcc -no-pie -fPIC $assemblyDir -o $binDir
}

# Build all needed files and run calc3i.c with its test-file
compileCalc3() {
    # Run makefile
    # make all
    # Run calc3i.exe with testfile and output to ./lib/inputCalcFile.s
    ./bin/calc3i.exe < $calcPath >> $assemblyDir
    compileAss
    echo "Assembly linked and ready"
}

# Write all data to the .s file, prologue, code and epilogue
sFileWriter() {
    # Write the prologue to the assembly file
    cat << EOF >> $assemblyDir
	.data
a:      .quad   0
b:      .quad   0
i:      .quad   0
s:      .quad   0
n:      .quad   0
t:      .quad   0
d:      .quad   0

result: .ascii "%d\n"  
	.text
	.global	main
main:
    pushq   %rbx
EOF
    # Compile calc3i.c with input calc-file into input.s
    compileCalc3
# Append epilogue to input.s
cat << EOF >> $assemblyDir
    popq    $ 0
    exit
EOF
    # Close file descriptor
    exec 3>&-
}

# Create the .s-file
# and provide it with its data
sFileCreator() {
    assemblyDir+=$input # ./lib/input.calc
    assemblyDir=${assemblyDir/.calc/$sExtension} # ./lib/input.s
    if [ -f $assemblyDir ] # If file exists, remove it
    then
        rm $assemblyDir
    fi
    touch $assemblyDir #Touch = create
    # Write assembly-code to the .s file
    sFileWriter

}

# If input file has .calc extension
# -c: Output count of matching lines only
if [ `echo $input | grep -c ".calc" ` -gt 0 ]
then
    # Check permissions for the .calc file
    if [[ -f $calcPath && -x $calcPath && -r $calcPath ]]
    then
        echo "Correct permissions found for file $input"
        # Create the .s-file
        sFileCreator
    else
        echo "Non-existing file and/or not correct permissions"
    fi

else
    echo "Provided file is not a .calc file";
fi
