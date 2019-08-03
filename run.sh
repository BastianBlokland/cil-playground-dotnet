#!/bin/bash
set -e

# --------------------------------------------------------------------------------------------------
# Run the app.
# --------------------------------------------------------------------------------------------------

fail()
{
    if [ -z "$NO_COLORS" ]
    then
        RED='\033[0;31m'
        NORMAL='\033[0m'
        echo -e "${RED}ERROR: ${1}${NORMAL}" >&2
    else
        echo -e "ERROR: $1" >&2
    fi
    exit 1
}

verifyCommand()
{
    if [ ! -x "$(command -v $1)" ]
    then
        fail "Dependency '$1' is missing, we cannot continue without it."
    fi
    return 0
}

# Verify that dotnet is installed.
verifyCommand dotnet

# Run app with dotnet tooling.
PROJECT_PATH="src/app.ilproj"
dotnet run --project "$PROJECT_PATH" -- $@

exit 0
