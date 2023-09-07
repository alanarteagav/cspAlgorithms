module Problems
    export readInput
        
    include("coloring.jl")
    include("input.jl")
    
    include("../backtracking/Backtracking.jl")
    using .Backtracking

    include("../metaheuristics/Metaheuristics.jl")
    using .Metaheuristics

    include("../csp/csp.jl")
    using .Csp
    
    using Random
end