function W = VelocityFromDistribution(Z, Gammas, zv)
        % returns the complex velocity W as a row vector at each query
        % point in the row vector Z
        % Gammas is the column vector of vortex strengths for the Discrete
        % Vortex Method
        % zv is the row vector of vortex distribution points
        
        % Complex velocity 
        % 1 is the contribution of the asymptotic complex flow (adimensionalized)
        W = 1 + 1i / (2 * pi) * sum(Gammas ./ (Z - zv.'), 1);

end

