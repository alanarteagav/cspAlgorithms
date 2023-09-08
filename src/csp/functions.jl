function satisfies(constraint, solution)
    f = constraint[end]
    t = constraint[1]
    f(solution,t...)
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
        count += satisfies(constraint, solution)
    end
    return count
end

function choose(variables, domain)
    variable = variables[rand(1:length(variables))]
    value = domain[rand(1:length(domain))]
    return (variable,value)
end