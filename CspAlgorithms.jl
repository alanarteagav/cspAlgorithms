module CspAlgorithms
    include("src/problems/Problems.jl")
    using .Problems

    include("src/Csp/Csp.jl")
    using .Csp

    coloringData = readInput("./data/gc_1000")
    ksData10k = readInput("./data/ks_10000")
   
    @time begin
    # backtrackingColoring(coloringData)
    # simulatedAnnealingColoring(coloringData)
    # evolutionStrategyColoring(coloringData)

    # backtrackingQueens(8)
    # simulatedAnnealingQueens(8)
    # evolutionStrategyQueens(8)
    
    # simulatedAnnealingEgg()
    # evolutionStrategyEgg()

    #ks_10000
    # backtrackingKS(ksData10k)
    # simulatedAnnealingKS(ksData10k,1070000)
    # evolutionStrategyKS(ksData10k,1094000) 
    end

end


