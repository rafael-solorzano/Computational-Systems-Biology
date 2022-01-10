% Script written as a coding assignment in MCDB 108C
% Coding Assignment # 2
% Principle of Euler’s integration method
% Rafael Solorzano, 4/20/21 & beginner track 

%% Main Code
% dx/dt = P(t) - k_x * x(t)
% P(t) provided externally
% x(0)=0

% Note: don't clear all variables otherwise the input vector cannot be
% accessed

% Time constants & variables
dt=1/60; % time step given in hour unit. 1/60 = 1 min
total_integration_time=(24*4); % number of days (multiple of 24 hours) during which the ODE system is integrated

time_series=linspace(0,total_integration_time,total_integration_time*1/dt); % this creates an evenly space time vector from 0-total integreation time, which a chosen number of steps in between that we designated as our total integration time that we converted into minutes  
number_steps=length(time_series); % determing the number of elements in the time series vector allows us to use this value as the number of iterations to run the for loop  

% Constants 
P_input=P_det; % P_det should be imported into the Matlab environment

% Parameter of the ODE
k_x=0.2; % Degradation rate given in hour
x_vect=zeros(1,number_steps); % Output vector to store the data 
x_vect(1)= 0; % This initalizes the solution by setting the intial condition at t=1. This is the same as determing the constant 'C' when taking the integral of a derivative. In this this case, we set our initial condition for the solution of the ODE.   


% Euler's integration subroutine
for i=1:(number_steps-1)
    dxdt=P_input(i)-k_x*x_vect(i); % solution of the ODE for one particular time step 
    x_vect(i+1)= (dxdt*dt) + x_vect(i); % YOU need to complete this step !!
end

%% Plotting the Data
% Subroutine plotting the input function and solution of ODE 

figure
plot(time_series,x_vect) % add your time vector and plot it against your output vector use the help function for more information
xlabel('Time (hours)') % add the right label for the x-axis
ylabel('BDCM concentration (M)') % add the right label for the y-axis
title('Production of BDCM over time') % add a descriptive title DO NOT use time vs. concentration!!!

