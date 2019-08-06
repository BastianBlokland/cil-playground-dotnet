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

.method static void PrintAll<T>(!!T[] tArray, class [mscorlib]System.IO.StreamWriter writer)
{
    .locals
    (
        [0] class [mscorlib]System.String[] stringArray,
        [1] class [mscorlib]System.Func`2<!!T, string> toString,
        [2] class [mscorlib]System.Action`1<string> writeLine
    )

    // Check if array is null.
    ldarg tArray
    brnull _ThrowArrayNull

    // Check if writer is null.
    ldarg writer
    brnull _ThrowWriterNull

    // Create delegate for 'ToString'.
    ldnull // Null because it is a static method.
    ldftn string ToString<!!T>(!!0)
    newobj instance void class [mscorlib]System.Func`2<!!T, string>::.ctor(object, native int)
    stloc toString

    // Map to a string array.
    ldarg tArray
    ldloc toString
    call !!1[] Map<!!T, string>(!!0[], class [mscorlib]System.Func`2<!!0, !!1> func)
    stloc stringArray

    // Create delegate for 'StreamWriter.WriteLine'.
    ldarg writer
    dup
    ldvirtftn instance void [mscorlib]System.IO.TextWriter::WriteLine(string)
    newobj instance void class [mscorlib]System.Action`1<string>::.ctor(object, native int)
    stloc writeLine

    // Print all items.
    ldloc stringArray
    ldloc writeLine
    call void ForAll<string>(!!0[], class [mscorlib]System.Action`1<!!0>)

    ret

    _ThrowArrayNull:
    ldstr "tArray"
    newobj instance void [mscorlib]System.ArgumentNullException::.ctor(string)
    throw

    _ThrowWriterNull:
    ldstr "writer"
    newobj instance void [mscorlib]System.ArgumentNullException::.ctor(string)
    throw
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

.method static !!T2[] Map<T1, T2>(!!T1[] tArray, class [mscorlib]System.Func`2<!!T1, !!T2> func)
{
    .locals
    (
        [0] int32 index,
        [1] int32 count,
        [2] !!T2[] result,
        [3] !!T2 temp
    )

    // Check if array is null.
    ldarg tArray
    brnull _ThrowArrayNull

    // Check if func is null.
    ldarg func
    brnull _ThrowFuncNull

    // Set index to 0.
    ldc.i4 0
    stloc index

    // Set count to length of the array.
    ldarg tArray
    ldlen
    stloc count

    // Create result array.
    ldloc count
    newarr string
    stloc result

    // Return if index is equal to count.
    _CheckIndex:
    ldloc index
    ldloc count
    beq _Return

    // Load elem from source array and transform with the func.
    ldarg func
    ldarg tArray
    ldloc index
    ldelem !!T1
    callvirt instance !1 class [mscorlib]System.Func`2<!!T1, !!T2>::Invoke(!0)
    stloc temp

    // Store in the result array.
    ldloc result
    ldloc index
    ldloc temp
    stelem !!T2

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

    _ThrowFuncNull:
    ldstr "func"
    newobj instance void [mscorlib]System.ArgumentNullException::.ctor(string)
    throw

    _Return:
    ldloc result
    ret
}

.method static string ToString<T>(!!T val)
{
    // Create a string out of the value.
    ldarg val
    box !!T
    callvirt instance string [mscorlib]System.Object::ToString()

    ret
}
