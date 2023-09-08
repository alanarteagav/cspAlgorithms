module CspAlgorithms
    include("src/problems/Problems.jl")
    using .Problems

    coloringData = readInput("./data/gc_1000")
    
    #backtrackingColoring(coloringData)
    #simulatedAnnealingColoring(coloringData)
    evolutionStrategyColoring(coloringData)
end


