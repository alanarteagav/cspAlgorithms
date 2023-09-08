module CspAlgorithms
    include("src/problems/Problems.jl")
    using .Problems

    include("src/Csp/Csp.jl")
    using .Csp

    coloringData = readInput("./data/gc_50")
    
    # backtrackingColoring(coloringData)
    # simulatedAnnealingColoring(coloringData)
    # evolutionStrategyColoring(coloringData)

    
    
    n = 8
    z = zeros(Int64,n,n)

     z[1,1] = 1
    # z[1,2] = 1
    # z[1,5] = 1
    # z[1,8] = 1
    # z[2,8] = 1
    # z[2,3] = 1
    # z[2,4] = 1
     z[2,2] = 1
    

    rC = getRowConstraints(n)
    cC = getColumnConstraints(n)
    dC = getDiagonalConstraints(n)

    ev = evaluate(rC,z)
    println(ev)

    ev2 = evaluate(cC,z)
    println(ev2)

    ev3 = evaluate(dC,z)
    println(ev3)


    


    #=
    println("===")

    restC = getColumnConstraints(n)
    for c in restC
        # println(c)
    end

    restD = getDiagonalConstraints(n)
    for d in restD
        # println(d)
        # println(length(d))
    end

    =#
    
end


