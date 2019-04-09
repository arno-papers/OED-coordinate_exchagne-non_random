k = 0;
iterations = 10;
distributionD = check_equalD(1);
save('distD.mat')
while k < 10
    k
    k = k+1;  
    load('distD.mat')
    distributionD_new = check_equalD(iterations);
    distributionD = distributionD + distributionD_new;
    save('distD.mat','distributionD')
end
figure,
[sortedD,indD] = sort(distributionD,'descend');
plot(sortedD,'LineWidth',2)
xlabel('Permutations')
ylabel('Number of times found')
set(gca,'fontsize',16)
box off
xlim([0 720])
xticks(0:120:720)
print -dpng -r300 D.png

real_opt = [
    1.0000    1.0000;
    1.0000   -1.0000;
    -1.0000    1.0000;
    -1.0000   -1.0000;
    0.0000    1.0000;
    0.0000   -1.0000];
permutations = unique(perms([1 2 3 4 5 6]),'rows');
order = permutations(indD,:);
perm_sorted = [];
for k = 1:length(indD)
    perm_sorted = [perm_sorted, real_opt(order(k,:),:), NaN(6,1)];
end

expected = sum(distributionD)/length(distributionD);
chi_star = 0;
for k = 1:length(distributionD)
    chi_star = chi_star + ((distributionD(k)-expected)^2)/expected;
end
p = chi2cdf(chi_star,length(distributionD)-1,'upper')

vertices = [
    1.0000    1.0000;
    1.0000   -1.0000;
    -1.0000    1.0000;
    -1.0000   -1.0000;];
permutation_vertices = unique(perms([1 2 3 4]),'rows');
number_vert = 0
for k = 1:length(indD)
    design_k = real_opt(order(k,:),:);
    for i = 1:size(permutation_vertices,1)
        if isequal(design_k(1:4,:),vertices(permutation_vertices(i,:),:))
            design_k
            sortedD(k)
            number_vert = number_vert+ sortedD(k);
        end
    end
end
number_vert
% corner points are first 4 runs
% 12779 van de 56046

number_vert = 0
for k = 1:length(indD)
    design_k = real_opt(order(k,:),:);
    for i = 1:size(permutation_vertices,1)
        if isequal(design_k([1 2 3 5],:),vertices(permutation_vertices(i,:),:))
            design_k
            sortedD(k)
            number_vert = number_vert + sortedD(k);
        end
    end
end
number_vert
% corner points are first 3 runs and 5th run
% 7608 van de 56046


