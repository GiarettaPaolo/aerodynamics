function Cl = GroundEffect(x, y, h, alpha, n)
    % returns the Lift Coefficient of the airfoil in ground effect.
    % x, y are the airfoils coordinates
    % h the ride height (calculated from the trailing edge)
    % alpha the angle of attack
    % n the numebr of discretization point
    % For details on the iterative procedure please refer to "Numerical conformal mapping of 
    % multiply connected regions by Fornberg-like methods" DeLillo, 
    % Thomas K, Mark A Horn, and John A Pfaltzgraff (1999)
    
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
    
    zT12 = z12(1);
    zT22 = z22(1);
    
    
    %% Apply Fornberg-like method
    N = 256;                    % Number of discretization points (power of two for efficient fft)
    tol = 1e-9;                 % Convergence tolerance
    nmax = 100;                 % Maximum allwoable number of iterations

    % Apply the iterative procedure to find the conformal map
    [r13, r23, c13, c23, a1, a2, iter] = FornbergLikeMethod(z12, z22, r1, r2, c1, c2, N, tol, nmax);

    %% Solve for flow over 2 cylinders
    % Find the points corresponding to the trailing edged over the
    % cylinders to impsoe the two Kutta conditions.
    [ang1, ang2] = findTrailingEdge(zT12, zT22, a1, a2, r13, r23, c13, c23);
    
    % Points where to impose the Kutta condition
    zTE1 = c13 + r13 * exp(1i * ang1);
    zTE2 = c23 + r23 * exp(1i * ang2);
    
    N = 30;         % Number of reeated applications of Milne-Thomson circle theorem
    % Compute coefficients and circulations 
    [c, A] = ComputeCoefficients(c13, c23, r13, r23, N, 0);
    Gammas = CalculateGammas(zTE1, zTE2, c, A, 0);
    
    % Check Kutta condition is satisfied and Gammas are real numbers
    [~, chk] = CalculatePotential([zTE1; zTE2], c, A, 0, Gammas);
    assert(norm(chk) < 1e-9);
    assert(norm(imag(Gammas)) < 1e-9);
    Gammas = real(Gammas);
    
    %% Flow over top airfoil
    % Parametrize top circle
    theta = linspace(0, 2*pi, 500);
    zeta = c13 + 1.00 * r13 * exp(1i * theta);
    
    % Flow field over circles
    [~, df1] = CalculatePotential(zeta.', c, A, 0, Gammas);
    
    % Apply conformal map
    [zeta1, dz] = ConformalMap(zeta, a1, a2, r13, r23, c13, c23);
    df2 = df1.' ./ dz;
    
    % Invert second Karmann-Trefftz
    [zeta2, dz] = inverseTrefftz(zeta1, zT21, zc2, zT21, zc2, beta2);
    df3 = df2 ./ dz;
    
    % Invert first Karmann-Trefftz
    [zeta3, dz] = inverseTrefftz(zeta2, zT1, zc1, zT1, zc1, beta1);
    df4 = df3 ./ dz;
    
    % Correct asymptotic velocity because the Karman-Trefftz changes the 
    % asymptotic velocity by a factor of beta. 
    Uinf = beta1 * beta2;

    % Calculate pressure coefficient
    Cp = 1 - (abs(df4)/Uinf).^2;
    
    % Calculate lift coefficient by trapz integration
    Cl = imag(trapz(zeta3, 1i*Cp));

    % Print iteration details
    string = "\n Ground effect for h:"+ num2str(h, "%.2f") + " AoA: "+ num2str(alpha*180/pi, "%.2f") ...
        + " converged in iter: " + num2str(iter, "%.2f") + " Cl: " + num2str(Cl, "%.2f"); 
    fprintf(string);

end

