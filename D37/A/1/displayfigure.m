x_values = linspace(0, pi, 1000);
c = approx(@cos, 0, pi, 4, 20);
p_values = polyval(c(end:-1:1), x_values); % Reverse order of coefficients
cos_values = cos(x_values);

% Plot p(x) and cos(x) on the same graph %
figure;
plot(x_values, p_values, 'r-', 'LineWidth', 2); % Plot p(x) in red
hold on; % Hold the plot to add more curves
plot(x_values, cos_values, 'b--', 'LineWidth', 2); % Plot cos(x) in blue dashes
hold off; % Release the hold
xlabel('x');
ylabel('f(x)');
title('Approximation of cos(x) vs. cos(x)');
legend('p(x)', 'cos(x)', 'Location', 'best');
grid on;
