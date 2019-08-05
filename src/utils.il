.method static bool TryGetIntAtIndex(
    class [mscorlib]System.String[] stringArray,
    int32 index,
    int32& result)
{
    // Check if array is null.
    ldarg stringArray
    brnull _ThrowArrayNull

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

    _ThrowArrayNull:
    ldstr "stringArray"
    newobj instance void [mscorlib]System.ArgumentNullException::.ctor(string)
    throw
}

.method static void ForAll<T>(!!T[] tArray, class [mscorlib]System.Action<!!T> action)
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
    callvirt instance void class [mscorlib]System.Action<!!0>::Invoke(!0)

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

.method static void PrintAll<T>(!!T[] tArray, class [mscorlib]System.IO.StreamWriter writer)
{
    .locals
    (
        [0] int32 index,
        [1] int32 count
    )

    // Check if array is null.
    ldarg tArray
    brnull _ThrowArrayNull

    // Check if writer is null.
    ldarg writer
    brnull _ThrowWriterNull

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

    // Print the item.
    ldarg tArray
    ldloc index
    ldelem !!0
    ldarg writer
    call void PrintValue<!!0>(!!0, class [mscorlib]System.IO.StreamWriter)

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

    _ThrowWriterNull:
    ldstr "writer"
    newobj instance void [mscorlib]System.ArgumentNullException::.ctor(string)
    throw

    _Return:
    ret
}

.method static void PrintValue<T>(!!T val, class [mscorlib]System.IO.StreamWriter writer)
{
    // Check if writer is null.
    ldarg writer
    brnull _ThrowWriterNull

    // Load the writer.
    ldarg writer

    // Create a string out of the value.
    ldarg val
    box int32
    callvirt instance string [mscorlib]System.Object::ToString()

    // Print the string to the writer.
    call instance void [mscorlib]System.IO.StreamWriter::WriteLine(string)

    ret

    _ThrowWriterNull:
    ldstr "writer"
    newobj instance void [mscorlib]System.ArgumentNullException::.ctor(string)
    throw
}
