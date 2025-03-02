def important notes:
     mv command do not change time stamp!! must use "touch"

def Constraint:
    zipped, tgzed(=gunzip tar), bzipped or compressed == do not zip again.

def Workflow:
    if edge case - if no arguments are passed - exit.

    def catch flags 
        use getopts and OPTIND shift $((OPTIND-1)): 
            -r
            -t - if not added number default is 48 hourst add MACRO.

    if classic case - simple text file: 
        zip it and change name as instructed.
        then, delete the original file.
    if directory:
        check if -r flag is set, else exit.
    if any other type :
        rename file - to fc-<filename> and exit.

    







def testing:
    Update to a specific timestamp:
        $ touch -t YYYYMMDDHHMM filename
        $ touch -t 202503021030 filename example, to set the timestamp to March 2, 2025, at 10:30 AM:

