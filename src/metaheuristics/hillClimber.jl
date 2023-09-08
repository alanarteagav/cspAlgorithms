using Random

"Hill Climber Algorithm"
function hillClimber(variables, domain, constraints, assignments, max)
    originalAssignment = copy(assignments)
    bestAssignment = copy(assignments)
    peak = max
    for variable in variables
        for value in domain
            if value != assignments[variable...]
                assignments[variable...] = value
                result = evaluate(constraints, assignments)
                if result > peak
                    bestAssignment = copy(assignments) 
                    peak = result
                end
            end
        end
        if peak > max
            break
        end
        assignments = copy(originalAssignment)
    end
    if peak <= max
        return bestAssignment
    else
        hillClimber(variables, domain, constraints, bestAssignment, peak)
    end
end

"Hill Climber (I)mproved Algorithm"
function hillClimberI(variables, domain, constraints, assignments, max)
    originalAssignment = copy(assignments)
    bestAssignment = copy(assignments)
    peak = max

    for variable in variables
        
        for value in domain
            if value != assignments[variable...]
                assignments[variable...] = value
                result = evaluate(constraints, assignments)
                if result > peak
                    bestAssignment = copy(assignments) 
                    peak = result
                    break
                end
            end
        end
        if peak > max
            break
        end
        assignments = copy(originalAssignment)
    end
    if peak <= max
        return bestAssignment
    else
        shuffle!(variables)
        hillClimberII(variables, domain, constraints, bestAssignment, evaluate, peak)
    end
end