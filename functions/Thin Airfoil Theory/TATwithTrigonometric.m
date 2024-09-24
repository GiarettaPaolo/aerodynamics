function [k, Cl, Cm] = TATwithTrigonometric(x, dy, N, alpha)
    % returns the circulation distribution k, lift coefficient Cl, and
    % moment coefficient with respect to the Leading Edge Cm for the
    % classical thin airfoil theory.
    % x is the chordwise coordinates of the meanline points
    % dy is the respective meanline derivative 
    % N is the number of Fourier coefficients to calculate
    % alpha the angle of attack
    % theta

    % Calculate Coefficients
    A = TATCoefficients(x, dy, N);
    
    % Calculate theta
    theta = acos(1 - 2 * x);

    % Vortex distribution calculation
    k = 2 * ((alpha - A(1)) * (cos(theta) + 1) ./ sin(theta) + ...
    A(2:N) * sin((1:N-1).' .* theta));
    
    % Lift coefficient
    Cl = 2*pi*(alpha - A(1)) + pi * A(2);

    % Pitching moment coefficient with respect to Leading Edge
    Cm = -pi/2*(alpha - A(1) + A(2) - A(3)/2);
    
end

