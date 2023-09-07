export readInput

function readInput(file)
    println(file)

    lines = readlines(file)

    firstLine = popfirst!(lines)
    firstLine = split(firstLine," ", limit = 2)
    first = parse(UInt64, firstLine[1])
    second = parse(UInt64, firstLine[2])
    header = (first, second)

    pairs = Vector{Tuple{Int64,Int64}}()
    for line in lines 
        sp = split(line," ", limit = 2)
        f = parse(Int64, sp[1])
        s = parse(Int64, sp[2])
        push!(pairs,(f,s))
    end

    return (header, pairs)
end