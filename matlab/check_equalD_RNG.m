function distribution = check_equalD_RNG(iterations,myStream)
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
options = optimset('Display','off', 'Algorithm', 'interior-point' );
for k = 1:iterations
    design = 2*rand(myStream,n,par)-1;
    [rows,colls] = size(design);
    design_old = design;
    while 1
        for i = 1:rows
            for j = 1:colls
                D0 = D_crit(design);
                objective = @(coordinate) -D_crit(coordinateSwap(coordinate,design,i,j));
                optimal_coordinate = fmincon(objective,design(i,j),[],[],[],[],-1,1,[],options);
                design(i,j) = optimal_coordinate;
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