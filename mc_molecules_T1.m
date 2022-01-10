% Rafael Solorzano 
% Beginner track solution
num_trials = 1e4; % the number of trials 
diff_threshold = 300;  % # of mcdb molecules until cell can differentiate
threshold_steps_counter = zeros(num_trials,1);
p_prod = (2/3); % probability of producing 1 molecule of mcdb 
p_deg = (1-(2/3)); % probability of degrading 1 molecule of mcdb 
 
for i = 1:num_trials % for 10,000 trials we are finding how steps it takes to reach 300 molecules of mcdb 
    mol_mcdb = 1; % starting with an initial condition of 1 molecule of mcdb in the 'pool' for each trial 
    steps_to_threshold = 1; % starting with 1 time step at the beginning of each trial 
    while mol_mcdb < diff_threshold 
      prob_mol_mcdb = rand; 
        if (prob_mol_mcdb <= p_prod)  % if our prob of production is greater than the prob of degradation...
            mol_mcdb = mol_mcdb + 1;   % ...then we add 1 molecule of mcdb to the 'pool' 
        else 
            mol_mcdb = mol_mcdb - 1;  % if our prob is not greater than the prob for degradation, we degrade 1 molecule of mcdb from the pool 
        end 
        steps_to_threshold = steps_to_threshold + 1; % count how many steps it takes for while loop to meet condition
    end
    threshold_steps_counter(i,1) = steps_to_threshold; % once condition is met, we store the number of time steps in our counter vector 
    i = threshold_steps_counter(:,1); 
    
end % this ends 10,000 trials 

histogram(threshold_steps_counter(:,1)) 
axis([0,1500,0,600]) 

xlabel('Number of Minutes it took to get to 300 molecules of mcdb')
ylabel('Number of Occurences')
title('Distribution of the Number of Minutes it Took for the Cell to Start the Differentiation Process')
 