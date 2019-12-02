% example of parfor in Matlab
parpool('local',32); % setup parallel with 32 workers
tic
n = 200;
A = 500;
a = zeros(1,n);
parfor i = 1:n
    a(i) = max(abs(eig(rand(A))));
end
toc
