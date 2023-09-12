using Random

"Evolution strategy with Tabu list"
function evolutionTabu(variables, domain, constraints, solutionTemplate, goal, μ, λ, κ,
    mutation, maxGenerations)
    Λ = Vector()
    M = Vector()
    # tabu list
    τ = Vector()

    # initial population
    if isempty(solutionTemplate)
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
        while length(Λ) != λ 
            parent = M[rand(1:length(M))]
            mutatedSolution = mutation(variables, domain, parent,κ)
            if !(mutatedSolution in τ)
                push!(τ, mutatedSolution)
                push!(Λ, mutatedSolution)
            else
                println("Already seen")
            end
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
        println("Best: $result, $generation")
        if 0 == mod(generation,1000)
            # println("Best: $result, $generation")
        end
        if generation >= maxGenerations
            return bestSolution
        end
        # restart
        M = M[1:μ]
        Λ = Vector()
    end
    return bestSolution
end