export backtrackingQueens, simulatedAnnealingQueens, evolutionStrategyQueens,
    getRowConstraints, getConstraints, getColumnConstraints, getDiagonalConstraints,
    λr

λr = function(board,r...)
    n = sum(i->board[i[1],i[2]],r)
    return (n*(n-1))÷2
end

function getRowConstraints(n)   
    # rowConstraints = Vector{Tuple{Ntuple{n,Tuple{Int64,Int64}},Function}}()
    rowConstraints = Vector()
    for i in 1:n
        tuple = ntuple(j -> (i,j),n)
        push!(rowConstraints, (tuple, λr))
    end
    return rowConstraints
end

function getColumnConstraints(n)   
    columnConstraints = Vector()
    for j in 1:n
        tuple = ntuple(i -> (i,j),n)
        push!(columnConstraints, (tuple,λr))
    end
    return columnConstraints
end

function getDiagonalConstraints(n)   
    diagonalConstraints = Vector{}()
    for i in 1:n
        if i == 1
            tuple = ntuple(j -> (i+(j-1),j),n-(i-1))
            push!(diagonalConstraints, (tuple,λr))
        else
            tupleD = ntuple(j -> (i+(j-1),j),n-(i-1))
            push!(diagonalConstraints, (tupleD,λr))
            tupleU = ntuple(j -> (j,i+(j-1)),n-(i-1))
            push!(diagonalConstraints, (tupleU,λr))
        end
    end
    for i in 1:n
        if i == n
            tuple = ntuple(j -> ((i+1)-j,j),i)
            push!(diagonalConstraints, (tuple,λr))
        else
            tupleD = ntuple(j -> ((i+1)-j,j),i)
            push!(diagonalConstraints, (tupleD,λr))
            tupleU = ntuple(j -> (n-(j-1),j+(n-i)),i)
            push!(diagonalConstraints, (tupleU,λr))
        end
    end
    return diagonalConstraints
end

function getConstraints(n)
    board = zeros(Int64,n,n)
end