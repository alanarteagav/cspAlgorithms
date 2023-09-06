include("algorithms.jl")
using .Algorithms

lines = readlines("../data/gc_1000")

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
=#

# println(assignments)

println(length(constraints))

r = backtracking(variables,domain,constraints,assignments,[], successor, goal)
println(r)

#=


r = backtracking(variables,domain,constraints,assignments)




println(r)

=#

#println(words)
