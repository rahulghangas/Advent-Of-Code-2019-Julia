# Run OpCode Program, provided OpCodes are
# 1 [Addition], 2 [Multiplication] and 99[Halt]
function runProg(array)
    curr_index :: Int32 = 0
    next_index :: Int32 = 0
    halt :: Bool = false
    while !halt
        if array[curr_index + 1] == 1
            next_index = curr_index + 4
            array[array[curr_index + 4] + 1] = array[array[curr_index + 2] + 1] + array[array[curr_index + 3] + 1]
        elseif array[curr_index + 1] == 2
            next_index = curr_index + 4
            array[array[curr_index + 4] + 1] = array[array[curr_index + 2] + 1] * array[array[curr_index + 3] + 1]
        elseif array[curr_index + 1] == 99
            halt = true
        else
            throw(ErrorException)
        end
        curr_index = next_index
    end
end


# Read input file, map to array of ints, and then search address space for
# input values noun and verb at addresses 1 and 2 respectively that give output
# 19690720
open((@__DIR__) * "/input_02.txt") do file
    array = map(x -> parse(Int32, x), split(readline(file), ","))

    array_copy = copy(array)

    for i = 0:length(array_copy) -1, j = 0:length(array_copy) -1
        try
            array_copy[2] = i
            array_copy[3] = j
            runProg(array_copy)
            if array_copy[1] == 19690720
                break
            end
        catch
            Nothing
        end

        array_copy = copy(array)
    end

    println(array_copy)
    println("100 * noun + verb is ", 100 * array_copy[2] + array_copy[3])
end
