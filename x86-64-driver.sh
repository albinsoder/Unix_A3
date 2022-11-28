# RUN: ./x86-64-driver.sh inputCalcFile.calc
# .s File --> ./assembly_files/inputCalcFile.s
# Executable --> ./bin/inputCalcFile
input="$1"
calcPwd="./testprogs/"
assemblyDir="./assembly_files/"
sExtension=".s"
binDir="./bin/"
testDir="./testprogs/"

# Compile inputCalcFile.s to executable assembly program
compileAss() {
    fileName=${input/.calc/""}
    binDir+=$fileName
    gcc -no-pie -fPIC $assemblyDir -o $binDir
}

# Build all needed files and run calc3i.c with its test-file
compileCalc3() {
    # Path to inputCalcFile
    testDir+=$input
    # Run makefile
    # make all
    # Run calc3i.exe with testfile and output to ./assembly_files/inputCalcFile.s
    ./bin/calc3i.exe < $testDir >> $assemblyDir
    compileAss
    echo "Assembly linked and ready"
}

# Write all data to the .s file, prologue, code and epilogue
sFileWriter() {
    # Write the prologue to the assembly file
    cat << EOF >> $assemblyDir
	.data
sum:	.quad	0
a:      .quad   0
b:      .quad   0
i:      .quad   0
format: .ascii "Result: %d\n"  
	.text
	.global	main
main:
EOF
    # Compile calc3i.c with input calc-file into input.s
    compileCalc3
# Append epilogue to input.s
cat << EOF >> $assemblyDir
    leave
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
