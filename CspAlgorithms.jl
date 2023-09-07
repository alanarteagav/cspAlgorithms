module CspAlgorithms
    include("src/problems/Problems.jl")
    using .Problems

    coloringData = readInput("./data/gc_50")
    backtrackingColoring(coloringData)
    simulatedAnnealingColoring(coloringData)
end


