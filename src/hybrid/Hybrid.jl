module Hybrid
    export evolutionTabu
    
    include("evolutionTabu.jl")

    include("../csp/csp.jl")
    using .Csp
end