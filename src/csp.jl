function isConsistent(constraint, assignments)
    f = constraint[end]
    t = constraint[1]
    f(t...,assignments)
end

function evaluate(constraints,assignments) 
    count = 0
    for constraint in constraints
        if isConsistent(constraint, assignments)
            count += 1
        end
    end
    return count
end