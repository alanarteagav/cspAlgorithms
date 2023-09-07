function satisfies(constraint, solution)
    f = constraint[end]
    t = constraint[1]
    f(t...,solution)
end

function isConsistent(constraints, solution)
    for constraint in constraints
        if !satisfies(constraint,solution)
            return false
        end
    end
    return true
end

function evaluate(constraints,solution) 
    count = 0
    for constraint in constraints
        if satisfies(constraint, solution)
            count += 1
        end
    end
    return count
end

function chooseNeighbour(variables, domain)
    variable = variables[rand(1:length(variables))]
    value = domain[rand(1:length(domain))]
    return (variable,value)
end