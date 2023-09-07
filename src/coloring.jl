include("algorithms.jl")
using .Algorithms

include("metaheuristics.jl")
using .Metaheuristics

using Random

lines = readlines("../data/gc_50")

edges = []

header = popfirst!(lines)
header = split(header," ", limit = 2)

order = parse(UInt64, header[1])
size = parse(UInt64, header[2])

println(order)
println(size)

variables = Vector{Int64}()
domain = Vector{Int64}()
constraints = Vector{Tuple{Tuple{Int64,Int64},Function}}()
assignments = Dict()

constraint = (x,y,a) -> if (a[x],a[y]) != (-1,-1)
    a[x] != a[y]
else
    true
end

successor = x -> x + 1

for i in 0:order-1
    append!(variables,i)
    append!(domain,i)
end

reverse!(domain)

for line in lines
    sp = split(line," ", limit = 2)
    u = parse(Int64, sp[1])
    v = parse(Int64, sp[2])
    push!(constraints,((u,v),constraint))
end 

for i in variables
    assignments[i] = -1
end


# println(variables[end])

goal = (v, d, c, a) -> a[v[end]] != -1

#=
d = Dict(0 => 1, 1 => 1, 2 => 2, 3 => 3, 4 => 1)
for c in constraints
    r = isConsistent(c,d)
    println("$r, $c")
end


# println(assignments)

println(length(constraints))
=#


#=

r = backtracking(variables,domain,constraints,assignments,[], successor, goal)
println(r)

assignmentsII = copy(assignments)

x = backtrackingR(variables[1], variables,domain,constraints,assignmentsII, successor, goal)
println(x)


domains = Dict()
for variable in variables
    domains[variable] = copy(domain)
end

filter = (variable, variables, domains, assignments) -> 

println(domains)
=#



# =========== HILL CLIMBER

ev = function evaluate(constraints,assignments) 
    count = 0
    for constraint in constraints
        f = constraint[end]
        t = constraint[1]
        if f(t...,assignments)
            count += 1
        end
    end
    return count
end


hcAssignments = Dict{Int64,Int64}()

for i in variables
    hcAssignments[i] = rand(0:order-1)
end

variablesHC = reverse(variables)
shuffle!(variablesHC)

# println(hcAssignments)
println("EVALOLD:")
println(evaluate(constraints,hcAssignments))

z = hillClimberII(variablesHC,domain,constraints,hcAssignments,evaluate,evaluate(constraints,hcAssignments))
println(hcAssignments)
println("EVALNEW:")
println(evaluate(constraints,z))
#=




r = backtracking(variables,domain,constraints,assignments)




println(r)

=#

#println(words)
