module Problems
    export readInput
        
    include("coloring.jl")
    include("eggholder.jl")
    include("knapsack.jl")
    include("queens.jl")
    include("input.jl")
    
    include("../backtracking/Backtracking.jl")
    using .Backtracking

    include("../hybrid/Hybrid.jl")
    using .Hybrid

    include("../metaheuristics/Metaheuristics.jl")
    using .Metaheuristics

    include("../evolutionary/Evolutionary.jl")
    using .Evolutionary

    include("../csp/csp.jl")
    using .Csp
    
    using Random
end