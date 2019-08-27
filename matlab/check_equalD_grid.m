function distribution = check_equalD_grid(iterations)
n = 6;
par = 2;
real_opt = [
    1.0000    1.0000;
    1.0000   -1.0000;
    -1.0000    1.0000;
    -1.0000   -1.0000;
    0.0000    1.0000;
    0.0000   -1.0000];
permutations = unique(perms([1 2 3 4 5 6]),'rows');
distribution = zeros(1,factorial(n));
grid = -1:0.1:1;
for k = 1:iterations
    design = 2*rand(n,par)-1;
    [rows,colls] = size(design);
    design_old = design;
    while 1
        for i = 1:rows
            for j = 1:colls
                for g = grid
                    design_test = coordinateSwap(g,design,i,j);
                    if D_crit(design_test) > D_crit(design)
                        design = design_test;
                    end
                end
            end
        end
        if design == design_old
            break
        end
        design_old = design;
    end
    design = round(design,2);
    for l = 1:factorial(n)
        order = permutations(l,:);
        permutation_real_opt = real_opt(order,:);
        if isequal(design,permutation_real_opt)
            distribution(l) = distribution(l) + 1;
        end
    end
end
end