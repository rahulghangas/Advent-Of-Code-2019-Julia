# Calculate Naive Fuel requirement
function requiredFuelNaive(mass :: Float64)
    floor(mass / 3) - 2
end

# Input file parsing
open((@__DIR__) * "/input_01.txt") do file
    sum :: Int128 = 0
    for line in eachline(file)
        sum += requiredFuelNaive(parse(Float64, line))
    end
    println(sum)
end
