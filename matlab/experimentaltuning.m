clc; clear; close all;

%System Parameters from Identification
K = 1.5739;      % Process gain
tau = 57.60;     % Time constant (seconds)
T0 = 24;         % Initial (room) temperature in °C
setpoint = 40;   % Desired temperature in °C

% Creating Transfer Function of the Plant G(s) = K / (tau*s + 1)
s = tf('s');
G = K / (tau*s + 1);

%PID Parameters
Kp = 2;          % Proportional gain
Ki = 0.1;        % Integral gain
Kd = 20;         % Derivative gain

% PID Controller: C(s) = Kp + Ki/s + Kd*s
C = Kp + Ki/s + Kd*s;

% closed Loop System (Unity Feedback) 
T_pid = feedback(C*G, 1);

%Simulating Step Response from Room Temp to Setpoint 
t = 0:0.5:200;                            % Simulation time (adjust as needed)
[y, t_out] = step((setpoint - T0) * T_pid, t);
y = y + T0;                               % Shift to start from room temperature

% Plot Results 
figure('Color', [0.1 0.1 0.1])
plot(t_out, y, 'c', 'LineWidth', 2); hold on;
yline(setpoint, 'r--', 'LineWidth', 1.5);
yline(T0, 'w--', 'LineWidth', 1.5);
grid on;

title('PID Temperature Control Response (Manual Tuning)', 'Color', 'w');
xlabel('Time (s)', 'Color', 'w');
ylabel('Temperature (°C)', 'Color', 'w');
legend({'Temperature Response','Setpoint','Initial Temp'}, 'TextColor','w', 'Location','southeast');
set(gca, 'Color', [0.15 0.15 0.15], 'XColor', 'w', 'YColor', 'w');
