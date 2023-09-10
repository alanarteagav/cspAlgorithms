using Random
using Distributions 

export simulatedAnnealingEgg, evolutionStrategyEgg

f = (x1,x2) -> -(x2+47)*sin(sqrt(abs(x2+x1/2+47)))-x1*sin(sqrt(abs(x1-(x2+47))))

λsolution = function(solution,x1,x2)
    n = -(f(solution[x1],solution[x2]))
    return n
end

getEggNeighbour = function(solution,variables,domain)
    neighbourSolution = copy(solution)
    ok = false
    while !ok
        Δ1 = rand(-1:2:1)
        Δ2 = rand(-1:2:1)
        x1 = solution[1] + Δ1
        x2 = solution[2] + Δ2
        if -512 <= x1 <= 512 && -512 <= x2 <= 512
            ok = true
            neighbourSolution[1] = x1
            neighbourSolution[2] = x2
            break
        end
    end
    return neighbourSolution
end

"N Queens solution using Simulated Annealing"
function simulatedAnnealingEgg()
    variables = Vector{}()
    push!(variables,1)
    push!(variables,2)
    domain = [0,1]
    solution = Dict()
    solution[1]= rand(Uniform(-512,512))
    solution[2]= rand(Uniform(-512,512))

    constraints = Vector()
    push!(constraints,((1,2),λsolution))

    goalValue = -959.7
    println("Goal: $goalValue")

    annealingGoal = (v, d, c, a, e) -> f(a[1],a[2]) <= -959.5
    
    result = simulatedAnnealing(variables, domain, constraints, solution, 
        solution, f(solution[1],solution[2]), annealingGoal, 200, 0.9999,
        getEggNeighbour)

    ev = evaluate(constraints,result)
    println("Best SA result (constraints satisfied): [$ev]")
    println(result)
end

eggMutation = function(variables, domain, solution, κ)
    mutatedSolution = copy(solution)
    ok = false
    while !ok
        Δ1 = rand(Uniform(-κ,κ))
        Δ2 = rand(Uniform(-κ,κ))
        x1 = solution[1] + Δ1
        x2 = solution[2] + Δ2
        if -512 <= x1 <= 512 && -512 <= x2 <= 512
            ok = true
            mutatedSolution[1] = x1
            mutatedSolution[2] = x2
            break
        end
    end
    return mutatedSolution
end

"Eggholder solution using Evolution Strategy"
function evolutionStrategyEgg()
    variables = Vector{}()
    push!(variables,1)
    push!(variables,2)
    domain = [0,1]
    solution = Dict()
    solution[1]= rand(Uniform(-512,512))
    solution[2]= rand(Uniform(-512,512))

    constraints = Vector()
    push!(constraints,((1,2),λsolution))

    goalValue = -959.7
    println("Goal: $goalValue")

    evolutionGoal = (v, d, c, a, e) -> f(a[1],a[2]) <= -959.5

    result = eVolution(variables,domain,constraints,solution,evolutionGoal,3,7,500,
        eggMutation)
    ev = evaluate(constraints,result)
    println("Best ES result: [$ev]")
    println(result)
end