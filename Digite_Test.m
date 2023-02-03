% =========================================================================

% The program classifies test samples according to Hamming distance

% Result of Histogram
% All marked states are correct: 9596
% Some (not all) of the marked state are correct: 59
% At least one of the marked states is correct: 9655
% All marked states are wrong: 345

% Result of Otsu
% All marked states are correct: 9546
% Some (not all) of the marked state are correct: 75
% At least one of the marked states is correct: 9621
% All marked states are wrong: 379

% =========================================================================
function Digite_Test(mode)
close all;clc

if strcmp(mode, 'Histogram') | strcmp(mode, 'histogram')
    load Hist_Result
elseif strcmp(mode, 'Otsu') | strcmp(mode, 'otsu')
    load Otsu_Result
end

Num_of_TE = size(test_label,1);
Mark = zeros(Num_of_TE,2); All_Result = -1*ones(Num_of_TE,17);

for i = 1:Num_of_TE
    [Value Index] = sort(D(i,:));
    Num_of_Equal = sum(D(i,:)==Value(1));
    
    Global_Min_d(i) = Value(1);
    Same_Clase_Min_Max_Mean(i,:) = [min(D(i,pattern_label == test_label(i))),max(D(i,pattern_label == test_label(i))),round(mean(D(i,pattern_label == test_label(i))))];

    Mark(i,1) = Num_of_Equal;
    for j = 1:1:Num_of_Equal    
        if pattern_label(Index(j),1) == test_label(i,1)
            Mark(i,2) = Mark(i,2)+1;
        end
    end
    
    All_Result(i,1:Num_of_Equal+5) = [Global_Min_d(i),Same_Clase_Min_Max_Mean(i,1),Mark(i,:),test_label(i,1),pattern_label(Index(1:Num_of_Equal),1)'];
    All_Result(i,end) = i;
    
    if mod(i,10) == 0
        disp(['Total: 10000, completed: ',num2str(i)]);
    end
end

if strcmp(mode, 'Histogram') | strcmp(mode, 'histogram')
    save Result_Hist Same_Clase_Min_Max_Mean All_Result
elseif strcmp(mode, 'Otsu') | strcmp(mode, 'otsu')
    save Result_Otsu Same_Clase_Min_Max_Mean All_Result
end

% All marked states are correct
All_Mark_Right = sum(All_Result(:,3)==All_Result(:,4))

Result_Part_Right = All_Result((All_Result(:,3)>All_Result(:,4))&(All_Result(:,4)>0),:);
% Some (not all) of the marked state are correct
Part_Mark_Right_1 = sum((All_Result(:,3)>All_Result(:,4))&(All_Result(:,4)>0))
Part_Mark_Right_2 = sum((All_Result(:,1)==All_Result(:,2))&(All_Result(:,3)>All_Result(:,4)))
% Part_Mark_Right_1 and Part_Mark_Right_2 are the same thing, just calculated differently

% At least one of the marked states is correct
Least_One_Right_1 = sum(All_Result(:,1)==All_Result(:,2))
Least_One_Right_2 = sum(All_Result(:,4)>0)
% Least_One_Right_1 and Least_One_Right_2 are the same thing, just calculated differently

Result_All_Wrong = All_Result((All_Result(:,3)>All_Result(:,4))&(All_Result(:,4)==0),:);
% All marked states are wrong
ALL_Mark_Wrong_1 = sum((All_Result(:,3)>All_Result(:,4))&(All_Result(:,4)==0))
ALL_Mark_Wrong_2 = sum(All_Result(:,1)<All_Result(:,2))
% ALL_Mark_Wrong_1 and ALL_Mark_Wrong_2 are the same thing, just calculated differently

save Result_Not_All_Right Result_Part_Right Result_All_Wrong
