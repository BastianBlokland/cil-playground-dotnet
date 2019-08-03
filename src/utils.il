.method static bool TryGetIntAtIndex(
    class [mscorlib]System.String[] stringArray,
    int32 index,
    int32& result)
{
    // If array has too little entries then return false.
    ldarg stringArray
    ldlen
    ldarg index
    ble _ReturnFalse

    // Get string at index.
    ldarg stringArray
    ldarg index
    ldelem class [mscorlib]System.String

    // TryParse it and return the result.
    ldarg result
    call bool [mscorlib]System.Int32::TryParse(string, int32&)
    ret

    _ReturnFalse:
    ldc.i4 0
    starg result
    ldc.i4 0
    ret
}

.method static void PrintNumbers(int32[] numberArray)
{
    .locals
    (
        [0] int32 index,
        [1] int32 count
    )

    // Set index to 0.
    ldc.i4 0
    stloc index

    // Set count to length of the array.
    ldarg numberArray
    ldlen
    stloc count

    // Return if index is equal to count.
    _CheckIndex:
    ldloc index
    ldloc count
    beq _Return

    // Print the number.
    ldarg numberArray
    ldloc index
    ldelem int32
    call void PrintNumber(int32)

    // Increment the index.
    ldloc index
    ldc.i4 1
    add
    stloc index

    // Check the index for the next iteration.
    br _CheckIndex

    _Return:
    ret
}

.method static void PrintNumber(int32 number)
{
    ldarga number
    call instance string [mscorlib]System.Int32::ToString()
    call void [System.Console]System.Console::WriteLine(string)

    ret
}
