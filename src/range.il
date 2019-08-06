.class sequential sealed value Range
{
    .field private initonly int32 minVal
    .field private initonly int32 maxVal

    .method private specialname rtspecialname instance void .ctor(int32 minVal, int32 maxVal)
    {
        // Set minVal.
        ldarg.0
        ldarg minVal
        stfld int32 Range::minVal

        // Set maxVal.
        ldarg.0
        ldarg maxVal
        stfld int32 Range::maxVal

        ret
    }

    .property instance int32 MinValue()
    {
        .get instance int32 Range::GetMinValue()
    }

    .property instance int32 MaxValue()
    {
        .get instance int32 Range::GetMaxValue()
    }

    .method static valuetype Range Create()
    {
        .locals
        (
            [0] valuetype Range range
        )

        // Run the constructor on the value.
        ldloca range
        ldc.i4 0 // minVal 0.
        ldc.i4 1000 // maxVal 1000.
        call instance void Range::.ctor(int32, int32)

        // Return the value.
        ldloc range
        ret
    }

    .method static valuetype Range Create(int32 minVal, int32 maxVal)
    {
        .locals
        (
            [0] valuetype Range range
        )

        // Verify that max is not less then min.
        ldarg maxVal
        ldarg minVal
        blt _ThrowMaxValueLessThenMinValue

        // Run the constructor on the value.
        ldloca range
        ldarg minVal
        ldarg maxVal
        call instance void Range::.ctor(int32, int32)

        // Return the value.
        ldloc range
        ret

        _ThrowMaxValueLessThenMinValue:
        ldstr "maxValue cannot be less then minValue."
        ldstr "maxValue"
        newobj instance void [mscorlib]System.ArgumentException::.ctor(string, string)
        throw
    }

    .method instance int32 GetMinValue()
    {
        ldarg.0
        ldfld int32 Range::minVal
        ret
    }

    .method instance int32 GetMaxValue()
    {
        ldarg.0
        ldfld int32 Range::maxVal
        ret
    }
}
