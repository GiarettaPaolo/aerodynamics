function [z, dz] = inverseTrefftz(zeta, z1, z2, zeta1, zeta2, beta)
        % Returns the inverse of the Karman-Trefftz transform as well as its derivative 
        % mapping between zeta -> z. beta is the inverse of the exponent in the
        % Karman-Trefftz transform to be inverted. zeta1 -> z1 the inverse
        % transformation of the trailing edge and zeta2 -> z2 the inverse
        % transformation of the point near the leadinf edge
        
        % Correct for discontinuity in phase 
        x = ((zeta - zeta1) ./ (zeta - zeta2));     % Fractional exponent argument
        ang = angle(x);                             % Extract angle
        mod = abs(x);                               % Extract absolute value
        ang = unwrap(ang);                          % Remove discontinuity in phase

        x = mod.^beta .* exp(1i .* ang * beta);     % Calculate fractional exponent
        z = (z1 - z2 .* x)./(1 - x);                % Calculate output
        
        y = (zeta - zeta1)./(zeta - zeta2);         % Fractional exponent argument
        ang = unwrap(angle(y));                     % Extract angle and correct discontinuity in phase
        mod = abs(y);                               % Extract absolute value

        % Calculate transformation derivative
        dz = (z1 - z2)./(1-x).^2 .* beta .* mod.^(beta - 1) .* exp(1i .* ang .* (beta-1)) ...
            .* (zeta1 - zeta2) ./ (zeta - zeta2).^2;

end


