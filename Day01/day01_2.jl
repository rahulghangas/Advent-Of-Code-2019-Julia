# Iteratuve Fuel requirement
function requiredFuelComplex(mass :: Float64)
    sum :: Int128 = 0
    currFuel :: Int64 = floor(mass / 3) - 2

    while currFuel >0
        sum += currFuel
        currFuel = floor(currFuel / 3) - 2
    end

    sum
end

# Parse input file
open((@__DIR__) * "/input_01.txt") do file
    sum :: Int128 = 0
    for line in eachline(file)
        sum += requiredFuelComplex(parse(Float64, line))
    end
    println(sum)
end
