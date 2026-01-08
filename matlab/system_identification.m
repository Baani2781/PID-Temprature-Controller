
time = SYSTEMIDFinal.Var1;   % Extract column Var1 (time)
temp = SYSTEMIDFinal.Var2;   % Extract column Var2 (temperature, for example)
temp_smooth = smoothdata(temp, 'movmean', 5);

% Experiment info (use power in watts)
u_step = 6;               % 6 W applied as step
T0 = mean(temp(1:3));   % initial temperature
L=2.0;

% Quick estimate for K and tau (starting guesses)
Tf  = mean(temp(end-4:end));   % final average of last few samples
dT  = Tf - T0;
K0  = dT / u_step;        % °C per Watt (initial guess for K)

% time constant and delay (simple estimate)
sig = std(temp_smooth(1:3));
iL  = find(temp_smooth > (T0 + 3*sig), 1, 'first');
L0  = ~isempty(iL) * (time(iL) - time(1));
T63 = T0 + 0.632*dT;
i63 = find(temp_smooth >= T63, 1, 'first');
tau0 = max(time(i63) - (time(1) + L0), 1e-3);
% Model (tweak K, tau)
K = K0; tau = tau0; 
s = tf('s');
G = K / (tau*s + 1);
if L > 0, G = G * exp(-L*s); end

% simulating step function of 6 W
t_sim = linspace(time(1), time(end), 1000);
[y_step, t_out] = step(G * u_step, t_sim);
y_step = y_step + T0;


% plotting 
plot(time, temp, 'r-', 'LineWidth', 2);
hold on;
plot(t_out, y_step, 'b-','LineWidth',2);
hold off;
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature vs Time');
legend('Experimental Data','Simulated Model');
grid on;
K
tau

%upon our findings K=1.5739 and tau=57.60


