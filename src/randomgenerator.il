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

    .method public instance int32 GetNumber()
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
