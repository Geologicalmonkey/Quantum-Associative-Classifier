% =========================================================================

% This program uses two methods (Histogram and Otsu) to binarize images and 
% calculate the Hamming distance between 10000 test images and 60000 stored images

% =========================================================================
function Digite_Test(mode)
close all;clc
load data_uint8

[Tr1,Tr2,Tr3] = size(train_x);
pattern = zeros(Tr3,Tr1*Tr2);
for i = 1:Tr3
    temp = reshape(train_x(:,:,i),1,Tr1*Tr2);
    if strcmp(mode, 'Histogram') | strcmp(mode, 'histogram')
        [Hist,Tr_Pixel(i)] = Histogram(temp);
    elseif strcmp(mode, 'Otsu') | strcmp(mode, 'otsu')
        Tr_Pixel(i) = Otsu(temp);
    end
    temp(temp<=Tr_Pixel(i)) = 0;
    temp(temp>=Tr_Pixel(i)) = 1;
    pattern(i,:)=temp;
    for j = 1:10
        if train_y(j,i) == 1
            pattern_label(i,1) = j-1;break;
        end
    end
end

[Te1,Te2,Te3] = size(test_x);
test = zeros(Te3,Te1*Te2);
for i = 1:Te3
    temp = reshape(test_x(:,:,i),1,Te1*Te2);
    if strcmp(mode, 'Histogram') | strcmp(mode, 'histogram')
        [Hist,Te_Pixel(i)] = Histogram(temp);
    elseif strcmp(mode, 'Otsu') | strcmp(mode, 'otsu')
        Te_Pixel(i) = Otsu(temp);
    end
    temp(temp<=Te_Pixel(i)) = 0;
    temp(temp>=Te_Pixel(i)) = 1;
    test(i,:) = temp;
    for j = 1:10
        if test_y(j,i) == 1
            test_label(i,1) = j-1;break;
        end
    end
end

for i = 1:Te3
    D(i,:) = Hamming_1(pattern,test(i,:));
    if mod(i,10) == 0
        disp(['Total: 10000, completed: ',num2str(i)]);
    end
end
if strcmp(mode, 'Histogram') | strcmp(mode, 'histogram')
    save Hist_Result D pattern_label test_label    
elseif strcmp(mode, 'Otsu') | strcmp(mode, 'otsu')
    save Otsu_Result D pattern_label test_label    
end

function d = Hamming_1(M,P)
for i = 1:size(M,1)
    d(i) = sum(M(i,:)~=P);
end
