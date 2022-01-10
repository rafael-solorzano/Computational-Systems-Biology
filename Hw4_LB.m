% Rafael Solorzano: Beginner Track 
% Script written as a coding assignment in MCDB 108C
% Date: May 4, 2021 
% Author: Kirstin Rollins
    % Solution for beginner track 
    
% Description: This script demonstrates the principles of the jackpot
% effect via a modification of the Luria Debruck algorithm. It will
% model the effect of a drug that specifically targets cancer cells

clear all

% Constants: 
% REPLACE 'number' with the appropriate values
num_trials = 1000; % this is the # of organoids being tested 
gen_with_drug = 2; % this parameter was modified to be the most effective for drug application    
time_steps = 15; % # of generations 
p_drug = 0.95; % prob of drug killing a cancer cell  
healthy_size= 4091904; % minimum # of healthy cells for organoid to be viable (1/8 of cells if all were healthy over 15 generations) 

% Variables: 
% REPLACE blank variable with what is described in the comments
healthy_cells = zeros(num_trials,time_steps); % empty vector w/ cells count of each generation of each trail
cancer_cells = zeros(num_trials,time_steps); % empty vector w/ cells count of each generation of each trail
fraction_cancer_cells = zeros(1,num_trials); % empty vector w/ fraction of cancer cells in each trial
viability_vect = zeros(num_trials,1); % empty vector for whether a sys is viable in each gen



% For loop of each trial: 
for i = 1:num_trials
    
    healthy_cells(i,1) = 999; % Initial # of healthy cells for each trials @ 0th generation
    cancer_cells(i,1) = 1; % Initial # of cancer cells for each trials @ 0th generation
    
    % For loop of each generation: 
    for j=2:(time_steps+1) % start at index of 2 bc we designated 1 to be 'generation zero'

        killed_cancer_cells = 0; % this will be updated upon drug addition
        
        if j == gen_with_drug % Condition will run when we arrive at generation we choose to add drug
            
           killed_cancer_cells = poissrnd(p_drug*cancer_cells(i,j-1)); % poisson of # of events (cancer cells killed) occuring in a particular generation 
            
           cancer_cells(i,j) = cancer_cells(i,j-1) - killed_cancer_cells; % remaining cancer cells after treatment at particular generation
           healthy_cells(i,j) = healthy_cells(i,j-1); %healthy cells will not be replicating
           
        else 
            cancer_cells(i,j) = (cancer_cells(i,j-1))*4; % cancer cell growth w/o drug
            healthy_cells(i,j) = (healthy_cells(i,j-1))*2; % normal cell growth w/o drug
        end
        
        if cancer_cells(i,j-1) < killed_cancer_cells % this ensures that we do not have negative cancer cells
            cancer_cells(i,j) = 0; 
            healthy_cells(i,j) = healthy_cells(i,j-1);  
        end 
      
    end % the end of the 15 generation --> now determine if whole organoid is viable 
    
    fraction_cancer_cells(i) = (cancer_cells(i,end))/(healthy_cells(i,end) + (cancer_cells(i,end))); % proportion of cancer: total cells for each organoid
    
    if (fraction_cancer_cells(i) < 0.10) && (healthy_cells(i,end) > healthy_size) % condition for a viable trial: fracton of cancer < 10% of total AND we must have enough healthy cells above the threshold of 4091904 healthy cells 
        viability_vect(i) = 1;
    else
        viability_vect(i) = 0;
    end
    
end % end of that particular trial 
   
    
            
       
% DISPLAY the fraction of viable trials out of total trials
fraction_of_viable_trials = sum(viability_vect)/num_trials; % fraction of trials viable trials out of total trials
fprintf('The Fraction of Viable Trials Out of Total Trials is: %d\n', fraction_of_viable_trials); 

% PLOT histogram of fraction of cancer cells
h = histogram(fraction_cancer_cells, 'Normalization', 'Probability');

xlabel('Fraction of Cancer Cells')
ylabel('Probability')

        
       








