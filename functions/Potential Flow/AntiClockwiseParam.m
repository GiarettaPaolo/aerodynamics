function zout = AntiClockwiseParam(z, c)
    % Checks wheter the closed curve z is parametrized in a counterclockwise direction. 
    % If the curve is parametrized in a clockwise direction it reverses the
    % order of the points zout = flip(z).
    %
    % C is a point interior to the curve
    % z is the closed curve parametrized from the trailing edge
    % zout is the same curve parametrized in counterclockwise direction

    ang = unwrap(angle(z - c));     % Extract angles of curve points with repect to C
    idx = diff(ang) > 0;            % Check wheter angle increases or not

    if sum(~idx) == length(idx)     % Check if parametrization is clockwise
        zout = flip(z);             % Reverse the parametrization
    elseif sum(idx) == length(idx)  % Check if parametrizatin is counterclockwise
        zout = z;                   % Keep parametrization unchanged
    else
        error('Could not decide if curve z is parametrized clockwise or anticlockwise with respect to point c');
    end
   
end

