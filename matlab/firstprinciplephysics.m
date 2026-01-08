% Define physical constants
C = 45;                  % Heat capacity of the system (Joules/°C)
h = 0.5;                 % Heat loss coefficient (Watt/°C)
T_ambient = 28;          % Ambient temperature (°C)
% Time settings
t_final = 2000;           % Final time (in seconds)
dt = 0.1;                % Time step (in seconds)
t = 0:dt:t_final;        % Time vector
% Create input power vector: OFF (0W) until t = 5s, then ON (6W)
P_in = zeros(size(t));
P_in(t >= 0) = 6;
% Initialize temperature array
T = zeros(size(t));      % Same size as time vector
T(1) = T_ambient;        % Initial temperature is ambient
% Euler integration loop
for i = 1:length(t)-1
    dTdt = ( -h * (T(i) - T_ambient) + P_in(i) ) / C;   % Rate of change of temp
    T(i+1) = T(i) + dTdt * dt;                      % Update temp for next step
end
% Plotting the result
plot(t, T, 'LineWidth', 2)
xlabel('Time (s)')
ylabel('Temperature (°C)')
title('Temperature vs Time - First Principles Simulation')
grid on
