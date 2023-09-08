module CspAlgorithms
    include("src/problems/Problems.jl")
    using .Problems

    include("src/Csp/Csp.jl")
    using .Csp

    coloringData = readInput("./data/gc_50")
    
    # backtrackingColoring(coloringData)
    # simulatedAnnealingColoring(coloringData)
    # evolutionStrategyColoring(coloringData)

    backtrackingQueens(10)

    #=
    
    n = 5
    z = zeros(Int64,n,n)

    #=
    z[1,1] = 0
    z[1,2] = 0
    z[1,5] = 0
    z[1,8] = 0
    # z[2,8] = 0
    # z[2,3] = 0
    # z[2,4] = 0
    z[2,2] = 0
    z[1,8] = 0
    z[8,1] = 0
    =#
    

    #=
    rC = getRowConstraints(n,λsum)
    cC = getColumnConstraints(n,λsum)
    dC = getDiagonalConstraints(n,λsum)


    ev = evaluate(rC,z)
    println(ev)

    ev2 = evaluate(cC,z)
    println(ev2)

    ev3 = evaluate(dC,z)
    println(ev3)

    c = getConstraints(n,λsum)
    evGlobal = evaluate(c,z)
    println(evGlobal)
    =#

    cBool = getConstraints(n,λbool)

    bl = isConsistent(cBool,z)
    println(bl)

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
    =#
end


