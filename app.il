.assembly extern System.Console { }
.assembly extern mscorlib { }

.module App.exe
.assembly App
{
    .ver 1:0:0:0
}

.class public sealed RandomGenerator
    extends [mscorlib]System.Object
{
    .field private initonly int32 minVal
    .field private initonly int32 maxVal
    .field private initonly class [mscorlib]System.Random rng

    .method public specialname rtspecialname instance void .ctor()
        cil managed
    {
        ldarg.0
        ldc.i4 0
        stfld int32 RandomGenerator::minVal

        ldarg.0
        ldc.i4 100
        stfld int32 RandomGenerator::maxVal

        ldarg.0
        newobj instance void [mscorlib]System.Random::.ctor()
        stfld class [mscorlib]System.Random RandomGenerator::rng

        ret
    }

    .method public specialname rtspecialname instance void .ctor(int32 minVal, int32 maxVal)
        cil managed
    {
        ldarg.0
        ldarg minVal
        stfld int32 RandomGenerator::minVal

        ldarg.0
        ldarg maxVal
        stfld int32 RandomGenerator::maxVal

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

    .method public instance int32 Get()
        cil managed
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

    .method private instance int32 GetMinValue()
        cil managed
    {
        ldarg.0
        ldfld int32 RandomGenerator::minVal
        ret
    }

    .method private instance int32 GetMaxValue()
        cil managed
    {
        ldarg.0
        ldfld int32 RandomGenerator::maxVal
        ret
    }
}

.class public sealed Program
    extends [mscorlib]System.Object
{
    .method public static int32 Main()
        cil managed
    {
        .entrypoint
        .locals
        (
            [0] class RandomGenerator rg,
            [1] int32 randomVal
        )

        ldc.i4 10
        ldc.i4 25
        newobj instance void RandomGenerator::.ctor(int32, int32)
        stloc rg

        ldloc rg
        call instance int32 RandomGenerator::Get()
        stloc randomVal

        ldloca randomVal
        call instance string [mscorlib]System.Int32::ToString()

        call void [System.Console]System.Console::WriteLine(string)

        ldc.i4 0
        ret
    }
}
