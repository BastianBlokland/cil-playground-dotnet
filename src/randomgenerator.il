.class public sealed RandomGenerator
    extends [mscorlib]System.Object
{
    .field private initonly int32 minVal
    .field private initonly int32 maxVal
    .field private initonly class [mscorlib]System.Random rng

    .method public specialname rtspecialname instance void .ctor()
    {
        // Set minVal to 0.
        ldarg.0
        ldc.i4 0
        stfld int32 RandomGenerator::minVal

        // Set maxVal to 100.
        ldarg.0
        ldc.i4 100
        stfld int32 RandomGenerator::maxVal

        // Create new Random instance.
        ldarg.0
        newobj instance void [mscorlib]System.Random::.ctor()
        stfld class [mscorlib]System.Random RandomGenerator::rng

        ret
    }

    .method public specialname rtspecialname instance void .ctor(int32 minVal, int32 maxVal)
    {
        // Set minVal.
        ldarg.0
        ldarg minVal
        stfld int32 RandomGenerator::minVal

        // Set maxVal.
        ldarg.0
        ldarg maxVal
        stfld int32 RandomGenerator::maxVal

        // Create new Random instance.
        ldarg.0
        newobj instance void [mscorlib]System.Random::.ctor()
        stfld class [mscorlib]System.Random RandomGenerator::rng

        ret
    }

    .property instance int32 MinValue()
    {
        .get instance int32 RandomGenerator::GetMinValue()
    }

    .property instance int32 MaxValue()
    {
        .get instance int32 RandomGenerator::GetMaxValue()
    }

    .method public instance int32 GetNumber()
    {
        ldarg.0
        ldfld class [mscorlib]System.Random RandomGenerator::rng

        ldarg.0
        ldfld int32 RandomGenerator::minVal

        ldarg.0
        ldfld int32 RandomGenerator::maxVal

        call instance int32 [mscorlib]System.Random::Next(int32, int32)
        ret
    }

    .method public instance int32[] GetNumbers(int32 count)
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
        ldstr "Count less then 0 is not supported"
        ldstr "count"
        newobj instance void [mscorlib]System.ArgumentException::.ctor(string, string)
        throw
    }

    .method public instance void GetNumbers(int32[] numbersArray)
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

    .method private instance int32 GetMinValue()
    {
        ldarg.0
        ldfld int32 RandomGenerator::minVal
        ret
    }

    .method private instance int32 GetMaxValue()
    {
        ldarg.0
        ldfld int32 RandomGenerator::maxVal
        ret
    }
}
