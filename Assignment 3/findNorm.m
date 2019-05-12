function norm = findNorm(matrix)
    sq = matrix .* matrix;
    my_sum = sum(sq, 2);
    norm = sqrt(my_sum);
end