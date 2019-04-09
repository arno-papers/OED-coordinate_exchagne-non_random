function Det_information = D_crit(Design)
% y = x0*beta0 + x1*beta1 + x1^2*beta11 + x2*beta2 + x1x2*beta12
[n,~] = size(Design);
X = zeros(n,5);
for i = 1:n
    X(i,1) = 1;
    X(i,2) = Design(i,1);
    X(i,3) = Design(i,1)^2;
    X(i,4) = Design(i,2);
    X(i,5) = Design(i,1)*Design(i,2);
end
Det_information = det(X'*X);
end