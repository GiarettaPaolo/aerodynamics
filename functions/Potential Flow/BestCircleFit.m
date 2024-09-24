function [r, c] = BestCircleFit(z)
    % Given the closed curve parametrized in z, it finds the best circle
    % fitting the curve in the sense of minimizing the mean square error.
    % r is the circle radius and c the center complex coordinates
    
    % Fit spline
    % Reparametrize coordinates on arc-length
    s = cumsum([0 abs(diff(z))]);                    % Calculate arc-lengths
    L = s(end);                                      % Total length
    
    t = linspace(0, L, length(z));
    t = t(1:end-1);   

    x = interp1(s, real(z), t, "spline");            % Spline interpolation of x-coordinate
    y = interp1(s, imag(z), t, "spline");            % Spline interpolation of y-coordinate

    % Get uniformly spaces points
    zval = x + 1i * y;
    
    % To fit a circle on a dataset the optimal values (in the least square sense) of (r, c) are the
    % mean and standard deviation of the curve sample points.

    % Evaluate mean
    c = mean(zval);

    % Evaluate radius as standard deviation from center
    r = std(zval, 1);


end

