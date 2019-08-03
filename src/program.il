.class public sealed Program
    extends [mscorlib]System.Object
{
    .method public static int32 Main(class [mscorlib]System.String[] args)
    {
        .entrypoint
        .locals
        (
            [0] int32 minValue,
            [1] int32 maxValue,
            [2] int32 count,
            [3] class RandomGenerator generator,
            [4] int32[] randomNumbers
        )

        // Parse minValue from arg 0.
        ldarg args
        ldc.i4 0 // Argument 0.
        ldloca minValue
        call bool TryGetIntAtIndex(class [mscorlib]System.String[], int32, int32&)
        brfalse _ExitWithInvalidArgs

        // Parse maxValue from arg 1.
        ldarg args
        ldc.i4 1 // Argument 1.
        ldloca maxValue
        call bool TryGetIntAtIndex(class [mscorlib]System.String[], int32, int32&)
        brfalse _ExitWithInvalidArgs

        // Parse count from arg 2.
        ldarg args
        ldc.i4 2 // Argument 2.
        ldloca count
        call bool TryGetIntAtIndex(class [mscorlib]System.String[], int32, int32&)
        brfalse _ExitWithInvalidArgs

        // Create generator.
        ldloc minValue
        ldloc maxValue
        newobj instance void RandomGenerator::.ctor(int32, int32)
        stloc generator

        // Generate the numbers.
        ldloc generator
        ldloc count
        call instance int32[] RandomGenerator::GetNumbers(int32)
        stloc randomNumbers

        // Print the numbers.
        ldloc randomNumbers
        call void PrintNumbers(int32[])

        // Exit with code '0'.
        _Exit:
        ldc.i4 0
        ret

        _ExitWithInvalidArgs:
        ldstr "Invalid arguments, expected: arg1: minValue, arg2: maxValue, arg3: count"
        call void [System.Console]System.Console::WriteLine(string)
        ldc.i4 1
        ret
    }
}
