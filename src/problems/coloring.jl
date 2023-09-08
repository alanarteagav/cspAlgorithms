export backtrackingColoring, simulatedAnnealingColoring, evolutionStrategyColoring

constraint = (x,y,a) -> if (a[x],a[y]) != (-1,-1)
    a[x] != a[y]
else
    true
end

successor = x -> x + 1

function dataToProblem(data, constraint)
    (header,pairs) = data
    (order, size) = header

    variables = Vector{Int64}()
    domain = Vector{Int64}()
    constraints = Vector{Tuple{Tuple{Int64,Int64},Function}}()
    assignments = Dict()

    for i in 0:order-1
        append!(variables,i)
        append!(domain,i)
    end

    #reverse!(domain)

    for pair in pairs
        push!(constraints,(pair,constraint))
    end 

    for i in variables
        assignments[i] = -1
    end
    return (variables,domain,constraints,assignments)
end
    
"Graph Coloring solution using backtracking"
function backtrackingColoring(data)
    goal = (v, d, c, a) -> a[v[end]] != -1

    (variables,domain,constraints,assignments) = dataToProblem(data, constraint)
    result = backtracking(variables,domain,constraints,assignments, 
        successor, goal)

    ev = evaluate(constraints,result)
    println("Coloring backtracking result (constraints satisfied): [$ev]")
end

"Graph Coloring solution using Simulated Annealing"
function simulatedAnnealingColoring(data)
    (variables,domain,constraints,assignments) = dataToProblem(data, constraint)

    for i in variables
        assignments[i] = rand(0:length(variables)-1)
    end

    solution = assignments

    randomValue = evaluate(constraints,solution)
    println("Random solution value: $randomValue")
    
    goalValue = length(constraints)
    println("Constraint goal: $goalValue")
    
    annealingGoal = (v, d, c, a, e) -> e(c,a) == length(c)
    
    result = simulatedAnnealing(variables, domain, constraints, solution, 
        solution, evaluate(constraints,solution), annealingGoal, 200, 0.9999)

    ev = evaluate(constraints,result)
    println("Best SA result (constraints satisfied): [$ev]")
end

"Graph Coloring solution using Evolution Strategy"
function evolutionStrategyColoring(data)
    (variables,domain,constraints,assignments) = dataToProblem(data, constraint)

    goalValue = length(constraints)
    println("Constraint goal: $goalValue")

    evolutionGoal = (v, d, c, a, e) -> e(c,a) == length(c)

    result = eVolution(variables,domain,constraints,evolutionGoal,1,1,4)
    ev = evaluate(constraints,result)
    println("Best ES result (constraints satisfied): [$ev]")
end