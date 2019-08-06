.PHONY: run-console run-file
default: run-console

# --------------------------------------------------------------------------------------------------
# MakeFile used as a convient way for executing development utlitities.
# --------------------------------------------------------------------------------------------------

run-console:
	./run.sh 0 0 100 25

run-file:
	rm -f output.txt
	./run.sh 1 0 100 25

