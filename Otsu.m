function Best_k = Otsu(Digite)
[Hist,Pixel] = Histogram(Digite);
Hist_1 = Hist/sum(Hist);
P_1 = cumsum(Hist_1);
M_E = cumsum([0:255].*Hist_1);
M_G = M_E(end);
Sigma_2B = (M_G*P_1-M_E).^2./(P_1.*(1-P_1));
Pos = zeros(2,length(Sigma_2B));
for i = 1:length(Sigma_2B)
    if Sigma_2B(i) == max(Sigma_2B)
        Pos(1,i) = 1;
        Pos(2,i) = i;
    end
end
Best_k = round(sum(Pos(2,:))/sum(Pos(1,:)));
Sigma_2G = sum(([0:255]-M_G).^2.*Hist_1);
Eta = Sigma_2B(Best_k)/Sigma_2G;
