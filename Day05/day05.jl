# Run OpCode Program, provided OpCodes are
# 1 [Addition], 2 [Multiplication], 3 [Input], 4 [Output],
# 5 [Conditional Branch], 6 [Conditional Branch],
# 7 [Change value in address based on consition],
# 8 [Change value in address based on consition], 99 [Halt]
function runProg(array)
    curr_index :: Int32 = 1
    next_index :: Int32 = 1
    halt :: Bool = false
    while !halt
        opcode, val_1, val_2, val_3 = get_opcode_and_vals(array, curr_index)
        if opcode == 1
            next_index = curr_index + 4
            array[val_3 + 1] = val_1 + val_2
        elseif opcode == 2
            next_index = curr_index + 4
            array[val_3 + 1] = val_1 * val_2
        elseif opcode == 3
            next_index = curr_index + 2
            inp = parse(Int, input("Provide input value"))
            println("")
            array[val_1 + 1] = inp
        elseif opcode == 4
            next_index = curr_index + 2
            if array[val_1 + 1] == 0
                println("Test successful")
            else
                println("Diagnostic code is ", array[val_1 + 1])
            end
        elseif opcode == 5
            if val_1 != 0
                next_index = val_2 + 1
            else
                next_index = curr_index + 3
            end
        elseif opcode == 6
            if val_1 == 0
                next_index = val_2 + 1
            else
                next_index = curr_index + 3
            end
        elseif opcode == 7
            next_index = curr_index + 4
            if val_1 < val_2
                array[val_3 + 1] = 1
            else
                array[val_3 + 1] = 0
            end
        elseif opcode == 8
            next_index = curr_index + 4
            if val_1 == val_2
                array[val_3 + 1] = 1
            else
                array[val_3 + 1] = 0
            end
        elseif opcode == 99
            halt = true
        else
            throw(ErrorException)
        end
        curr_index = next_index
    end
end

function get_opcode_and_vals(array, curr_index)
    instruction_string = string(array[curr_index])
    if in(instruction_string[end], ('3', '4'))
        return [parse(Int, instruction_string[end]), array[curr_index + 1], Nothing, Nothing]
    elseif length(instruction_string) == 2 && instruction_string[end-1:end] == "99"
        return[99, Nothing, Nothing, Nothing]
    else
        modes_string = instruction_string[1:end-2]
        len = length(modes_string)
        if len < 3 && in(instruction_string[end], ['5', '6'])
            modes_string = repeat('0', 2 - len) * modes_string
        else
            modes_string = repeat('0', 3 - len) * modes_string
        end

        values = [parse(Int, instruction_string[end]), Nothing, Nothing, Nothing]
        for i =1:length(modes_string)
            if modes_string[end-i+1] == '0' && i < 3
                values[i + 1] = array[array[curr_index + i] + 1]
            else
                values[i + 1] = array[curr_index + i]
            end
        end
        println(values)
        return values
    end
end

# Read input file, map to array of ints, and then run diagnostic program
open((@__DIR__) * "/input_05.txt") do file
    array = map(x -> parse(Int32, x), split(readline(file), ","))
    runProg(array)

end
