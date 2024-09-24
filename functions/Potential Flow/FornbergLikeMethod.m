function [r1, r2, c1, c2, a1, a2, iter] = FornbergLikeMethod(z1, z2, r1, r2, c1, c2, N, tol, nmax)
    % Returns the two cylinders radii r1, r2, center coordinates c1, c2 and
    % series expansion coefficient defininf the conformal map between the
    % two cylinders and quasi-circular boundaries. 
    % iter is the numebr of iterations required for convergence
    % For details on the iterative procedure please refer to "Numerical conformal mapping of 
    % multiply connected regions by Fornberg-like methods" DeLillo, 
    % Thomas K, Mark A Horn, and John A Pfaltzgraff (1999)
    % N is the number of points (and terms) in the infite series expansion
    % tol the convergence tolerance
    % nmax the maximum allowable number of iterations



    % Build matrices needed only once for efficiency
    M = N / 2;             % N must be an even number
    Z = zeros(M, M);       % Null matrix
    I = eye(M, M);         % Identity matrix
    P12 = Z;               % Pre-allocate P12 matrix
    P21 = Z;               % Pre-allocate P21 matrix

    % Interpolate points with periodic cubic spline parametized by
    % arc-length
    s1 = cscvn([real(z1); imag(z1)]);
    s2 = cscvn([real(z2); imag(z2)]);
    L1 = s1.breaks(end);
    L2 = s2.breaks(end);
    
    % Initialize boundary correspondence
    theta = (0:N-1)' * 2 * pi / N;      % Uniformly-distributed points over the cylinders
    S1 = (0:N-1)' * L1 / N;
    S2 = (0:N-1)' * L2 / N;
    
    % Start of the iterative procedure
    for iter=1:nmax       
        
        % Calculate points and derivatives at the points defined by the
        % boundary correspondence
        gamma1 = fnval(s1, S1);
        gamma2 = fnval(s2, S2);
        dgamma1 = fnval(fnder(s1, 1), S1);
        dgamma2 = fnval(fnder(s2, 1), S2);

        % Bring back into complex numbers
        gamma1 = gamma1(1, :) + 1i * gamma1(2, :);
        gamma2 = gamma2(1, :) + 1i * gamma2(2, :);
        dgamma1 = dgamma1(1, :) + 1i * dgamma1(2, :);
        dgamma2 = dgamma2(1, :) + 1i * dgamma2(2, :);

        % 2. Form Matrices and vectors
        E1 = diag(dgamma1);
        E2 = diag(dgamma2);
        dS1 = N / 2 / pi * [diff(S1); L1-S1(end)];
        dS2 = N / 2 / pi * [diff(S2); L2-S2(end)];
        zeta1 = 1i / r1 * E1 * dS1;
        zeta2 = 1i / r2 * E2 * dS2;
        
        r = [c1; r1; zeros(M-2, 1); c2; r2; zeros(M-2, 1)];
        
        % Build P matrices row by row to avoid binomial coefficients
        % overflowing
        P21(1, :) = -(r1/(c2 -c1)).^(M:-1:1);
        P12(1, :) = -(r2/(c1 -c2)).^(M:-1:1);

        for i=2:M

            P21(i, :) = P21(i-1, :) .* (r2/(c1 -c2)) .* (M+i-2:-1:i-1) ./ (i-1);
            P12(i, :) = P12(i-1, :) .* (r1/(c2 -c1)) .* (M+i-2:-1:i-1) ./ (i-1);

        end
        
        % Define P matrices
        P1 = [I Z; Z P21];
        P2 = [Z P12; I Z];
        P = [P1 P2];
        
        % Define RHS vector
        g = -P*[fft(gamma1.'); fft(gamma2.')] + r * N;
        
        % Define W matrix
        z = exp(-1i * theta);
        w1 = P1 * fft(zeta1);
        w2 = P2 * fft(zeta2);
        wz1 = P1 * fft(z .* zeta1);
        wz2 = P2 * fft(z .* zeta2);
        W = [w1 w2 wz1 1i*wz1 wz2 1i*wz2];

        % Calculate LHS matrix
        D = [P W] * blkdiag(fft(E1), fft(E2), eye(6));

        % Take the normal (square matrix) equations
        A = 2 / N * real(D' * D);
        b = 2 / N * real(D' * g);
        
        % Solve by taking few iterations with conjugate gradient method
        [U, ~] = pcg(A, b, 1e-9, M);
        
        % Update boundary correspondence, centers and radii
        S1 = S1 + U(1:N);
        S2 = S2 + U(N+1:2*N);
        r1 = r1 + U(2*N+1);
        r2 = r2 + U(2*N+2);
        c1 = c1 + U(2*N+3) + 1i * U(2*N+4);
        c2 = c2 + U(2*N+5) + 1i * U(2*N+6);      
        
        % Check for convergence
        if norm(U) < tol && norm(g) < tol
            break
        end


    end
        
    % Build output coefficients
    % Use boundary correspondence to calculate boundary points and
    gamma1 = fnval(s1, S1);
    gamma2 = fnval(s2, S2);
    
    % Bring back into complex numbers
    gamma1 = gamma1(1, :) + 1i * gamma1(2, :);
    gamma2 = gamma2(1, :) + 1i * gamma2(2, :);
    
    % Coefficients
    a1 = 1/N * fft(gamma1.');
    a2 = 1/N * fft(gamma2.');

    % Extract only negative frequencies
    a1 = flip(a1(M+1:end));
    a2 = flip(a2(M+1:end));

end







