using Random

export backtrackingQueens, simulatedAnnealingQueens, evolutionStrategyQueens

λconsistent = function(board,r...)
    n = sum(i->board[i[1],i[2]],r)
    if n > 1 
        return false
    else
        return true
    end
end

λattacks = function(board,r...)
    n = sum(i->board[i[1],i[2]],r)
    return -((n*(n-1))÷2)
end

function getRowConstraints(n,λ)   
    # rowConstraints = Vector{Tuple{Ntuple{n,Tuple{Int64,Int64}},Function}}()
    rowConstraints = Vector()
    for i in 1:n
        tuple = ntuple(j -> (i,j),n)
        push!(rowConstraints, (tuple, λ))
    end
    return rowConstraints
end

function getColumnConstraints(n,λ)   
    columnConstraints = Vector()
    for j in 1:n
        tuple = ntuple(i -> (i,j),n)
        push!(columnConstraints, (tuple,λ))
    end
    return columnConstraints
end

function getDiagonalConstraints(n,λ)   
    diagonalConstraints = Vector{}()
    for i in 1:n
        if i == 1
            tuple = ntuple(j -> (i+(j-1),j),n-(i-1))
            push!(diagonalConstraints, (tuple,λ))
        else
            tupleD = ntuple(j -> (i+(j-1),j),n-(i-1))
            push!(diagonalConstraints, (tupleD,λ))
            tupleU = ntuple(j -> (j,i+(j-1)),n-(i-1))
            push!(diagonalConstraints, (tupleU,λ))
        end
    end
    for i in 1:n
        if i == n
            tuple = ntuple(j -> ((i+1)-j,j),i)
            push!(diagonalConstraints, (tuple,λ))
        else
            tupleD = ntuple(j -> ((i+1)-j,j),i)
            push!(diagonalConstraints, (tupleD,λ))
            tupleU = ntuple(j -> (n-(j-1),j+(n-i)),i)
            push!(diagonalConstraints, (tupleU,λ))
        end
    end
    return diagonalConstraints
end

function getConstraints(n,λ)
    constraints = Vector{}()
    rowConstraints = getRowConstraints(n,λ)
    columnConstraints = getColumnConstraints(n,λ)
    diagonalConstraints = getDiagonalConstraints(n,λ)
    constraints = vcat(rowConstraints, columnConstraints, diagonalConstraints)
    return constraints
end

"N Queens solution using backtracking"
function backtrackingQueens(n)
    goal = (v, d, c, sol) -> begin
            sum(sol) == isqrt(length(v))
        end

    variables = Vector{Tuple{Int64,Int64}}()
    for i in 1:n
        for j in 1:n
           push!(variables,(i,j)) 
        end
    end
    domain = [0,1]
    constraints = getConstraints(n,λconsistent)
    board = zeros(Int64,n,n)

    successor = x -> begin
        if x[2]+1 <= n
            (x[1],x[2]+1)
        else    
            (x[1]+1,1)
        end
    end
    solution = backtracking(variables,domain,constraints,board,successor,goal)
    println(sum(solution))
    println(solution)
end

mutation = function(variables, domain, board, κ)
    mutatedBoard = copy(board)
    count = 0
    while count < κ
        indexes = findall(entry -> entry == 1, board)
        randomEntry = rand(1:length(variables))
        if mutatedBoard[randomEntry] != 1
            mutatedBoard[randomEntry] = 1
            mutatedBoard[rand(indexes)] = 0
            count += 1
        end
    end
    return mutatedBoard
end

"N Queens solution using Simulated Annealing"
function simulatedAnnealingQueens(n)

    variables = Vector{Tuple{Int64,Int64}}()
    for i in 1:n
        for j in 1:n
           push!(variables,(i,j)) 
        end
    end
    domain = [0,1]
    constraints = getConstraints(n,λattacks)
    board = zeros(Int64,n,n)
    while sum(board) != n
        board[rand(1:length(board))] = 1
    end

    randomValue = evaluate(constraints,board)
    println("Random solution value: $randomValue")

    goalValue = 0
    println("Constraint goal: $goalValue attacks")

    annealingGoal = (v, d, c, a, e) -> e(c,a) == 0 
    
    result = simulatedAnnealing(variables, domain, constraints, board, 
        board, evaluate(constraints,board), annealingGoal, 200, 0.9999)

    ev = evaluate(constraints,result)
    println("Best SA result (constraints satisfied): [$ev]")
    println(result)
    queens = sum(result)
    println("Total queens: $queens")
end

"N Queens solution using Evolution Strategy"
function evolutionStrategyQueens(n)

    variables = Vector{Tuple{Int64,Int64}}()
    for i in 1:n
        for j in 1:n
           push!(variables,(i,j)) 
        end
    end
    domain = [0,1]
    constraints = getConstraints(n,λattacks)
    board = zeros(Int64,n,n)
    while sum(board) != n
        board[rand(1:length(board))] = 1
    end

    goalValue = 0
    println("Constraint goal: $goalValue attacks")

    evolutionGoal = (v, d, c, a, e) -> e(c,a) == 0 

    result = eVolution(variables,domain,constraints,board,evolutionGoal,1,1,2,
        mutation)
    ev = evaluate(constraints,result)
    println("Best ES result (constraints satisfied): [$ev]")
    println(result)
    queens = sum(result)
    println("Total queens: $queens")
end