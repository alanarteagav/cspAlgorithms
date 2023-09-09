module Evolutionary

    export eVolution, eVolutionI

    include("evolutionStrategy.jl")

    include("../csp/csp.jl")
    using .Csp
end