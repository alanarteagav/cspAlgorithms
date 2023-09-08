module Backtracking
    export backtracking, backtrackingR
    
    include("classicBacktracking.jl")

    include("../csp/csp.jl")
    using .Csp
end