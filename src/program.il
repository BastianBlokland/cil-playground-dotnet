.class sealed Program
    extends [mscorlib]System.Object
{
    .method static int32 Main(string[] args)
    {
        .entrypoint
        .locals
        (
            [0] int32 mode,
            [1] class [mscorlib]System.IO.StreamWriter outputWriter,
            [2] int32 exitCode,
            [3] class [mscorlib]System.Exception exception
        )

        // Parse mode from arg 0.
        ldarg args
        ldc.i4 0 // Argument 0.
        ldloca mode
        call bool TryGetIntAtIndex(string[], int32, int32&)
        brfalse _ExitWithInvalidMode

        // Switch on the mode.
        ldloc mode
        switch (_PrintToConsole, _PrintToFile)
        br _ExitWithInvalidMode

        _PrintToConsole:
        call class [mscorlib]System.IO.StreamWriter Program::GetConsoleOutWriter()
        stloc outputWriter
        br _Run

        _PrintToFile:
        ldstr "output.txt"
        call class [mscorlib]System.IO.StreamWriter Program::GetFileWriter(string)
        stloc outputWriter
        br _Run

        _Run:
        .try
        {
            // Generate the numbers.
            ldarg args
            ldloc outputWriter
            call int32 Program::GenerateNumbers(string[], class [mscorlib]System.IO.StreamWriter)
            stloc exitCode

            // Leave the try block.
            leave _FinishedRun
        }
        catch [mscorlib]System.Exception
        {
            stloc exception

            // Print exception to console.
            ldstr "Failed to generate: "
            ldloc exception
            callvirt instance string [mscorlib]System.Exception::get_Message()
            call string [mscorlib]System.String::Concat(string, string)
            call void [System.Console]System.Console::WriteLine(string)

            // Leave the catch block.
            leave _FinishedRun
        }

        _FinishedRun:

        // Dispose the output writer.
        ldloc outputWriter
        call instance void [mscorlib]System.IO.StreamWriter::Dispose()

        ldloc exitCode
        ret

        _ExitWithInvalidMode:
        ldstr "Invalid mode, provide mode as arg1. Possible modes:\n0 - Generate to console.\n1 - Generate to file."
        call void [System.Console]System.Console::WriteLine(string)
        ldc.i4 1
        ret
    }

    .method private static int32 GenerateNumbers(string[] args, class [mscorlib]System.IO.StreamWriter writer)
    {
        .locals
        (
            [0] int32 minValue,
            [1] int32 maxValue,
            [2] int32 count,
            [3] valuetype Range range,
            [4] class IRandomGenerator generator,
            [5] int32[] randomNumbers
        )

        // Parse minValue from arg 1.
        ldarg args
        ldc.i4 1 // Argument 1.
        ldloca minValue
        call bool TryGetIntAtIndex(string[], int32, int32&)
        brfalse _ExitWithInvalidArgs

        // Parse maxValue from arg 2.
        ldarg args
        ldc.i4 2 // Argument 2.
        ldloca maxValue
        call bool TryGetIntAtIndex(string[], int32, int32&)
        brfalse _ExitWithInvalidArgs

        // Parse count from arg 3.
        ldarg args
        ldc.i4 3 // Argument 3.
        ldloca count
        call bool TryGetIntAtIndex(string[], int32, int32&)
        brfalse _ExitWithInvalidArgs

        // Create range.
        ldloc minValue
        ldloc maxValue
        call valuetype Range Range::Create(int32, int32)
        stloc range

        ldloc range
        newobj instance void RandomGenerator::.ctor(valuetype Range)
        stloc generator

        // Generate the numbers.
        ldloc generator
        ldloc count
        callvirt instance int32[] IRandomGenerator::GetNumbers(int32)
        stloc randomNumbers

        // Print the numbers.
        ldloc randomNumbers
        ldarg writer
        call void PrintAll<int32>(!!0[], class [mscorlib]System.IO.StreamWriter)

        // Exit with code '0'.
        _Exit:
        ldc.i4 0
        ret

        _ExitWithInvalidArgs:
        ldstr "Invalid arguments, expected: arg2: minValue, arg3: maxValue, arg4: count."
        call void [System.Console]System.Console::WriteLine(string)
        ldc.i4 1
        ret
    }

    .method private static class [mscorlib]System.IO.StreamWriter GetConsoleOutWriter()
    {
        .locals
        (
            [0] class [mscorlib]System.IO.StreamWriter writer
        )

        // Open output stream.
        call class [mscorlib]System.IO.Stream [System.Console]System.Console::OpenStandardOutput()

        // Create new writer around the stream.
        newobj instance void [mscorlib]System.IO.StreamWriter::.ctor(class [mscorlib]System.IO.Stream)
        stloc writer

        // Set 'AutoFlush' on the writer.
        ldloc writer
        ldc.i4 1
        call instance void [mscorlib]System.IO.StreamWriter::set_AutoFlush(bool)

        ldloc writer
        ret
    }

    .method private static class [mscorlib]System.IO.StreamWriter GetFileWriter(string fileName)
    {
        .locals
        (
            [0] class [mscorlib]System.IO.StreamWriter writer
        )

        // Create new writer.
        ldarg fileName
        newobj instance void [mscorlib]System.IO.StreamWriter::.ctor(string)
        stloc writer

        // Set 'AutoFlush' on the writer.
        ldloc writer
        ldc.i4 1
        call instance void [mscorlib]System.IO.StreamWriter::set_AutoFlush(bool)

        ldloc writer
        ret
    }
}
