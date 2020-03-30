%% Main function to generate tests
function tests = testBehaviors
tests = functiontests(localfunctions);
end

%%Test Functions
function testP_rand(testCase)
% Checks if generated P_abxy is indeed conditional probability
n=3;m=4;
atol = 1e-15;
P = reshape(P_rand(n,m),n*n,m*m);
verifyEqual(testCase,sum(P,1),repmat(1,1,m*m),'AbsTol',atol)
end


%
function testP_ns(testCase)
% Checks if generated P_abxy is probability and satisfies no-signalling
n=5;m=3;
atol1 = 1e-15;
atol2 = 1e-14;
P = P_ns(n,m);
% Test probability
verifyEqual(testCase,sum(reshape(P,n*n,m*m),1),repmat(1,1,m*m),'AbsTol',atol1)
% Test no-signalling
PA = reshape(sum(P,2),n,m,m);
PB = permute(reshape(sum(P,1),n,m,m),[1 3 2]);
verifyEqual(testCase,reshape(PA,n*m,m),repmat(reshape(PA(:,:,1),n*m,1),1,m),'AbsTol',atol2)
verifyEqual(testCase,reshape(PB,n*m,m),repmat(reshape(PB(:,:,1),n*m,1),1,m),'AbsTol',atol2)
end
