include("algorithms.jl")
using .Algorithms

x = 2
x = aFunction(2,3)

it([2,3,4,5])


d = Dict()
 

vertices = 1000

variables = []
domain = []

for variables = 1:vertices
    append!(variables,variable)
end

for variables = 1:vertices
    append!(variables,variable)
end


constraints = []
assignments = Dict()

r = backtracking(variables,domain,constraints,assignments)

println(r)
