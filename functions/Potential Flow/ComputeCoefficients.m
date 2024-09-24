function [c, A] = ComputeCoefficients(c1, c2, r1, r2, N, alpha)
    % Returns the coefficent necessary to calculate the flow field as in "Computation 
    % of plane potential flow past multi-element airfoils using conformal
    % mapping, revisited". Sahraei, Saman (2018), PhD. Thesis.
    % c is the vector of centers obtained by reflection when applying
    % repeatedly the Milne-Thomson circle theorem.
    % A is the list of source strengths obtained by repeated application of
    % Milne-Thomson circle theorem
    % alpha is the angle of attack, evaluated as the angle between the
    % horizontal and asymptotic flow direction
    % 
    % c1 is the center of the first cylinder 
    % c2 is the center of the second cylinder
    % r1 is the radius of teh first cylinder
    % r2 is the radius of the second cylinder
    % N the number of application of the Milne-Thomson theorem per cylinder
    %
    % Ordering of coefficients in the vector is the following (coherent
    % with the paper multi-index notation for m>=2 airfoils)
    % [c1 c2 c12 c21 c121 c212 ...]
    % [A1 A2 A12 A21 A121 A212 ...]
    
    % Pre-allocate memory
    c = zeros(1, 2*N);
    A = zeros(1, 2*N);
    
    % Initial values
    c(1) = c1;
    c(2) = c2;
    
    A(1) = r1^2 * exp(1i * alpha);
    A(2) = r2^2 * exp(1i * alpha);
    
    % Iterative procedure by successively applying Milne-Thomson circle
    % theorem
    for i=2:N
        
        % Center reflected with repsect to previous circle
        c(2*i-1) = c1 + r1^2 / (c(2*i-2) - c1)';
        c(2*i)   = c2 + r2^2 / (c(2*i-3) - c2)';
        
        % Strength of reflect doublets 
        A(2*i-1) = -(r1/(c(2*i-2) - c1)')^2 * (A(2*i-2)');
        A(2*i)   = -(r2/(c(2*i-3) - c2)')^2 * (A(2*i-3)');

    end


end