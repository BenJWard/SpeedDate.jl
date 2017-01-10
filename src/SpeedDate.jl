module SpeedDate

using ArgParse
using Bio: Seq, Var, Phylo.Dating, Indexers
using DataFrames

include("dating/dating.jl")
include("plotting/visualize.jl")

function parse_command_line()
    s = ArgParseSettings()
    s.add_help = true

    @add_arg_table s begin
        "compute"
            help = "Compute coalescence times."
            action = :command
        "interactive"
            help = "Start the interactive GUI for SpeedDate."
            action = :command
        "plot"
            help = "Produce quick plots from SpeedDate results files."
            action = :command
    end

    @add_arg_table s["compute"] begin
        "--file", "-f"
            help = "An input file."
            arg_type = String
            required = false
        "--dnaseqs", "-s"
            help = "An array of DNA sequences."
            required = false
            arg_type = BioSequence{DNAAlphabet{4}}
            nargs = '*'
        "--model", "-m"
            help = """
            The model used to compute genetic distances.
            Currently jc69, and k80 are supported.
            """
            arg_type = String
            default = "jc69"
        "--mutation_rate", "-r"
            help = "The mutation rate to be assumed."
            arg_type = Float64
            default = 10e-9
        "--method"
            help = """
            The dating method to use.
            Currently 'default' and 'simple' are supported.
            """
            arg_type = String
            default = "default"
        "--outfile", "-o"
            help = "Base name for the output files(s)."
            default = "SpeedDate"
            arg_type = String
        "--scan"
            help = "Whether or not to compute dates across sequences with a window."
            action = :store_true
        "--width", "-w"
            help = "Width of the window across sequences."
            arg_type = Int64
            default = 100
        "--sepcol", "-c"
            help = "Write the start and end points of windows in separate columns of output table."
            action = :store_true
        "--onlydist"
            action = :store_true
    end

    @add_arg_table s["plot"] begin
        "--plottype", "-p"
            help = "The type of plot to produce, currently only heaplots are supported."
            arg_type = String
            default = "heat"
            range_tester = allowed_plot_type
        "--outfile", "-o"
            help = """
            The name to give to the output plot file, adding .png or .pdf etc to
            the end of the filename makes SpeedDate save the plot in that format.
            """
            default = "SDplot.png"
        "--backend", "-b"
            help = "Select the backend used to produce the plots."
            default = "pyplot"
            range_tester = allowed_backend
        "--scan", "-s"
            help = "Use this flag if you are plotting a window scan file."
            action = :store_true
        "inputfile"
            help = "The file name of the input data."
            arg_type = String
            nargs = '+'
    end

    return parse_args(s)
end

function main()
    #try
        arguments = parse_command_line()
        if arguments["%COMMAND%"] == "compute"
            compute(arguments["compute"])
        end
        if arguments["%COMMAND%"] == "interactive"
            include("gtk_gui.jl")
            start_interactive_app()
        end
        if arguments["%COMMAND%"] == "plot"
            visualize(arguments["plot"])
        end
    #catch err
        #(STDOUT, "SpeedDate could not complete analysis.\nReason:\n$(err.msg)\n")
    #end
end

end
