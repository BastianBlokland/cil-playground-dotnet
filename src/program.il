.class public sealed Program
    extends [mscorlib]System.Object
{
    .method public static int32 Main(class [mscorlib]System.String[] args)
        cil managed
    {
        .entrypoint
        .locals
        (
            [0] class RandomGenerator rg,
            [1] int32 numbersRemaining
        )

        // Create generator.
        ldc.i4 0 // Min value.
        ldc.i4 100 // Max value.
        newobj instance void RandomGenerator::.ctor(int32, int32)
        stloc rg

        // Find how many numbers to generate.
        ldarg args
        call int32 Program::GetAmountOfNumbersToGenerate(class [mscorlib]System.String[])
        stloc numbersRemaining

        _GenerateNumber:
        ldloc rg
        call instance int32 RandomGenerator::GetNumber()
        call void Program::PrintNumber(int32)

        // Substract 1 from 'numbersRemaining'.
        ldloc numbersRemaining
        ldc.i4 1
        sub
        stloc numbersRemaining

        // If 'numbersRemaining' is above 0 then generate another number.
        ldloc numbersRemaining
        ldc.i4 0
        bgt _GenerateNumber

        // Exit with code '0'.
        ldc.i4 0
        ret
    }

    .method private static int32 GetAmountOfNumbersToGenerate(class [mscorlib]System.String[] args)
        cil managed
    {
        .locals
        (
            [0] int32 result
        )

        // If args array is empty then return 0.
        ldarg args
        ldlen
        ldc.i4 0
        beq _Return0

        // Parse the first argument as a int.
        ldarg args
        ldc.i4 0
        ldelem class [mscorlib]System.String
        ldloca result
        call bool [mscorlib]System.Int32::TryParse(string, int32&)

        // Ignore the result of the TryParse, if fails we just return 0.
        pop

        // Return result.
        ldloc result
        ret

        _Return0:
        ldc.i4 0
        ret
    }

    .method private static void PrintNumber(int32 number)
    {
        ldarga number
        call instance string [mscorlib]System.Int32::ToString()
        call void [System.Console]System.Console::WriteLine(string)

        ret
    }
}
