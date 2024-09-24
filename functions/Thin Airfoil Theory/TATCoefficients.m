function A = TATCoefficients(x, dy, N)
        % Returns the first N Fourier coefficients (A(0) -> A(N-1)) of the meanline
        % derivative for the trigonometric cosine polynomial.
        % x is the row vector of chordwise positions
        % dy is the row vector of corresponding meanline derivatives
        
        
        % Transform coordinates into angular ones
        theta = acos(1 - 2 * x);
        
        % Calculate matrix for integration of fourier coefficients
        % (vectorized for efficiency)
        mat = cos(theta.' .* (0:N-1)) .* dy.';
        
        % Calculate intergals with trapz method
        A = 2/pi*trapz(theta, mat, 1);

        % Correct pre-factor of first coefficient
        A(1) = A(1) / 2;


end