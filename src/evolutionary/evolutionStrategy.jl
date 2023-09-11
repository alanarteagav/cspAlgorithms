using Random

"Evolution strategy"
function eVolution(variables, domain, constraints, solutionTemplate, goal, μ, λ, κ,
    mutation)
    Λ = Vector()
    M = Vector()

    # initial population
    if isempty(solutionTemplate)
        println("tr")
        for m in 1:μ
            mSolution = copy(solutionTemplate)
            for i in variables
                mSolution[i...] = rand(domain[1:length(domain)])
            end
            push!(M,mSolution)
        end
    else 
        for m in 1:μ
            mSolution = mutation(variables, domain, solutionTemplate,κ)
            push!(M,mSolution)
        end
    end 
    bestSolution = M[1]
    generation = 0

    while !goal(variables, domain, constraints, bestSolution, evaluate)
        generation += 1
        for i in 1:λ
            parent = M[rand(1:length(M))]
            mutatedSolution = mutation(variables, domain, parent,κ)
            push!(Λ, mutatedSolution)
        end
        # tournament
        nM = Vector()

        # selection
        sort!(Λ, by=(x) -> evaluate(constraints,x), rev=true)
        for l in 1:μ
            push!(nM,Λ[l])
        end
        M = vcat(M,nM)
        sort!(M, by=(x) -> evaluate(constraints,x), rev=true)
        bestSolution = M[1]
        result = evaluate(constraints,bestSolution)
        # println("Best: $result, $generation")
        if 0 == mod(generation,1000)
            println("Best: $result, $generation")
        end
        # restart
        M = M[1:μ]
        Λ = Vector()
    end
    return bestSolution
end