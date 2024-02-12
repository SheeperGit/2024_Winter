% Initialize cell arrays to store values
data = cell(0, 4);

for i = 0:100
    if i == 50
        continue;
    end
    
    xi = 0.01 * i * pi;
    c = approx(@cos, 0, xi, 4, 20);
    p_xi = polyval(c(end:-1:1), xi); % Reverse the order of coefficients
    cos_xi = cos(xi);
    
    rel_error = abs(p_xi - cos_xi) / abs(cos_xi);
    
    data{end+1, 1} = i;
    data{end, 2} = p_xi;
    data{end, 3} = cos_xi;
    data{end, 4} = rel_error;
end

T = cell2table(data, 'VariableNames', {'i', 'p(xi)', 'cos(xi)', 'Relative Error'});
disp(T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Displaying the Graph %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_values = linspace(0, pi, 1000);
c = approx(@cos, 0, pi, 4, 20);
p_values = polyval(c(end:-1:1), x_values); % Reverse the order of coefficients
cos_values = cos(x_values);

% Plot p(x) and cos(x) on the same graph %
figure;
plot(x_values, p_values, 'r-', 'LineWidth', 2); % p(x) will be in red
hold on; % Hold plot to add more curves
plot(x_values, cos_values, 'b--', 'LineWidth', 2); % cos(x) will be in blue dashes
hold off;
xlabel('x');
ylabel('f(x)');
title('Approximation of cos(x) vs. cos(x)');
legend('p(x)', 'cos(x)', 'Location', 'best');
grid on;