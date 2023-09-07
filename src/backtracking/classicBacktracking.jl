"Backtracking search algorithm"
function backtracking(variables, domain, constraints, solution, successor, goal)
    return backtrackingAux(variables, domain, constraints, solution, [], 
        successor, goal)
end

"Backtracking search algorithm auxiliary function"
function backtrackingAux(variables, domain, constraints, solution, stack, 
    successor, goal)

    variable = variables[1]
    while !goal(variables, domain, constraints, solution)
        for value in domain
            solution[variable] = value
            if isConsistent(constraints,solution)
                push!(stack, (variable,value))
            end
        end
        (var, val) = pop!(stack)
        solution[var] = val
        variable = successor(var)
        println("Solved variables: $variable")
    end
    return solution
end

"Backtracking search algorithm (recursive version)"
function backtrackingR(variables, domain, constraints, solution, successor, goal)
    (result, solved) = backtrackingRaux(variables[1], variables, domain, 
        constraints, copy(solution), successor, goal)
    if solved
        return result
    else
        return solution
    end
end

"Backtracking search algorithm (recursive version) auxiliary function"
function backtrackingRaux(variable, variables, domain, constraints, solution, 
    successor, goal)
    if goal(variables, domain, constraints, solution)
        return (solution, true)
    end
    for value in domain
        solution[variable] = value
        if isConsistent(constraints,solution)
            (result, solved) = backtrackingRaux(successor(variable), variables, 
                domain, constraints, copy(solution), successor, goal)
            if solved
                return (result, solved)
            end
        end
    end
    return (solution, false)
end