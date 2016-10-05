
function start_interactive_app()
    # Application Data
    SEQUENCES = Vector{DNASequence}()
    μ = "10e-9"

    # User interface
    win = @Window("Speed Date")

    g = @Grid()

    ## Action buttons
    actions_frame = @Frame("Actions")
    button_box = @ButtonBox(:v)
    load_button = @Button("Load FASTA file")
    go_button = @Button("Go!")
    push!(actions_frame, button_box)
    push!(button_box, load_button)
    push!(button_box, go_button)
    g[1, 1] = actions_frame

    ## Calculation and model assumptions
    μ_box = @Box(:h)
    μ_label = @Label("Mutation Rate:")
    μ_entry = @Entry()
    model_frame = @Frame("Mutation Model")
    model_box = @Box(:v)
    JC69_radio = @RadioButton("Jukes Cantor 69")
    K80_radio = @RadioButton(JC69_radio, "Kimura 80")
    setproperty!(μ_entry, :text, μ)
    push!(μ_box, μ_label)
    push!(μ_box, μ_entry)
    push!(model_frame, model_box)
    push!(model_box, JC69_radio)
    push!(model_box, K80_radio)
    push!(model_box, μ_box)
    g[2, 1] = model_frame


    ## Sliding window settings
    window_frame = @Frame("Sliding Window")
    window_box = @Box(:v)
    slide_check = @CheckButton("Use Sliding Windows")
    window_box_2 = @Box(:h)
    size_label = @Label("Window Size")
    size_entry = @Entry()
    window_box_3 = @Box(:v)
    window_box_4 = @Box(:v)
    step_label = @Label("Step Size")
    step_entry = @Entry()
    push!(window_box_3, size_label)
    push!(window_box_4, size_entry)
    push!(window_box_3, step_label)
    push!(window_box_4, step_entry)
    push!(window_box_2, window_box_3)
    push!(window_box_2, window_box_4)
    push!(window_box, slide_check)
    push!(window_box, window_box_2)
    push!(window_frame, window_box)
    g[3, 1] = window_frame


    ## Signals and behaviour

    fl = signal_connect(load_button, "clicked") do widget
        file = open_dialog("Choose a FASTA file", win, ("*.fas","*.fasta"))
        iostream = open(FASTAReader, file)
        try
            SEQUENCES = collect(iostream)
            info_dialog("Completed reading FASTA file!", win)
        catch
            error_dialog("Something went wrong reading in your file!", win)
        finally
            close(iostream)
        end
    end

    flen = signal_connect(go_button, "clicked") do widget
        println(length(SEQUENCES))
        println(getproperty(μ_entry, :text, String))
    end



    push!(win, g)
    setproperty!(g, :column_spacing, 15)
    showall(win)
    c = Condition()
    signal_connect(win, :destroy) do widget
        notify(c)
    end
    wait(c)
end
