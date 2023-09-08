function mutate(variables, domain, solution, κ)
    mutatedSolution = copy(solution)
    for chromosome in 1:κ
        mutatedSolution[rand(1:length(variables))] = domain[rand(1:length(domain))]
    end
    return mutatedSolution
end

"Evolution strategy"
function eVolution(variables, domain, constraints, goal, μ, λ, κ)
    Λ = Vector()
    M = Vector()

    # initial population
    for m in 1:μ
        mSolution = Dict()
        for i in variables
            mSolution[i] = rand(domain[1:length(domain)])
        end
        push!(M,mSolution)
    end
    bestSolution = M[1]
    generation = 0

    while !goal(variables, domain, constraints, bestSolution, evaluate)
        generation += 1
        for i in 1:λ
            parent = M[rand(1:length(M))]
            mutatedSolution = mutate(variables, domain, parent,κ)
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
        println("Best: $result, $generation")

        # restart
        M = M[1:μ]
        Λ = Vector()
    end
    return bestSolution
end