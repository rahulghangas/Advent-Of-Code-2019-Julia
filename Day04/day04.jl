#=
    function compute takes a range of numbers and finds all numbers within the range
    that are in ascending order of digits and have at least one pair of adjacent
    numbers that are equal.

    Input : UnitRange{Int64}
    Return : Array{Int64, 1}
=#
function compute(rng)
    numbers = []
    for num = rng
        str = string(num)
        if issorted(str)
            for i = 1:length(str)-1
                if str[i] == str[i+1]
                    push!(numbers, num)
                    break
                end
            end
        end
    end
    numbers
end


#=
    function compute_complex takes a range of numbers and finds all numbers within
    the range that are in ascending order of digits and have at least one pair of
    adjacent numebrs that are equal. This pair should not be a part of a larger
    group of adjacent equal numbers.

    Input : UnitRange{Int64}
    Return : Array{Int64, 1}
=#
function compute_complex(rng)

    numbers = []
    for num = rng
        str = string(num)
        if issorted(str)
            count = 1
            exited = false
            for i = 2:length(str)
                if str[i] != str[i-1]
                    if count == 2
                        push!(numbers, num)
                        count = 1
                        break
                    else
                        count = 1
                    end
                else
                    count += 1
                end
            end
            if count == 2
                push!(numbers, num)
            end
        end
    end
    numbers
end

# function main defines the input range and outputs the relevant answers to the
# console
function main()
    inp = 153517:630395

    # Q1
    numbers = compute(inp)
    println(length(numbers))

    # Q2
    numbers2 = compute_complex(inp)
    println(length(numbers2))
end
