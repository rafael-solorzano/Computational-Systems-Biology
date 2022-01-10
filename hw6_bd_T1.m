% Rafael Solorzano; Beginner Track 

% Parameters of the tissue culture simulation 
number_step=600; % max # of time steps
mRNA_prod_rate=10; % molecules/(unit time) 
mRNA_deg_rate=1; % 1/(unit time) 
prod_rate = mRNA_prod_rate; % must set mRNA prod rate equal to this in order to match the function given
deg_rate = mRNA_deg_rate; % must be done to match our variable name to the one in the function 

protein_prod_rate=2; % molecules/(unit time) 
protein_deg_rate=0.02; % 1/(unit time) 
acquisition_threshold=1500; % # of protein molecules in a cell until it changes states: default --> acquired
number_cells=100; % # of cells used in experimet 


% Storage vectors & initial values 
mRNA_counter = zeros(number_step,number_cells); 
mRNA_counter (1,:) = 0; % intializie storage vector to be 0 mRNA molecules @ t=1

protein_counter = zeros(number_step,number_cells); 
protein_counter(1,:) = 0; % initialize protein counter to be 0 protein molecules at t=1

state_of_cell = zeros(number_cells,1); % storage vector that shows which of the 100 cells diffferentiated 

% # of mRNA molecules over 600 time steps (each 1 min), in 100 cells 

for j = 1:number_cells 
    mRNA_counter(:,j) = BirthDeathProcess_discrete_HW6(number_step,prod_rate,deg_rate); % over 600 time steps (:), we run the function for every cell 'j' 
end 

% # of protein molecules: via Euler's integration  
step_size = 1; % size of each step in 'number_step' --> 1 min size steps `
dx = step_size; % used in Euler's inegration to calc # of proteins prod/deg at each time step within each cell

for j = 1:number_cells % for each cell, we must run all 600 time steps 
    for i = 2:length(protein_counter) % number of steps 
        net_prod_rate = ((mRNA_counter(i,j) * protein_prod_rate) - (protein_counter(i-1,j)*protein_deg_rate))*dx; % the net protein production
        protein_counter(i,j) = protein_counter(i-1,j) + net_prod_rate; % # of protein molecules at a given step 
        if protein_counter(i,j) >= acquisition_threshold % if # of proteins passes threshold, then the cell becomes differentiated. i.e. cell state = 1
            state_of_cell(j) = 1; 
  
        end
    end
end 



close all % this will close any figure windows that are open 
figure % this figure will contain both mRNA & protein graphs
subplot(2,1,1) % mRNA graph
plot(mRNA_counter(:,1))
xlabel('Time a.u.')
ylabel('# of mRNA molecules')
title('Time course of number of mRNA molecules')
subplot(2,1,2) % protein graph
plot(protein_counter(:,1))
xlabel('Time a.u.')
ylabel('# of protein molecules')
title('Time course of number of Protein Molecules')

cell_state_matrix = reshape(state_of_cell,10,10); % reconfigure out 100x1 state of cell storage vector --> 10x10 matrix 

figure % this figure will only contain the heatmap 
subplot(2,1,1)
imagesc(cell_state_matrix) 
colormap(hot)
title('Fate of cells in tissue: black = default fate, white = developmental fate')
































