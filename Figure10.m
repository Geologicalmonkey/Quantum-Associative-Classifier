% =========================================================================

% This program is used to generate Figure 10 in the paper

% =========================================================================

clear all
close all
clc

n=30;
Phi=pi/n*[1:2*n-1];
N=2^20;M=1:0.75*N;
SIN=sqrt(M/N);
for i=1:length(Phi)
    P(:,i)=(2*cos(Phi(i))*SIN.^2+1-SIN.^2+2)./(4-2*SIN.^2*(1-cos(Phi(i))));
    Sin_Delta(:,i) = 2*SIN*sin(Phi(i)/2).*sqrt(1-SIN.^2*sin(Phi(i)/2)^2);
end
MAX=max(P); MIN=min(P);
SUM=sum(round(1./Sin_Delta)>sqrt(N));
[MAX' MIN' SUM']

figure(1)
hold on
plot([1:2*n-1],SUM)
plot([10 10],[-5 5],'k',[30 30],[-5 5],'k',[50 50],[-5 5],'k')
text(8,10,'\pi/3','FontSize',15)
text(29,10,'\pi','FontSize',15)
text(47,10,'5\pi/3','FontSize',15)
axis([1,2*n-1,-10,max(SUM)])
xlabel('\phi (\times\pi/30)')
ylabel('The number of 1/sin\delta > N^{1/2})')
grid on
set(gca,'FontSize',13);
box on

figure(2)
hold on
plot([1:2*n-1],MAX,'r',[1:2*n-1],MIN,'b')
plot([10 10],[0.75 MAX(10)],'k',[50 50],[0.75 MAX(50)],'k')
text(11,0.76,'\pi/3','FontSize',15)
text(29,0.76,'\pi','FontSize',15)
text(51,0.76,'5\pi/3','FontSize',15)
axis([1,2*n-1,0.74,0.94])
xlabel('\phi (\times\pi/30)')
ylabel('P_{max}')
grid on
legend('max(P_{max})','min(P_{max})','Location','North')
set(gca,'FontSize',13);
box on
