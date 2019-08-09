.class sealed RandomGenerator
    extends [netstandard]System.Object
    implements IRandomGenerator
{
    .field private initonly valuetype Range range
    .field private initonly class [netstandard]System.Random rng

    .method specialname rtspecialname instance void .ctor(valuetype Range range)
    {
        // Call base constructor.
        ldarg.0
        call instance void [netstandard]System.Object::.ctor()

        // Set range.
        ldarg.0
        ldarg range
        stfld valuetype Range RandomGenerator::range

        // Create new Random instance.
        ldarg.0
        newobj instance void [netstandard]System.Random::.ctor()
        stfld class [netstandard]System.Random RandomGenerator::rng

        ret
    }

    .property instance valuetype Range Range()
    {
        .get instance valuetype Range RandomGenerator::GetRange()
    }

    .method virtual instance int32 GetNumber()
    {
        .override IRandomGenerator::GetNumber

        ldarg.0
        ldfld class [netstandard]System.Random RandomGenerator::rng

        ldarg.0
        ldflda valuetype Range RandomGenerator::range
        call instance int32 Range::GetMinValue()

        ldarg.0
        ldflda valuetype Range RandomGenerator::range
        call instance int32 Range::GetMaxValue()

        call instance int32 [netstandard]System.Random::Next(int32, int32)
        ret
    }

    .method hidebysig virtual instance int32[] GetNumbers(int32 count)
    {
        .override IRandomGenerator::GetNumbers
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
        newobj instance void [netstandard]System.ArgumentException::.ctor(string, string)
        throw
    }

    .method hidebysig virtual instance void GetNumbers(int32[] numbersArray)
    {
        .override IRandomGenerator::GetNumbers
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
        newobj instance void [netstandard]System.ArgumentNullException::.ctor(string)
        throw
    }

    .method instance valuetype Range GetRange()
    {
        ldarg.0
        ldfld valuetype Range RandomGenerator::range
        ret
    }
}
