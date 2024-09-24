function [f, df] = CalculatePotential(z, c, A, alpha, Gammas)
    % Returns the complex potential and complex velocity field at query
    % points in row vector z.
    % c is the vector of centers obtained by reflection when applying
    % repeatedly the Milne-Thomson circle theorem.
    % A is the list of source strengths obtained by repeated application of
    % Milne-Thomson circle theorem
    % alpha is the angle of attack, evaluated as the angle between the
    % horizontal and asymptotic flow direction
    % Gammas=[Gamma1; Gamma2] is the vector of circulations over the
    % cylinders.

    % Pre-create sign function (-1)^(muti-index-1)
    N = length(c);
    sign = (-1).^(floor((0:N-1)/2));

    % Complex potential (sum of asymptotic flow potential, doublet
    % contributions and vortex contributions).
    ws = exp(-1i * alpha) + sum(A ./ (z - c), 2);
    wc = 1i/(2*pi) * sum(sign(1:N-1) .* log(z - c(1:N-1)), 2) * Gammas(2) + ...
        1i/(2*pi) * sum(sign([1:N-2 N]) .* log(z - c([1:N-2 N])), 2) * Gammas(1);
    
    f = ws + wc;
    
    % Complex velocity
    dws = exp(-1i * alpha) - sum(A ./ (z - c).^2 , 2);
    dwc = 1i/(2*pi) * sum(sign(1:N-1) ./ (z - c(1:N-1)), 2) * Gammas(2) + ...
        1i/(2*pi) * sum(sign([1:N-2 N]) ./ (z - c([1:N-2 N])), 2) * Gammas(1);

    df = dws + dwc;
    
end

