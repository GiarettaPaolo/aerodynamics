function [zeta] = KarmanTrefftz(z, z1, z2, zeta1, zeta2, beta)
        % Calculates the KarmanTrefftz conformal map at query points z (row
        % vector). beta is the reciprocal of the exponent, z1 the point at
        % which the map is not conformal (Trailing edge) mapped to zeta1
        % and z2 the point near the leading edge mapped to zeta2. 


        % Correct for discontinuity in phase (fractional exponent might
        % introduce discontinuities otherwise)
        x = ((z - z1) ./ (z - z2));                 % Calculate exponent argument
        ang = angle(x);                             % Calculate angle
        mod = abs(x);                               % Calculate absolute value
        ang = unwrap(ang);                          % Remove phase discontinuity

        x = mod.^(1/beta) .* exp(1i .* ang / beta); % Calculate fractional exponent
        zeta = (zeta1 - zeta2 .* x)./(1 - x);       % Calculate output

end

