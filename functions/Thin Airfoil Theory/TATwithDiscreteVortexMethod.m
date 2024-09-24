function [z, Gammas, zv, k, Cl, Cm] = TATwithDiscreteVortexMethod(x, y, alpha)
    % Implements the Discrete Vortex Method to solve the thin airfoil
    % problem with a vortex circulation exactly on the meanline.
    % x, y are the discretized meanline coordinates
    % alpha is the angle of attack
    % z is the complex coordinates of menaline coordinates
    % Gammas the value of the circulations
    % zv the complex coordinates of vortex points
    % k the circulation distribution (assumed uniform over each panel)
    % Cl the lift coefficient
    % Cm the pitching moment with repsect to the Leading edge
    %
    % Based on work presented in "Discrete Vortex Method-Based Model for
    % Ground-Effect Studies", Partha Mondal and N. Balakrishnan (AIAA
    % Journal 2014)

    % Complex coordinates of panels
    z = x + 1i * y;
    % Rotate by alpha with respect to the trailing edge
    z = (z - 1) * exp(-1i * alpha) + 1; 
      
    % Normal direction of panels
    n = 1i * diff(z);
    
    % Vortex points (1/4 of each panel)
    zv = (3 * z(1:end-1) + z(2:end)) / 4;             
    
    % Collocation points (3/4 of each panel)
    zc = (z(1:end-1) + 3 * z(2:end)) / 4;
    
    % Build A * Gammas = b linear system
    b = real(n.');
    A = 1i ./ (2 * pi * abs(zc.' - zv).^2) .* conj(zc.' - zv);
  
    
    % Project velocity onto the normal directions to impose non-penetration
    % at collocation points
    A = real(A) .* real(n.') + imag(A) .* imag(n.');
    
    % Calculate Gammas
    Gammas = A \ b;
    
    % Approximate continous k distribution
    k = Gammas ./ abs(diff(z))';
    
    % Lift coefficient
    Cl = 2 * sum(Gammas);

    % Cm from the Leading Edge
    zLE = 1 - exp(-1i * alpha);                                 % Leading edge coordinates
    zm = zv - zLE;                                              % Vortex points position wrt Leading Edge
    dP  = k.' .* n;                                             % Pressure coefficient difference per panel
    Cm = 2 * sum(-real(zm).*imag(dP) + imag(zm).*real(dP));     % Integration over all panels of position x pressure force

end

