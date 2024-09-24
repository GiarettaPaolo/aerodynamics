function Gammas = CalculateGammas(zTE1, zTE2, c, A, alpha)
    % returns Gammas=[Gamma1; Gamma2] of the circulation over the rwo
    % cylinders by solving the 2x2 matrix problem outlined in "Computation 
    % of plane potential flow past multi-element airfoils using conformal
    % mapping, revisited". Sahraei, Saman (2018), PhD. Thesis.
    %
    % zTE1 is the position of the point over the first cylinder where to
    % impose the Kutta condition. 
    % zTE2 is the position of the point over the second cylinder where to
    % impose the Kutta condition.
    % c is the vector of centers obtained by reflection when applying
    % repeatedly the Milne-Thomson circle theorem.
    % A is the list of source strengths obtained by repeated application of
    % Milne-Thomson circle theorem
    % alpha is the angle of attack, evaluated as the angle between the
    % horizontal and asymptotic flow direction
    
    % Create sign function (-1)^(muti-index-1)
    N = length(c);
    sign = (-1).^(floor((0:N-1)/2));
    
    % Calculate values of matrix (vortex contributions)
    v12 = 1i/(2*pi) * sum(sign(1:N-1) ./ (zTE1 - c(1:N-1)));
    v22 = 1i/(2*pi) * sum(sign(1:N-1) ./ (zTE2 - c(1:N-1)));
    v21 = 1i/(2*pi) * sum(sign([1:N-2 N]) ./ (zTE2 - c([1:N-2 N])));
    v11 = 1i/(2*pi) * sum(sign([1:N-2 N]) ./ (zTE1 - c([1:N-2 N])));

    % Calculate know term (doubletcontributions)
    b1 = exp(-1i * alpha) - sum(A ./ (zTE1 - c).^2);
    b2 = exp(-1i * alpha) - sum(A ./ (zTE2 - c).^2);
    
    % Impose Kutta conditions ans solve linear system
    Gammas = -[v11 v12 ; v21 v22] \ [b1; b2];

end

