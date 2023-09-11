module CspAlgorithms
    include("src/problems/Problems.jl")
    using .Problems

    include("src/Csp/Csp.jl")
    using .Csp

    coloringData = readInput("./data/gc_50")
   
    
    # backtrackingColoring(coloringData)
    # simulatedAnnealingColoring(coloringData)
    # evolutionStrategyColoring(coloringData)

    # backtrackingQueens(8)
    # simulatedAnnealingQueens(8)
    # evolutionStrategyQueens(8)
    
    # simulatedAnnealingEgg()
    # evolutionStrategyEgg()

    #ks_19
    # ksData = readInput("./data/ks_19")

    #ks_10000
    ksData10k = readInput("./data/ks_10000")
    # backtrackingKS(ksData10k)
    # simulatedAnnealingKS(ksData10k,1060000)
    evolutionStrategyKS(ksData10k,1100000) 
end


