% Script written as a coding assignment in MCDB 108C
% Coding Assignment # 5
% Negative exponential distribution for wait time
% Rafael Solorzano (May 11, 2021): Beginner Track  
%% Main Code

clearvars;
% Throughout the script, replace the blank statments with what is described in the comments
% Constants
total_time_steps = 43200; % Total number of time steps over which the degradation is simulated, given in seconds
production_rate = 1 ; % (1 molecule/sec) rate constant of the production of a GFP-molecule, given in seconds 

% Variables
wait_time = -log(rand)/(production_rate); % Define the first random wait time between the production of individual molecules

% Initial conditions
total_time = 0; % Define and update the total time with the first wait time
prod_time_vector(1) = 0; % Define a vector for the wait time and set its inital value
prod_time_seq(1) = 0; % Define a vector for the total time and set its initial value
total_time = total_time + wait_time; 



% REPLACE the ALL CAP statment with your answer
i = 2; % It must start at 2 because an index of 1 corresponds to the initial condition before anything has happened at time 0. 


while total_time < total_time_steps % Repeat the experiment for the time set in the Constants sections 

    wait_time=-log(rand)/(production_rate); % Use the wait time and the initial conditions to run the experiment
    total_time = total_time + wait_time;
    prod_time_vector(i) = wait_time;
    prod_time_seq(i) = total_time; 
    i = i + 1;   
end

% Calculate the number of molecules produced in consecutive intervals of 1 min

bin_interval = 1; % Set the bin interval to 1 minute 
number_min = 720; % Define the number of intervals in the experimental time
prod_per_min = zeros(number_min,1); % Define an output vector to store the data
wait_time_in_min=(prod_time_seq/60); %new wait time in minutes 
ceil_interval_bin=ceil(wait_time_in_min);

for j = 1:number_min % Repeat the for loop for the calculated number of intervals
    prod_per_min(j)=sum(ceil_interval_bin==j,'all');
  
  
    % Use the the data gathered in your experiment together with the sum
    % and the ceil functions to scan through your total time vector and sum
    % up all the molecules produced within the interval time
    
end

% Model for distribution of number of molecules produced per minute
bin_seq= 1:100; % Define a number sequence from 1 to an appropriate value
model_prod_per_min = poisspdf(bin_seq,60); % Use the poissonpdf function with a LAMBDA equal to the number of molecules produced in 1 minute 

%% Plotting the Data

close all
subplot(2,1,1)
histogram(prod_time_vector,'Normalization','Probability')
xlabel('Time (s)')
ylabel('Probability Density')
title('Distribution of wait time')
subplot(2,1,2)
histogram(prod_per_min,'Normalization','Probability')
hold on
plot(bin_seq,model_prod_per_min)
xlabel('Number of Molecules produced per min')
ylabel('Probability Density')
title('Distribution GFP molecules produced per min bins')
hold off

% use subplot to plot both the distribution of wait time and the distribution of molecules produced per min 