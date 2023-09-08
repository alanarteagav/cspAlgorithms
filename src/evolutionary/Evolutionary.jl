module Evolutionary

    export eVolution

    include("evolutionStrategy.jl")

    include("../csp/csp.jl")
    using .Csp
end