%% Loop over the desired values of N
for N = [10, 100, 1000]
    % Call the function to generate the data
    [mean, variance, ~] = myFun(N);
    % Plot and print the results
    fprintf('For %d => mean: %f, variance: %f\n', N, mean, variance);
end

%% Create a funtion that returns the mean and variance of the random numbers
function [mean, variance, X] = myFun(N)
    X = rand(N, 1) * 2; % Generate random number from 0 to 2
    index = 1:N; % Create an index list

    %% Plot
    figure(N);
    plot(index, X, 'LineWidth', 3)
    grid on

    %% Mean
    mean = sum(X) / length(X);
    variance = sum(X.^2) / length(X) - mean^2;
end
