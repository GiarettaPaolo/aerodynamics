%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main script for the ME-445 Aerodynamics project (EPFL)
%
% Group members:
% Paolo Giaretta - paolo.giaretta@epfl.ch
% Simon de Bazelaire 
% Marion Clergeot    
%
% Professor:
% Karen Mulleners
%
%
% Selected Paper:
% "Airfoil Aerodynamics in Ground Effect for Wide Range of Angles of Attack"
% Qiulin Qu, Wei Wang, and Peiqing Liu (AIAA Journal 2014)
%
% Theories selected: Thin Airfoil Thoery, Potential Flow theory
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

% Set paths to folders
addpath(genpath("NACA functions"));
addpath(genpath("functions"));
addpath(genpath("plot functions"));
addpath(genpath("data"));

% Load data.mat file that contains graphs and curves extracted from the
% selected paper using the website www.graphreader.com/v2 and
% post-processed with script graph_data.m
load("data.mat");

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% THIN AIRFOIL THEORY %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Note: In this analysis we are exclusively interested in adimensional
% coefficients. This coefficients obtained are independent on the Reynolds
% number for this theory. Thus, we can choose an appropriate scaling where
% U_inf = 1, c = 1, rho = 1 and obtain the adimensional coefficients.


% Extract NACA airfoil coordinates
n = 2000;                               % Number of points per surface        
m = 0.04;                               % Maximum camber
p = 0.4;                                % Position of maximum camber
t = 0.12;                               % Maximum thickness

% Transform into theta coordinates
theta = linspace(0, pi, n);
x = (1- cos(theta))/2;

% Extract NACA meanline
[y, dy] = NACA_meanline(x, m, p);

% Calculate circulation distribution with Dicrete Vortex Method for angles
% of attack 4, 8, 16, 18 deg
[~, ~, ~, k4, ~, ~]   = TATwithDiscreteVortexMethod(x, y, 4 / 180 * pi);
[~, ~, ~, k8, ~, ~]   = TATwithDiscreteVortexMethod(x, y, 8 / 180 * pi);
[~, ~, ~, k16, ~, ~]  = TATwithDiscreteVortexMethod(x, y, 16 / 180 * pi);
[~, ~, ~, k18, ~, ~]  = TATwithDiscreteVortexMethod(x, y, 18 / 180 * pi);

% Calculate differential pressure coefficient from circulation distribution
Cp4_DVM = k4 * 2;
Cp8_DVM = k8 * 2;
Cp16_DVM = k16 * 2;
Cp18_DVM = k18 * 2;

% Calculate circulation distribution with classical trigonometric thin
% airfoil theory for angles of attack 4, 8, 16, 18 deg
[k4, ~, ~] = TATwithTrigonometric(x, dy, 50, 4 / 180 * pi);
[k8, ~, ~] = TATwithTrigonometric(x, dy, 50, 8 / 180 * pi);
[k16, ~, ~] = TATwithTrigonometric(x, dy, 50, 16 / 180 * pi);
[k18, ~, ~] = TATwithTrigonometric(x, dy, 50, 18 / 180 * pi);

% Calculate differential pressure coefficient from circulation distribution
Cp4_TAT = k4 * 2;
Cp8_TAT = k8 * 2;
Cp16_TAT = k16 * 2;
Cp18_TAT = k18 * 2;



%% Plots for thin airfoil theory (in the report)
% Chordwise points for plotting both thin airfoil theories
x_TAT = x;                          
x_DVM = x(2:end);

% Comparison between the two theories and the reference differential
% pressure coefficients
plotThinAirfoilComparison(x_TAT, x_DVM, Cp4_TAT, Cp8_TAT, Cp16_TAT, Cp18_TAT, ...
    Cp4_DVM, Cp8_DVM, Cp16_DVM, Cp18_DVM, data)

%% Extra plots (not in the report)
alpha = 4 * pi / 180;                               % angle of attack (rad)

% Calculate full vorticity distribution with Discrete Vortex Method
[z, Gammas, zv, k1, CL, Cm] = TATwithDiscreteVortexMethod(x, y, alpha);

% plot flow field (streamlines + Cp distribution) 
plotTAT(z, Gammas, zv);


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% POTENTIAL FLOW THEORY %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Note: In this analysis we are exclusively interested in adimensional
% coefficients. This coefficients obtained are independent on the Reynolds
% number for this theory. Thus, we can choose an appropriate scaling where
% U_inf = 1, c = 1, rho = 1 and obtain the adimensional coefficients.



% Number of airfoil coordinates (small for roper convergence)
n = 51;             

% Extract NACA coordinates of upper and lower surfaces
[xu, yu, xl, yl] = NACA_airfoil(n, m, p, t);

x = [xu(1:end-1) flip(xl)];
y = [yu(1:end-1) flip(yl)];

% Reparametrize coordinates on arc-length
s = cumsum([0 sqrt(diff(x).^2+diff(y).^2)]);        % Calculate arc-lengths
L = s(end);                                         % Total length
Le = s(n);                                          % Length of upper surface
sval = [linspace(0, Le, n) linspace(Le, L, n)];
sval(n) = [];

x = interp1(s, x, sval, "spline");                  % Spline interpolation of x-coordinate
y = interp1(s, y, sval, "spline");                  % Spline interpolation of y-coordinate


%% Plots for Potential Flow (in the report)
%% 1. Calculation of Lift coefficient curves for different ride heights
h_vect = [0.4 0.8 1 10];                           % Ride heights of interest (h=10 for inf)
alpha_vect = pi / 180 * (-4:2:10);                    % Range of angle of attacks
Cl = zeros(length(h_vect), length(alpha_vect));     % Pre-allocate Cl matrix for plotting

% Loop over ride height, and alphas combinations
for i = 1:length(h_vect)
    for j=1:length(alpha_vect)
        
        % Calculate lift coefficient 
        Cl(i, j) = GroundEffect(x, y, h_vect(i), alpha_vect(j), n);

    end
end

% Plot reconstructed image
plotClCurves(alpha_vect, h_vect, Cl);

% Plot reference experimental data
plotExperimentalCl(data);

%% 2. Example of sequence of conformal transformations from two airfoils to 2 cylinders
h = 0.5;                                             % Ride-height
alpha = 4 * pi / 180;                                % Angle of attack (rad)

% Plot sequence of conformal transformations
plotConformalTransformations(x, y, h, alpha, n);

%% 3. Example of flow field over two cylinders with circulation
ang1 = -4 * pi / 180;                                % Angle where Kutta condition applies for the first cylinder (rad)
ang2 = -ang1;                                        % Angle where Kutta condition applies for the second cylinder (rad)
r1 = 1;                                              % Radius of first cylinder
r2 = 1;                                              % Radius of second cylinder
c1 = 2*1i;                                           % Complex center of first cylinder
c2 = -2*1i;                                          % Complex center of second cylinder
N = 50;                                              % Number of applications per cylinder of Milne-Thomson circle theorem

% Plot flow over cylinders (streamlines + Cp distribution)
plotFlowOverCylinders(r1, r2, c1, c2, N, ang1, ang2);

%% 4. Comparison of potential flow theory lift coefficient curves with refernce ones
% Plot for selected ride heights and angles of attack
plotPotentialFlowComparison(Cl, alpha_vect, data);



