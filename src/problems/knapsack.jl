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

    push!(constraints,(variables,λks))

    for i in variables
        solution[i] = -1
    end
    solution[0] = capacity

    return (variables,domain,constraints,solution)
end

"Knapsack solution using backtracking"
function backtrackingKS(data)
    goal = (v, d, c, a) -> a[v[end]] != -1

    (variables,domain,constraints,solution) = dataToKS(data, constraint)

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
    println(result)

    (value, weight) = evaluateKS(result)
    println("Weight: [$weight]")
    println("Value: [$value]")
    
end
