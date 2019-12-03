# Add all grid positions travelled to path list
function calc_path(line)
    path = []
    prev = (0,0)
    for move in line
        step = move[1]
        command = parse(Int, move[2:end])

        if step == 'L'
            append!(path, [(prev[1] - x, prev[2]) for x in 1:command])
            prev = (prev[1] - command, prev[2])
        elseif step == 'R'
            append!(path, [(prev[1] + x, prev[2]) for x in 1:command])
            prev = (prev[1] + command, prev[2])
        elseif step == 'U'
            append!(path, [(prev[1], prev[2] + x) for x in 1:command])
            prev = (prev[1] , prev[2] + command)
        else
            append!(path, [(prev[1], prev[2] - x) for x in 1:command])
            prev = (prev[1] , prev[2] - command)
        end
    end

    path
end

# Read input and find intersection(s)
open((@__DIR__) * "/input_03.txt") do file
    line_1 = split(readline(file), ",") :: Array{SubString{String}, 1}
    line_2 = split(readline(file), ",") :: Array{SubString{String}, 1}
    path_1 = calc_path(line_1)
    path_2 = calc_path(line_2)
    common = intersect(path_1, path_2)

    # Part1
    println("Closest intersection is ",
        min([abs(x[1]) + abs(x[2]) for x in common]...))

    # Part 2
    step_sum = [findfirst(isequal(x), path_1) +
        findfirst(isequal(x), path_2) for x in common]
    println("Smallest number of steps to intersection is ", min(step_sum...))
end
