%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I extracted data from figure of the PV cell from simulink by this code:

h = openfig('sdfghjk.fig');
h = findobj(gca,'Type','line');
x = get(h,'Xdata');
y = get(h,'Ydata');

figure;
plot(x{1},y{1});

p{1} = x{1} .* y{1};
figure;
plot(x{1},p{1});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I want to x (voltage) and y (current) values have the same size in all
% cells and y values being extrapolated to zero.
% Define target length (maximum length found in y)
target_length = 572;

% Initialize new cell arrays for extrapolated values
ydata_extrapolated = cell(size(y));
xdata_extrapolated = cell(size(x));

% Loop through each cell in x and y
for i = 1:length(y)
    % Extract the current cell's x and y values
    x_values = x{i}; 
    y_values = y{i};
    
    % Get the current length
    n = length(y_values);

    % Define the original x-axis and target x-axis
    x_original = linspace(1, n, n);
    x_target = linspace(1, target_length, target_length); % Target axis

    % Extrapolate x values (keeping trend)
    if n < target_length
        x_values_extended = interp1([x_original, target_length], [x_values, x_values(end)], x_target, 'linear', 'extrap');
    else
        x_values_extended = x_values;
    end
    
    % Extrapolate y values to zero
    if n < target_length
        y_values_extended = interp1([x_original, target_length], [y_values, 0], x_target, 'linear', 'extrap');
    else
        y_values_extended = y_values;
    end

    % Store the extrapolated values
    xdata_extrapolated{i} = x_values_extended;
    ydata_extrapolated{i} = y_values_extended;
end

% Optional: Verify the results
disp('Extrapolation complete. All x and y cells now have the same length of 571.');


% to test
figure;
plot(xdata_extrapolated{1}, ydata_extrapolated{1});

% now we have I and V of PV cell
V = xdata_extrapolated;
I = ydata_extrapolated;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:51

    I_new{i} = [];
    V_Step = 0.00001;
    V_min = 0;
    V_max = 0.7;
    %voltageMin = min(combined_voltage);
    %voltageMax = max(combined_voltage);
    
    for V_new = V_min : V_Step : V_max
        [~, minIndex] = min(abs(V_new - V{i}));
        I_new{i} = [I_new{i}, I{i}(minIndex)];
    end
    V_new = V_min : V_Step : V_max;

end

%plot(V_new, combined_current_new)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert 51x1 cell into a 51x572 double matrix
I_matrix = cell2mat(I); 

I_matrix = cell2mat(I_new.'); 




figure;
plot(x{50},y{50});
figure;
plot(x{50},x{50}.*y{50});

plot(x{20},x{20}.*y{20});
plot(x{1},x{1}.*y{1});

figure;
plot(I_matrix(1, :));
figure;
 plot(y{1});
 plot(x{1});




p1 = y{1}.*x{1};
p2 = y{2}.*x{2};
p3 = y{3}.*x{3};
p4 = y{4}.*x{4};
p5 = y{5}.*x{5};

 figure;

 plot(x{1},p1);
 plot(x{2},p2);
 plot(x{3},p3);
 plot(x{4},p4);
 plot(x{5},p5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%V_new  = [0:0.001154:0.6596];
p26 = I{26}.*V_new;

figure;
plot(V_new,p26);

p0 = I{1}.*V_new;
p50 = I{51}.*V_new;

plot(V_new,p0);
plot(V_new,p50);




p26 = I{26}.*V{26};
p26 = I_new{26}.*V_new;

figure;
plot(V_new,p26);

p0 = I{1}.*V{1};
p50 = I{51}.*V{51};

plot(V{1},p0);
plot(V{51},p50);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 25_02_17: Temp_75 data extraction:

% I extracted data from figure of the PV cell from simulink by this code:

h1 = openfig('Temp_75.fig');
h1 = findobj(gca,'Type','line');
x1 = get(h1,'Xdata');
y1 = get(h1,'Ydata');



V_75 = x1;
I_75 = y1;

figure;
plot(V_75,I_75);

p1 = V_75 .* I_75;
figure;
plot(V_75,p1);


% Define original data
x_original = linspace(0, 1, length(I_75)); % Normalize the original x-axis
x_target = linspace(0, 1, length(I_75) + 50); % New x-axis with extrapolated points

% Interpolate I_75 and extrapolate to zero
I_75_extrapolated = interp1(x_original, I_75, x_target, 'pchip', 'extrap');

% Ensure last value is zero
I_75_extrapolated(end) = 0;

% Resize V_75 to match new I_75 size
V_75_resized = interp1(x_original, V_75, x_target, 'pchip', 'extrap');

% Plot results
figure;
subplot(2,1,1);
plot(x_original, I_75, 'r-', 'LineWidth', 1.5); hold on;
plot(x_target, I_75_extrapolated, 'b--', 'LineWidth', 1.5);
xlabel('Normalized Index');
ylabel('I_75 Value');
title('Original vs. Extrapolated I\_75');
legend('Original', 'Extrapolated');
grid on;

subplot(2,1,2);
plot(x_original, V_75, 'r-', 'LineWidth', 1.5); hold on;
plot(x_target, V_75_resized, 'b--', 'LineWidth', 1.5);
xlabel('Normalized Index');
ylabel('V_75 Value');
title('Original vs. Resized V\_75');
legend('Original', 'Resized');
grid on;

disp('Extrapolation of I_75 and resizing of V_75 complete!');


combined_current_new = [];
voltageStep = 0.0001;
voltageMin = min(combined_voltage);
voltageMax = max(combined_voltage);
for combined_voltage_new = voltageMin : voltageStep : voltageMax
    [~, minIndex] = min(abs(combined_voltage_new - combined_voltage));
    combined_current_new = [combined_current_new, combined_current(minIndex)];
end
combined_voltage_new = voltageMin : voltageStep : voltageMax;
plot(combined_voltage_new, combined_current_new)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Temperature profile from 20 to 50 in 30 minutes:

% Define time vector from 0 to 30 seconds
% t = 0:0.1:30; % Time steps of 0.1s for smooth transition
  t = 0:0.001:0.3;

  t1 = 0:0.001:0.2;

% Generate linear ramp from 20°C to 50°C
T1 = linspace(26, 25.2, length(t1)); % sharp rise in temp.
T = linspace(31, 30.7, length(t)); % slow rise in temp.


P_Desired = linspace(262.3, 261.7, length(t));
P_Desired1 = linspace(251.3, 249.6, length(t1));


% Plot the temperature ramp
figure;
plot(t, T, 'b-', 'LineWidth', 2);
plot(t1, T1, 'b-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature Ramp: 20°C to 50°C over 30s');
grid on;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PV cell P-V points VS temp extraction:

h_P = openfig('PV_cell_power_voltage_chractristics_2025_02_17.fig');
h_P = findobj(gca,'Type','line');
x_P = get(h_P,'Xdata');
y_P = get(h_P,'Ydata');

