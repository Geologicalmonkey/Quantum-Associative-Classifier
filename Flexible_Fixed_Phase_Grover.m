% =========================================================================

%  input parameter:
%  Phi is phase and it can take any value in (0,2\pi)
%  N is the total number of items
%  m is the estimated number of marked items and t is the real number of marked items
%  m and t can be equal or unequal

% =========================================================================
function [P,J] = Flexible_Fixed_Phase_Grover(Phi,N,m,t)
close all;
Phi = Phi*pi;
J=floor(pi/(4*asin(sin(Phi/2)*sqrt(m/N))));
S_ini=sqrt(1/N)*ones(N,1);
Tao=sqrt(1/t)*[ones(t,1);zeros(N-t,1)];
U=eye(N)-(1-exp(i*Phi))*Tao*Tao';
V=(1-exp(i*Phi))*S_ini*S_ini'-eye(N);
for k=1:J
    S_ini=U*S_ini;
    S_ini=V*S_ini;
end
P = sum(abs(S_ini(1:t,1)).^2);
