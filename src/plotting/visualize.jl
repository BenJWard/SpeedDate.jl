
function allowed_plot_type(arg::String)
    return arg == "heat"
end

function allowed_backend(arg::String)
    return arg == "pyplot"
end

function prepare_dictionary(names::Vector{Symbol})
    d = Dict{Symbol, Vector{Float64}}()
    for name in names
        d[name] = Vector{Float64}()
    end
    return d
end

function clock_collect(names::Vector{Symbol}, dates::Matrix{Float64})
    d = prepare_dictionary(names)
    l = length(names)
    for i = 1:l, j = i+1:l
        push!(d[names[i]], dates[i, j])
        push!(d[names[j]], dates[i, j])
    end
    return d
end

#using Plots; gr(); sticks(linspace(0.25π,1.5π,5), rand(5), proj=:polar, yerr=.1)

function visualize(args)

    df = readtable(args["inputfile"], separator = ',', header = true)

    show(df)

    exit()

    if !args["scan"]
        if ncols == 5
            # Data frame contains dates
        elseif ncols == 3
            # Data frame contains distances
        else
            error("Can't deduce type of data file.")
        end
    end


end
