function [Hist,Pixel] = Histogram(Digite)
Hist = zeros(1,256);
for i = 1:size(Digite,2)
    Hist(Digite(i)+1)=Hist(Digite(i)+1)+1;
end
[Value,Pixel] = min(Hist); Pixel = Pixel-1;
