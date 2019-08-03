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

.method static void ForAll<T>(!!T[] tArray, class [mscorlib]System.Action`1<!!T> action)
{
    .locals
    (
        [0] int32 index,
        [1] int32 count
    )

    // Check if array is null.
    ldarg tArray
    brnull _ThrowArrayNull

    // Check if action is null.
    ldarg action
    brnull _ThrowActionNull

    // Set index to 0.
    ldc.i4 0
    stloc index

    // Set count to length of the array.
    ldarg tArray
    ldlen
    stloc count

    // Return if index is equal to count.
    _CheckIndex:
    ldloc index
    ldloc count
    beq _Return

    // Invoke the action.
    ldarg action
    ldarg tArray
    ldloc index
    ldelem !!0
    callvirt instance void class [mscorlib]System.Action`1<!!0>::Invoke(!0)

    // Increment the index.
    ldloc index
    ldc.i4 1
    add
    stloc index

    // Check the index for the next iteration.
    br _CheckIndex

    _ThrowArrayNull:
    ldstr "tArray"
    newobj instance void [mscorlib]System.ArgumentNullException::.ctor(string)
    throw

    _ThrowActionNull:
    ldstr "action"
    newobj instance void [mscorlib]System.ArgumentNullException::.ctor(string)
    throw

    _Return:
    ret
}

.method static void PrintNumbers(int32[] numberArray)
{
    // Load array.
    ldarg numberArray

    // Create delegate for 'PrintNumber'.
    ldnull // Null because it is a static method.
    ldftn void PrintNumber(int32)
    newobj instance void class [mscorlib]System.Action`1<int32>::.ctor(object, native int)

    // Invoke the delegate for all the items in the array.
    call void ForAll<int32>(!!0[], class [mscorlib]System.Action`1<!!0>)

    ret
}

.method static void PrintNumber(int32 number)
{
    ldarga number
    call instance string [mscorlib]System.Int32::ToString()
    call void [System.Console]System.Console::WriteLine(string)

    ret
}
