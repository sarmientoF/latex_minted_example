clc, clear all, close all;
M = [0, 1, 2, 10];

x = -pi:0.1:pi;
figure()

plot(x, sin(x), '-x', 'LineWidth', 2);
hold on
grid on

for i = 1:length(M)

    m = M(i);
    plot(x, mySine(x, m), 'LineWidth', 2)
end

legend('sin', 'm=0', 'm=1', 'm=2', 'm=10')

title('Sine function expansion');

function fx = mySine(x, m)
    fx = 0;

    for k = 0:m
        fx = fx + (-1)^k * myFactorial2(2 * k +1) * x.^(2 * k + 1);
    end

end

function x = myFactorial(k)
    x = 1 / factorial(k);
end

function X = myFactorial2(k)
    X = 1;

    for i = 1:k
        X = X * i;
    end

    X = 1 / X;

end
