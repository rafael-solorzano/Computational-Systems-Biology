% Rafael Solorzano
%Script written as a coding assignment in MCDB 108C
% Date: February, 2021
% Author: Kirstin Rollins
% Description: This script demonstrates the principles of Monte Carlo
% simulations with a 1D random walk. In this case, it captures the active
% production and degradation of mRNA transcripts at any given point in time

% Constants:
p_prod = 0.8; % probability of producing a molecule
p_deg = (1-p_prod); % probability of degrading a molecule
num_steps = 500; % number of time points 

% Dependent variable: 
num_mol = zeros(num_steps, 1); % vector for number of molecules
hold on 
% Calculating the num_mol per step
for x = 1:3
    for i = 2:num_steps
        num_mol_idx = rand; 
        if (num_mol_idx > p_deg)
            num_mol(i) = num_mol(i-1) + 1; % produced molecule
         else 
            num_mol(i) = num_mol(i-1) - 1; % degraded molecule 
        end 
    end 
    time = 1:1:num_steps; % time increases in increments of 1
    plot(time, num_mol)
end 
hold off 

% The number of mRNA molecules can become negative if the random value of
% 'num_mol_idx' is less than 'p_deg'. Speaking in terms of probabilities,
% in the original script where p_prod = 0.5 & p_deg = 0.5 for n = 500, then
% the it is just as likely to equally have production or degradation, and
% if we randomly have alot of degradation usign 'rand', then we will see a
% decrease, and eventual negative [mRNA] molecules 


% biologically relevant units should be considered for the axis labels
xlabel('Time (hours)') 
ylabel('Number of mRNA molecules') 

