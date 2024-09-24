function [xu, yu, xl, yl] = NACA_airfoil(n, m, p, t)
       % n is the number of points per surface
       % x are evaluation points
       % m is the maximum ordinate of the mean line (first digit)
       % p is the position of the maximum ordinate m (second digit)
       % t is the maximum profile thickness (last two digits)
       % All quantities are adimensionalized wrt chord dimension
       %
       % I. H. Abbot and A. E. von Doenhoff
       % Theory of Wing Sections
       % Dover, New York, 1949, 1959 

       % Points distributed non-uniformly for better representation of leading edge
       x = (cos(linspace(0, 1, n)*pi) + 1)/2;   
       
       % Calculate meanline coordinates
       [y, dy] = NACA_meanline(x, m, p);

       % Calculate thickness distribution
       s = NACA_thickness(x, t);
        
       % sin(theta) and cos(theta) where theta is the angle of the mean
       % line wrt the horizontal
       cosm = 1 ./ sqrt(1+dy.^2);
       sinm = cosm .* dy;
       
        
       % Construct surfaces by applying thickness distribution in the local
       % normal direction to the meanline
       % Upper surface points
       xu = x - s .* sinm;
       yu = y + s .* cosm;

       % Lower surface points
       xl = x + s .* sinm;
       yl = y - s .* cosm;
       

end

