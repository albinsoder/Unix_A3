# RUN: ./x86-64-driver.sh inputCalcFile.calc
# .s File --> ./assembly_files/inputCalcFile.s
# Executable --> ./bin/inputCalcFile
input="$1"
calcPwd="./testprogs/"
assemblyDir="./assembly_files/"
sExtension=".s"
binDir="./bin/"

# Compile inputCalcFile.s to executable assembly program
compileAss() {
    fileName=${input/.calc/""}
    binDir+=$fileName
    gcc -no-pie -fPIC $assemblyDir -o $binDir
}

# Build all needed files and run calc3b.c with its test-file
compileCalc3() {
    # Run makefile
    make all
    echo "Make completed"
    # Run calc3b.exe with testfile and output to ./assembly_files/inputCalcFile.s
    ./bin/calc3b.exe < ./lexyacc-code_lab3/test >> ./assembly_files/gcd.s
    compileAss
}

sFileWriter() {
    # Write the prologue to the assembly file
    cat << EOF >> $assemblyDir
	.data
sum:	.quad	0
a:      .quad   0
b:      .quad   0
format: .ascii "Result: %d\n"  
	.text
	.global	main
main:
EOF
    # Compile calc3b.c with input calc-file into input.s
    compileCalc3
# Append epilogue to input.s
cat << EOF >> $assemblyDir
	ret
EOF
    # Close file descriptor
    exec 3>&-
}

# Create the .s-file
# and provide it with its data
sFileCreator() {
    assemblyDir+=$input # ./assembly_files/input.calc
    assemblyDir=${assemblyDir/.calc/$sExtension} # ./assembly_files/input.s
    echo "$assemblyDir"
    if [ -f $assemblyDir ] # If file exists, remove it
    then
        rm $assemblyDir
        echo "Removed $assemblyDir"
    fi
    # Create the assembly file
    touch $assemblyDir
    echo "Created new $assemblyDir"
    # Write assembly-code to the .s file
    sFileWriter

}

# If input file has .calc extension
if [ `echo $input | grep -c ".calc" ` -gt 0 ]
then
    calcPwd+=$input
    # Check permissions for the .calc file
    if [[ -f $calcPwd && -x $calcPwd && -r $calcPwd ]]
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
