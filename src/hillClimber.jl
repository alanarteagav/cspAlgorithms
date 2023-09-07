using Random

function hillClimber(variables, domain, constraints, assignments, evaluate, max)
    originalAssignment = copy(assignments)
    bestAssignment = copy(assignments)
    peak = max
    for variable in variables
        
        for value in domain
            if value != assignments[variable]
                assignments[variable] = value
                result = evaluate(constraints, assignments)
                if result > peak
                    bestAssignment = copy(assignments) 
                    peak = result
                    println("IMP $result, $variable")
                end
            end
        end
        assignments = copy(originalAssignment)
    end
    if peak <= max
        return bestAssignment
    else
        println("CALL: $peak")
        hillClimber(variables, domain, constraints, bestAssignment, evaluate, peak)
    end
end

function hillClimberII(variables, domain, constraints, assignments, evaluate, max)
    originalAssignment = copy(assignments)
    bestAssignment = copy(assignments)
    peak = max

    for variable in variables
        
        for value in domain
            if value != assignments[variable]
                assignments[variable] = value
                result = evaluate(constraints, assignments)
                if result > peak
                    bestAssignment = copy(assignments) 
                    peak = result
                    println("IMP $result, $variable")
                    break
                end
            end
        end
        if peak > max
            println("IMP $peak, $variable")
            break
        end
        assignments = copy(originalAssignment)
    end
    if peak <= max
        return bestAssignment
    else
        println("CALL: $peak")
        shuffle!(variables)
        hillClimberII(variables, domain, constraints, bestAssignment, evaluate, peak)
    end
end

function chooseNeighbour(variables, domain)
    variable = variables[rand(1:length(variables))]
    value = domain[rand(1:length(domain))]
    return (variable,value)
end


function simulatedAnnealing(variables, domain, constraints, solution, bestSolution,
    evaluate, max, goal, temperature, decay)

    while temperature > 2 && !goal(variables, domain, constraints, solution, evaluate)
        newSolution = copy(solution)
    
        (variable,value) = chooseNeighbour(variables,domain)
        newSolution[variable] = value    
        result = evaluate(constraints, newSolution)
        if result > evaluate(constraints, bestSolution) 
            bestSolution = copy(newSolution)
            println("Best: $result, temperature: $temperature ==================")
        end
        
        if result >= max
            solution = copy(newSolution)
        else
            delta = max - result
            probability = exp(- delta / temperature)
            experiment = rand()
            if probability > experiment
                temperature *= decay
                solution = copy(newSolution)
                # println("CHOOSE res: $result, temperature: $temperature")
            end
        end    
    end
    println("END")
    return bestSolution

end


    #=
    println("CALL | PEAK : $peak, temperature: $temperature")
    if temperature < 2
        return
    end
    if goal(variables, domain, constraints, assignments, evaluate)
        return
    end
    for variable in shuffle!(variables)
        for value in shuffle!(domain)
            if value != assignments[variable]
                assignments[variable] = value
                result = evaluate(constraints, assignments)
                # println("RES $result")
                if result > peak
                    bestAssignment = copy(assignments) 
                    peak = result
                    println("IMP $result, $variable =================================")
                    simulatedAnnealing(variables, domain, constraints, bestAssignment, evaluate, peak, goal, temperature)
                else
                    diff = peak - result
                    p = diff/temperature
                    e = exp(-p)
                    r = rand()
                    #println("PROB: $e")
                    #println("RAND: $r")
                    #println("TEMP: $temperature")
                    if e > r
                        #println("PROB: $e")
                        #println("RAND: $r")
                        #println("TEMP: $temperature")
                        temperature *= 0.99
                        simulatedAnnealing(variables, domain, constraints, copy(assignments), evaluate, peak, goal, temperature)
                        return
                    end
                end
            end
        end
        assignments = copy(originalAssignment)        
    end
    =#
