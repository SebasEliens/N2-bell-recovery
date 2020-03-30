% Some concistency checks for main tensors
function tests = testTensors
tests = functiontests(localfunctions);
end

function testSVDofDtensors(testCase)
% Tests D = USVt using tensor network contraction
n=5;m=4;
atol = 1e-12;
D = D_axf(n,m);
U = U_axcz(n,m);
S = S_czcz(n,m);
PI = PI_czf(n,m);
V = V_fg(n,m);
USVt = ncon({U,S,PI,V},{[-1,-2,1,2],[1,2,3,4],[3,4,5],[-3,5]});
% % Uncomment to compare D = USVt as matrices in output
% reshape(D,n*m,n^m)
% reshape(USVt,n*m,n^m)
verifyEqual(testCase,USVt,D, 'AbsTol', atol)
end


function testSVDofDmatrices(testCase)
% Tests D = USVt using matrix multiplication
n=4;m=3;
atol = 1e-12;
D = reshape(D_axf(n,m), n*m,n^m);
U = reshape(U_axcz(n,m), n*m, n*m);
S = reshape(S_czcz(n,m),n*m,n*m);
PI = reshape(PI_czf(n,m),n*m,n^m);
V = reshape(V_fg(n,m),n^m,n^m);
Dcheck = U*S*PI*V';
verifyEqual(testCase,Dcheck,D, 'AbsTol', atol)
end

function testProjectors(testCase)
% Test the projectors
n=2;m=2;
S = S_czcz(n,m);
Si = Si_czcz(n,m);
PI = PI_czf(n,m);
PIt = PI_fcz(n,m);
SSi = ncon({S,Si},{[-1,-2,1,2],[1,2,-3,-4]});
PIPIt = ncon({PI,PIt},{[-1,-2,1],[1,-3,-4]});
verifyEqual(testCase,SSi,PIPIt);
S = reshape(S,n*m,n*m);
Si = reshape(Si,n*m,n*m);
PI = reshape(PI,n*m,n^m);
PIt = reshape(PIt,n^m,n*m);
verifyEqual(testCase,PI',PIt);
verifyEqual(testCase,S*Si,PI*PIt);
end

