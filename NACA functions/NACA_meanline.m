function [y, dy] = NACA_meanline(x, m, p)
       % Returns the NACA mean line profile and its derivative
       % x are the evaluation points
       % m is the maximum ordinate of the mean line (first digit)
       % p is the position of the maximum ordinate m (second digit)
       % All quantities are adimensionalized wrt chord dimension
       %
       % % I. H. Abbot and A. E. von Doenhoff
       % Theory of Wing Sections
       % Dover, New York, 1949, 1959 

       % Extract points before or after p absciss (vectorized form)
       idx = x < p;
       
       % Piecewise defined meanline of NACA profile (two tangent parabolas)
       y = (m/p^2) .* (2*p - x) .* x .* idx + ...
           ~idx .* (m/(1-p)^2) .* (1 - 2*p + (2*p - x) .* x);
       
       % Piecewise defined derivative of NACA profile (two linear
       % functions)
       dy = (m/p^2) .* 2 .* (p - x) .* idx + ...
           ~idx .* (m/(1-p)^2) .* 2 .*(p - x);
    
end

