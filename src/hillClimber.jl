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

function simulatedAnnealing(variables, domain, constraints, assignments, evaluate, max)
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