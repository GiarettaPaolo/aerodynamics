function [z, dz] = ConformalMap(zeta, a1, a2, r1, r2, c1, c2)
    % Calculates the coordinates and its derivative of the conformal map
    % between the two cylinders to the near-circular regions.
    % Based on the work presented in  "Numerical conformal mapping of 
    % multiply connected regions by Fornberg-like methods" DeLillo, 
    % Thomas K, Mark A Horn, and John A Pfaltzgraff (1999)
    % zeta is the row vector of query points
    % a1 the series expansion coefficients for the first map
    % a2 the series expansion coefficients for the second map
    % r1 the first cylinder radius
    % r2 the second cylinder radius
    % c1 the first cylinder center coordinates
    % c2 the second cylinder center coordinates
    
    % Numebr of terms to be considered in the expansion
    M = length(a1);
    
    % Calculate outputs as truncated infinte series (vectorized for
    % efficiency)
    z = zeta + sum(a1 .* (r1./(zeta - c1)).^((1:M)'), 1) + ...
        sum(a2 .* (r2./(zeta - c2)).^((1:M)'), 1);
    
    % Calculate derivatives of conformal map at query points
    dz = 1 - sum(a1 ./ r1 .* (r1./(zeta - c1)).^((2:M+1)') .* ((1:M)'), 1) - ...
        sum(a2 ./ r2 .* (r2./(zeta - c2)).^((2:M+1)') .* ((1:M)'), 1);   

end