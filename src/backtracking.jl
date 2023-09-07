function isConsistent(constraint, assignments)
    f = constraint[end]
    t = constraint[1]
    f(t...,assignments)
end

function backtracking(variables, domain, constraints, assignments, stack, 
    successor, goal)

    i = 0
    variable = variables[i+1]

    while !goal(variables, domain, constraints, assignments)
    # for j in 0:length(variables)
        for value in domain
            assignments[variable] = value
            consistent = true
            for constraint in constraints 
                if !isConsistent(constraint,assignments)
                    consistent = false
                    break
                end
            end
            if consistent
                push!(stack, (variable,value))
            end
        end
        # println(stack)
        (var, val) = pop!(stack)
        assignments[var] = val
        variable = successor(var)
        # println(goal(variables,domain,constraints,assignments))
    end
    return assignments
end

# g = SimpleGraph(UInt8(10))
function backtrackingR(variable, variables, domain, constraints, assignments, 
    successor, goal)

    if goal(variables, domain, constraints, assignments)
        return (assignments, true)
    end
    for value in domain
        assignments[variable] = value
        consistent = true
        for constraint in constraints 
            if !isConsistent(constraint,assignments)
                consistent = false
                break
            end
        end
        if consistent
            (a,finished) = backtrackingR(successor(variable), variables, domain, 
                constraints, assignments, successor, goal)
            if finished
                return (a,finished)
            end
        end
    end
end


function backtrackingF(variable, variables, domain, constraints, assignments, 
    domains, filter, successor, goal)

    if goal(variables, domain, constraints, assignments)
        return (assignments, true)
    end
    for value in domains[variable]
        assignments[variable] = value
        consistent = true
        for constraint in constraints 
            if !isConsistent(constraint,assignments)
                consistent = false
                break
            end
        end
        if consistent
            # remove from domains
            filter(variable, variables, domains, assignments)
            (a,finished) = backtrackingR(successor(variable), variables, domain, 
                constraints, assignments, successor, goal)
            if finished
                return (a,finished)
            end
        end
    end
end