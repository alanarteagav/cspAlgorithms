"Backtracking search algorithm"
function backtracking(variables, domain, constraints, solution, successor, goal)
    return backtrackingAux(variables, domain, constraints, solution, [], 
        successor, goal)
end

"Backtracking search algorithm auxiliary function"
function backtrackingAux(variables, domain, constraints, solution, stack, 
    successor, goal)

    variable = variables[1]
    explore = true 
    while !goal(variables, domain, constraints, solution)
        if explore 
            for value in domain
                solution[variable...] = value
                if isConsistent(constraints,solution)
                    push!(stack, (variable,value))
                end
            end
        end
        explore = true
        (var, val) = pop!(stack)
        solution[var...] = val
        if successor(var) in variables
            variable = successor(var) 
        else
            (vr, vl) = pop!(stack)
            explore = false
        end
    end
    return solution
end

"Backtracking search algorithm (recursive version)"
function backtrackingR(variables, domain, constraints, solution, goal)
    (result, solved) = backtrackingRaux(1, variables, domain, 
        constraints, copy(solution), goal)
    if solved
        return result
    else
        return solution
    end
end

"Backtracking search algorithm (recursive version) auxiliary function"
function backtrackingRaux(i, variables, domain, constraints, solution, goal)
    if i > length(variables)
        return (solution, false)
    end
    variable = variables[i]
    if goal(variables, domain, constraints, solution)
        return (solution, true)
    end
    for value in domain
        solution[variable...] = value
        if isConsistent(constraints,solution)
            (result, solved) = backtrackingRaux(i+1, variables, 
                domain, constraints, copy(solution), goal)
            if solved
                return (result, solved)
            end
        end
    end
    return (solution, false)
end