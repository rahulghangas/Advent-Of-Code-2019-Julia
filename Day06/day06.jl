open((@__DIR__) * "/input_06.txt") do file

    orbit_map = Dict()

    for line in eachline(file)
        center, orbiter = split(line, ")")
        orbit_map[orbiter] = center
    end

    count = 0
    for key in keys(orbit_map)
        center = orbit_map[key]
        count += 1
        while haskey(orbit_map, center)
            center = orbit_map[center]
            count += 1
        end
    end

    println("Total direct and indirect orbitals are ",count)

    you_parents = []
    san_parents = []

    center = orbit_map["YOU"]
    push!(you_parents, center)
    while haskey(orbit_map, center)
        center = orbit_map[center]
        push!(you_parents, center)
    end

    center = orbit_map["SAN"]
    push!(san_parents, center)
    while haskey(orbit_map, center)
        center = orbit_map[center]
        push!(san_parents, center)
    end

    common = indexin(you_parents, san_parents)
    for i in 1:length(common)
        if !isnothing(common[i])
            println("Orbital hops needed to reach SAN from YOU are ", i + common[i] - 2)
            break
        end
    end

end
