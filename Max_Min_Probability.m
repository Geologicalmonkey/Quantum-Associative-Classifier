% =========================================================================

% This program displays the numerical results of Lemma 3
% Let m be any positive integer, and q be a randomly selected positive integer with uniform distribution between 0 and m-1
% Let P2 be the probability of obtaining a solution after performing q iteration, and P1 be the upper bound of P2 
% The program gives the numerical results of P2 and P1
% The theoretical results of P1 and P2 are as follows:
% P2 = 1/(c*(1-cos(delta)))*(1+cos(Phi(i))*cos(delta)-((cos(delta)+cos(Phi(i)))*sin(2*m*delta))/(2*m*sin(delta)))
% P1 = (2*cos(Phi(i)).*sin(theta(j)).^2+cos(theta(j)).^2+2)./(4-2*sin(theta(j)).^2.*(1-cos(Phi(i))))

% =========================================================================
clear all
close all
clc
Phi=pi:0.0001*pi:2*pi-0.0001*pi;
theta=0.0001*pi/3:0.0001*pi/3:pi/3;
for i=1:length(Phi)
    c=2*sin(Phi(i)/2)^2;
    for j=1:length(theta)
        delta=acos(2*sin(theta(j))^2*sin(Phi(i)/2)^2-1);
        P1(i,j)=(2*cos(Phi(i)).*sin(theta(j)).^2+cos(theta(j)).^2+2)./(4-2*sin(theta(j)).^2.*(1-cos(Phi(i))));
        P2(i,j)=1/(c*(1-cos(delta)))*(1+cos(Phi(i))*cos(delta)-((cos(delta)+cos(Phi(i)))*sin(2*ceil(1/sin(delta))*delta))/(2*ceil(1/sin(delta))*sin(delta)));
    end
    if mod(i,100)==0
        disp([num2str(i)])
    end
end
[a,b]=sort(P1);
[c,d]=sort(a,2);
c_min=d(1,1);
r_min=b(1,c_min);
P1_min=P1(r_min,c_min)
c_max=d(end,end);
r_max=b(end,c_max);
P1_max=P1(r_max,c_max)

[a,b]=sort(P2);
[c,d]=sort(a,2);
c_min=d(1,1);
r_min=b(1,c_min);
P2_min=P2(r_min,c_min)
c_max=d(end,end);
r_max=b(end,c_max);
P2_max=P2(r_max,c_max)

save Pmax P1 P1_min P1_max P2 P2_min P2_max
