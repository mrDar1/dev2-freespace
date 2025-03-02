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



    def iterate over files:
        find_type.
        cur_file

        case simple text:
            zip it and change name as instructed.
            then, delete the original file.
        case directory:
            check if -r flag is set if so enter, else exit.
        case cur_file == fc-*:
            check time stamp.
            if time stamp bigger than 48 - delete.
        case cur_file != fc-*:
            case zip:
            case buzip:
            case gzip:
            case compressed:
            rename file: to fc-<filename>
            update time stamp with "touch"
        
        case *:
            counte how many unkown types.
        if any other type:
            count as unkown type.

    







def testing:
    Update to a specific timestamp:
        $ touch -t YYYYMMDDHHMM filename
        $ touch -t 202503021030 filename example, to set the timestamp to March 2, 2025, at 10:30 AM:

