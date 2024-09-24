function [y, dy] = NACA_thickness(x, t)
       % Returns the NACA profile thickness and its derivative
       % x are the evaluation points
       % t is the maximum profile thickness (last two digits)
       % All quantities are adimensionalized wrt chord dimension
       %
       % % I. H. Abbot and A. E. von Doenhoff
       % Theory of Wing Sections
       % Dover, New York, 1949, 1959 
       
       % Interpolant for NACA airfoil defining meanline
       y = 5 * t .* (0.29690 * sqrt(x)  -  0.12600 * x  - ...
           0.35160 * x.^2 +  0.28430 * x.^3  -  0.10360 * x.^4);
       
       % Interpolant for NACA airfoil defining meanline derivative
       dy =  5 * t .* (0.14845 ./ sqrt(x)  -  0.12600  -  0.7032 .* x  ...
                                 +  0.8529 * x.^2  - 0.4144*x.^3);


end

