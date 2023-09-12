using Random

export backtrackingKS, simulatedAnnealingKS, evolutionStrategyKS

λks = function(solution,variables...)
    value = 0
    weight = 0
    for variable in variables
        if solution[variable] == 1
            (vi,wi) = variable
            weight += wi
            value += vi
        end
    end
    if weight > solution[0]
        return -1
    else
        return value
    end
end

λksBool = function(solution,variables...)
    value = 0
    weight = 0
    for variable in variables
        if solution[variable] == 1
            (vi,wi) = variable
            weight += wi
            value += vi
        end
    end
    if weight > solution[0]
        return false
    else
        return true
    end
end

function evaluateKS(solution)
    value = 0
    weight = 0
    for (pair, v) in solution
        if v == 1
            (vi,wi) = pair
            weight += wi
            value += vi
        end
    end
    return (value,weight)
end

function dataToKS(data, constraint)
    (header,pairs) = data
    (elements, capacity) = header

    variables = Vector{}()
    domain = [0,1]
    constraints = Vector{}()
    solution = Dict()

    for pair in pairs
        push!(variables,pair)
    end

    push!(constraints,(variables,constraint))

    for i in variables
        solution[i] = -1
    end
    solution[0] = capacity

    return (variables,domain,constraints,solution,capacity)
end

"Knapsack solution using backtracking"
function backtrackingKS(data)
    goal = (v, d, c, a) -> a[v[end]] != -1

    (variables,domain,constraints,solution,capacity) = dataToKS(data, λksBool)

    ksSuccessor = x -> begin
        index = findfirst(i -> i == x, variables)
        index += 1
        if index <= length(variables)
            return variables[index]
        else    
            return nothing
        end
    end
    
    result = backtracking(variables,domain,constraints,solution, 
        ksSuccessor, goal)

    ev = evaluate(constraints,result)
    println("KS backtracking result (constraints satisfied): [$ev]")
    # println(result)

    (value, weight) = evaluateKS(result)
    println("Weight: [$weight]")
    println("Value: [$value]")

    solutionVector = Vector()
    for (pair,v) in solution
        if v == 1
            push!(solutionVector,pair)
        end
    end
    print(solutionVector)

end

getNeighbourKSSolution = function (solution,variables,domain)
    newSolution = copy(solution)
    count = 0
    while count < 1
        indexes = findall(entry -> entry == 1, solution)
        randomEntry = variables[rand(1:length(variables))]
        if newSolution[randomEntry] != 1
            newSolution[randomEntry] = 1
            newSolution[rand(indexes)] = 0
            count += 1
        end
    end
    return newSolution
end

"Knapsack solution using simulated annealing"
function simulatedAnnealingKS(data,max)
    (variables,domain,constraints,solution,capacity) = dataToKS(data, λks)
     
    shuffle!(variables)
    for variable in variables
        solution[variable] = 0
    end

    weight = 0
    lastVariable = nothing
    for variable in variables
        if rand(0:1) == 1
            (vi,wi) = variable
            solution[variable] = 1
            lastVariable = variable
            weight += wi
        end
        if weight > capacity
            solution[lastVariable] = 0
            weight -= lastVariable[2]
            break
        end
    end

    randomValue = evaluate(constraints,solution)
    println("Random solution value: $randomValue")

    annealingGoal = (v, d, c, s, e) -> e(c,s) >= max

    result = simulatedAnnealing(variables, domain, constraints, solution, 
    solution, evaluate(constraints,solution), annealingGoal, 3e2, 0.999, 
    getNeighbourKSSolution)

    ev = evaluate(constraints,result)
    println("Best KS result (constraints satisfied): [$ev]")

    (value, weight) = evaluateKS(result)
    println("Weight: [$weight]")
    println("Value: [$value]")

    solutionVector = Vector()
    for (pair,v) in solution
        if v == 1
            push!(solutionVector,pair)
        end
    end
    print(solutionVector)
end

ksMutation = function (variables, domain, solution, κ)
    newSolution = copy(solution)
    count = 0
    while count < κ
        indexes = findall(entry -> entry == 1, solution)
        randomEntry = variables[rand(1:length(variables))]
        if newSolution[randomEntry] != 1
            newSolution[randomEntry] = 1
            newSolution[rand(indexes)] = 0
            count += 1
        end
    end
    return newSolution
end

"Knapsack solution using Evolution Strategy"
function evolutionStrategyKS(data,max)
    (variables,domain,constraints,solution,capacity) = dataToKS(data, λks)
     
    shuffle!(variables)
    for variable in variables
        solution[variable] = 0
    end

    weight = 0
    lastVariable = nothing
    for variable in variables
        if rand(0:1) == 1
            (vi,wi) = variable
            solution[variable] = 1
            lastVariable = variable
            weight += wi
        end
        if weight > capacity
            solution[lastVariable] = 0
            weight -= lastVariable[2]
            break
        end
    end

    randomValue = evaluate(constraints,solution)
    println("Random solution value: $randomValue")

    evolutionGoal = (v, d, c, s, e) -> e(c,s) >= max

    result = eVolution(variables,domain,constraints,solution,evolutionGoal,1,1,2, 
        ksMutation,5e5)
    ev = evaluate(constraints,result)
    println("Best KS result (constraints satisfied): [$ev]")

    (value, weight) = evaluateKS(result)
    println("Weight: [$weight]")
    println("Value: [$value]")

    solutionVector = Vector()
    for (pair,v) in solution
        if v == 1
            push!(solutionVector,pair)
        end
    end
    print(solutionVector)
end
