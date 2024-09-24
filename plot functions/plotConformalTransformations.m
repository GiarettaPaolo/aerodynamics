function  plotConformalTransformations(x, y, h, alpha, n)
    % Plots the steps necessary to go from the two airfoils to the
    % perfectly circular cylinders.
    % x, y are the airfoil coordinates
    % h the desired ride heigth
    % alpha the angle of attack
    % n is the number of points used for discretization


   % Define fraction (optimal value by trial and error close to 0.993)
    % this parmaeter defines the position of the point inside the airfoil
    % and near the leading edge in the Karman-Trefftz transforms.
    frac = 0.993;

    % Complex coordinates
    z1 =  (x + 1i * y);
    z1 = 1 + exp(- 1i * alpha) * (z1 - 1);                  % Rotate
    z1 = z1 + 1i * h;                                       % Shift-up
    z2 = conj(z1);                                          % Reflect 
    
    % Parameters
    zT1 = z1(1);                                            % Trailing edge
    zL1 = zT1 - exp(-1i * alpha);                           % Leading edge
    zc1 = frac * zL1 + (1-frac) * zT1;                      % First point for Karman-Trefftz
    
    % Calculate Airfoil TE (divergence) angle
    lam = -angle(zT1 - z1(2)) + angle(zT1 -z1(end-1));      % Interior trailing edge angle
    beta1 = 2 - lam/pi;                                     % Fractional exponent in Karman-Trefftz
    
    % First Karman-Trefftz transform to remove first airfoil sharp trailing
    % edge
    z11 = KarmanTrefftz(z1, zT1, zc1, zT1, zc1, beta1);
    z21 = KarmanTrefftz(z2, zT1, zc1, zT1, zc1, beta1);
    
    zL21 = z21(n);
    zT21 = z21(1);
    
    beta2 = beta1;
    
    % Second Karman-Trefftz transforms to remove second airfoil sharp trailing edge
    zc2 = frac * zL21 + (1 - frac) * zT21;
    z12 = KarmanTrefftz(z11, zT21, zc2, zT21, zc2, beta2);
    z22 = KarmanTrefftz(z21, zT21, zc2, zT21, zc2, beta2);
    
    
    % Initialize radius and circle centers for multi-cylinder conformal map
    [r1, c1] = BestCircleFit(z12);
    [r2, c2] = BestCircleFit(z22);
    
    
    % Make sure two curves are parametrized anticlockwise
    z12 = AntiClockwiseParam(z12, c1);
    z22 = AntiClockwiseParam(z22, c2); 
    
    %% Apply Fornberg-like method
    N = 256;                    % Number of discretization points (power of two for efficient fft)
    tol = 1e-9;                 % Convergence tolerance
    nmax = 100;                 % Maximum allwoable number of iterations

    % Apply the iterative procedure to find the conformal map
    [r13, r23, c13, c23, ~, ~, ~] = FornbergLikeMethod(z12, z22, r1, r2, c1, c2, N, tol, nmax);
    
    
    %% Plots
    % Set up graphic tools
    set(groot,'defaultAxesTickLabelInterpreter','latex');   
    set(groot,'defaulttextinterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultTextFontSize',16);
    set(groot,'defaultAxesFontSize',16);
    figure('Name', 'Conformal transformations', 'NumberTitle', 'off');
    fig = gcf;
    fig.Color = 'w';
    fig.Position = [10 10 800 800];
    color = "#B80000";

    subplot(2, 2, 1)
    
    hold on
    h1 = plot(real(z1), imag(z1));
    h1.LineStyle = '-';
    h1.LineWidth = 2;
    h1.Color = color;

    h2 = plot(real(z2), imag(z2));
    h2.LineStyle = '--';
    h2.LineWidth = 2;
    h2.Color = color;

    h3 = yline(0);
    h3.LineStyle = '--';
    h3.LineWidth = 1.5;
    h3.Color = 'k';
    
    ax = gca;
    axis equal
    box on  
    xlabel(ax, {"x/c", "(a)"}, 'FontSize', 16);
    ylabel(ax, "y/c", 'FontSize', 16);
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 16;
    ax.XRuler.FontSize = 16;
    ax.XLimitMethod = 'padded';
    ax.YLimitMethod = 'padded';
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'off';
    ax.YGrid = 'off';
    ax.XMinorGrid = 'off';
    ax.YMinorGrid = 'off';

    subplot(2, 2, 2)
    hold on
    h1 = plot(real(z11), imag(z11));
    h1.LineStyle = '-';
    h1.LineWidth = 2;
    h1.Color = color;

    h2 = plot(real(z21), imag(z21));
    h2.LineStyle = '--';
    h2.LineWidth = 2;
    h2.Color = color;
    
    ax = gca;
    axis equal
    box on  
    xlabel(ax, {"x/c", "(b)"}, 'FontSize', 16);
    ylabel(ax, "y/c", 'FontSize', 16);
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 16;
    ax.XRuler.FontSize = 16;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XLimitMethod = 'padded';
    ax.YLimitMethod = 'padded';
    ax.XGrid = 'off';
    ax.YGrid = 'off';
    ax.XMinorGrid = 'off';
    ax.YMinorGrid = 'off';
  

    subplot(2, 2, 3)
    hold on
    h1 = plot(real(z12), imag(z12));
    h1.LineStyle = '-';
    h1.LineWidth = 2;
    h1.Color = color;

    h2 = plot(real(z22), imag(z22));
    h2.LineStyle = '--';
    h2.LineWidth = 2;
    h2.Color = color;
    
    ax = gca;
    axis equal
    box on  
    xlabel(ax, {"x/c", "(c)"}, 'FontSize', 16);
    ylabel(ax, "y/c", 'FontSize', 16);
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 16;
    ax.XRuler.FontSize = 16;
    ax.XGrid = 'off';
    ax.YGrid = 'off';
    ax.XMinorGrid = 'off';
    ax.YMinorGrid = 'off';
    ax.XLimitMethod = 'padded';
    ax.YLimitMethod = 'padded';
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
 
    
    subplot(2, 2, 4)
    hold on
    theta = linspace(0, 2*pi, 1000);
    Z1 = c13 + r13 * exp(1i * theta);
    Z2 = c23 + r23 * exp(1i * theta);

    h1 = plot(real(Z1), imag(Z1));
    h1.LineStyle = '-';
    h1.LineWidth = 2;
    h1.Color = color;

    h2 = plot(real(Z2), imag(Z2));
    h2.LineStyle = '--';
    h2.LineWidth = 2;
    h2.Color = color;
    
    ax = gca;
    axis equal
    box on  
    xlabel(ax, {"x/c", "(d)"}, 'FontSize', 16);
    ylabel(ax, "y/c", 'FontSize', 16);
    ax.XRuler.Exponent = 0;
    ax.YRuler.FontSize = 16;
    ax.XRuler.FontSize = 16;
    ax.XLimitMethod = 'padded';
    ax.YLimitMethod = 'padded';
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.XGrid = 'off';
    ax.YGrid = 'off';
    ax.XMinorGrid = 'off';
    ax.YMinorGrid = 'off';


end

