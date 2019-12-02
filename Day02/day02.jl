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


# Read input file, map to array of ints, replace addresses 1 and 2 and run program
open((@__DIR__) * "/input_02.txt") do file
    array = map(x -> parse(Int32, x), split(readline(file), ","))
    array[2] = 12
    array[3] = 2
    runProg(array)
    println(array)
end
