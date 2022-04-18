clc, clear all;
%% Set symbolic variables
syms f real % input

syms x th real % outputs
syms dx dth real % first derivatives
syms ddx ddth real % second derivatives

syms M m g l real % systems constants

%% Define the system
% States of systme
q = [x; th];
dq = [dx; dth];
ddq = [ddx; ddth];

q_dq = [q; dq];
dq_ddq = [dq; ddq];

% Postion of mass M
x_M = [x, 0];
% Postion of mass m
x_m = [x + sin(th) * l, cos(th) * l];

%% Velocity of each element of the system
dx_Mdt = jacobian(x_M, q) * dq;
dx_mdt = jacobian(x_m, q) * dq;

%% Kynetic Energy of the system
% Sum of both kynectic energies
K = 1/2 * M * (dx_Mdt' * dx_Mdt) + 1/2 * m * (dx_mdt' * dx_mdt);

%% Potential Energy with respect th = 0
U = g * M * x_M(2) + g * m * x_m(2);

%% Lagangian
L = K - U;

% Lagrangian calculation, equation without imputs
eq = jacobian(jacobian(L, dq), q_dq) * dq_ddq - jacobian(L, q)';
eq = simplify(eq);

% Get matrix A
A = jacobian(eq, ddq);
% Get constants
B = simplify(eq - A * ddq);

%% Assemble system in matrix form with inputs
Eq_left = A * ddq;
Eq_right = [f; 0] - B;

Eq = Eq_left == Eq_right;
pretty(Eq)

%% Getting the solution by using the inverse matrix
sol_ddq = simplify(A \ Eq_right);
pretty(sol_ddq)

%% Equilibrium conditions
eq_q = [0; 0];
eq_dq = [0; 0];
eq_f = 0;

%% Linearization
linearized_eq = subs(jacobian(sol_ddq, q), [q_dq; f], [eq_q; eq_dq; eq_f]) * dq + ...
subs(jacobian(sol_ddq, f), [q_dq; f], [eq_q; eq_dq; eq_f]) * f;
