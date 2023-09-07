module Backtracking
    export backtracking
    
    include("classicBacktracking.jl")

    include("../csp/csp.jl")
    using .Csp
end