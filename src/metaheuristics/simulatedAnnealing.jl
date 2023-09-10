"Simulated Annealing Algorithm"
function simulatedAnnealing(variables, domain, constraints, solution, 
    bestSolution, max, goal, temperature, decay)

    while temperature > 2 && !goal(variables, domain, constraints, solution, evaluate)
        newSolution = copy(solution)
    
        (variable,value) = choose(variables,domain)
        newSolution[variable...] = value    

        result = evaluate(constraints, newSolution)
        if result > evaluate(constraints, bestSolution) 
            bestSolution = copy(newSolution)
            println("Best: $result, T: $temperature K")
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
            end
        end    
    end
    return bestSolution
end