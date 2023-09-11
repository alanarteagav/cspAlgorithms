module CspAlgorithms
    include("src/problems/Problems.jl")
    using .Problems

    include("src/Csp/Csp.jl")
    using .Csp

    coloringData = readInput("./data/gc_50")
    ksData = readInput("./data/ks_10000")
    
    # backtrackingColoring(coloringData)
    # simulatedAnnealingColoring(coloringData)
    # evolutionStrategyColoring(coloringData)

    # backtrackingQueens(8)
    # simulatedAnnealingQueens(8)
    # evolutionStrategyQueens(8)
    
    # simulatedAnnealingEgg()
    # evolutionStrategyEgg()

    backtrackingKS(ksData)
end


