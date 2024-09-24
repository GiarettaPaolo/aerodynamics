function [ang1, ang2] = findTrailingEdge(zTE1, zTE2, a1, a2, r1, r2, c1, c2)
    % Returns the angular coordinates ang1, ang2 of the points over the two
    % cylidners that are mapped to the airfoil trailing edges (for imposing
    % the Kutta condition). Given the map is approximate (truncated infinte
    % series) the points are found by minimizing the distance between the
    % image of the Conformal map and the desired output.
    %
    % zTE1 is the coordinate of the trailing edge on the first near-circular
    % boundary
    % zTE2 is the coordinate of the trailing edge on the second
    % near-circular boundary
    % a1 the series expansion coefficients for the first map
    % a2 the series expansion coefficients for the second map
    % r1 the first cylinder radius
    % r2 the second cylinder radius
    % c1 the first cylinder center coordinates
    % c2 the second cylinder center coordinates
    
    % Define optimization problem to find the closest point
    f2min1 = @(ang) abs(zTE1-ConformalMap(c1 + r1 * exp(1i * ang), a1, a2, r1, r2, c1, c2));
    f2min2 = @(ang) abs(zTE2-ConformalMap(c2 + r2 * exp(1i * ang), a1, a2, r1, r2, c1, c2));    
    
    % Solve minimization problem
    options = optimoptions("fminunc","Display","none", "FunctionTolerance", 1e-9, "StepTolerance", 1e-9);
    ang1 = fminunc(f2min1, 0, options);
    ang2 = fminunc(f2min2, 0, options);


end

