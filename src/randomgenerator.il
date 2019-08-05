.class sealed RandomGenerator
    extends [mscorlib]System.Object
{
    .field private initonly valuetype Range range
    .field private initonly class [mscorlib]System.Random rng

    .method specialname rtspecialname instance void .ctor(valuetype Range range)
    {
        // Set range.
        ldarg.0
        ldarg range
        stfld valuetype Range RandomGenerator::range

        // Create new Random instance.
        ldarg.0
        newobj instance void [mscorlib]System.Random::.ctor()
        stfld class [mscorlib]System.Random RandomGenerator::rng

        ret
    }

    .property instance valuetype Range Range()
    {
        .get instance valuetype Range RandomGenerator::GetRange()
    }

    .method instance int32 GetNumber()
    {
        ldarg.0
        ldfld class [mscorlib]System.Random RandomGenerator::rng

        ldarg.0
        ldflda valuetype Range RandomGenerator::range
        call instance int32 Range::GetMinValue()

        ldarg.0
        ldflda valuetype Range RandomGenerator::range
        call instance int32 Range::GetMaxValue()

        call instance int32 [mscorlib]System.Random::Next(int32, int32)
        ret
    }

    .method instance int32[] GetNumbers(int32 count)
    {
        .locals
        (
            [0] int32[] result
        )

        // If count is less then 0 then throw arg exception.
        ldarg count
        ldc.i4 0
        blt _ThrowCountLessThen0

        // Create the array.
        ldarg count
        newarr int32
        stloc result

        // Fill array with random numbers.
        ldarg.0
        ldloc result
        call instance void RandomGenerator::GetNumbers(int32[])

        // Return array.
        ldloc result
        ret

        _ThrowCountLessThen0:
        ldstr "Count less then 0 is not supported."
        ldstr "count"
        newobj instance void [mscorlib]System.ArgumentException::.ctor(string, string)
        throw
    }

    .method instance void GetNumbers(int32[] numbersArray)
    {
        .locals
        (
            [0] int32 index,
            [1] int32 count
        )

        // Check if numbers is null.
        ldarg numbersArray
        brnull _ThrowArrayNull

        // Initialize the index.
        ldc.i4 0
        stloc index

        // Initialize the count.
        ldarg numbersArray
        ldlen
        stloc count

        // Return if index is equal to count.
        _CheckIndex:
        ldloc index
        ldloc count
        beq _Return

        // Generate a value and store it in the array.
        ldarg numbersArray
        ldloc index
        ldarg.0
        call instance int32 RandomGenerator::GetNumber()
        stelem int32

        // Increment the index.
        ldloc index
        ldc.i4 1
        add
        stloc index

        // Check the index for the next iteration.
        br _CheckIndex

        _Return:
        ret

        _ThrowArrayNull:
        ldstr "array"
        newobj instance void [mscorlib]System.ArgumentNullException::.ctor(string)
        throw
    }

    .method instance valuetype Range GetRange()
    {
        ldarg.0
        ldfld valuetype Range RandomGenerator::range
        ret
    }
}
