function plotTAT(z, Gammas, zv)
        % Plots the flow field and pressure coefficient field for the thin
        % airfoil. 
        % z it the coordinates of the discretized meanline.
        % Gammas is the column vector of concentrated vortex sources.
        % zv is the row vector of vortex points (one for each panel)

        % Define computational domain to calculate streamlines and Cp
        n = 200;
        x = linspace(-1, 2, n);
        y = linspace(-1, 1, n);
        [X, Y] = meshgrid(x, y);
        
        Z = X + 1i * Y;
        W = zeros(size(X));
        
        % Calculate velocity field by passing row by row
        for i = 1:size(W, 1)
            
            W(i, :) = VelocityFromDistribution(Z(i, :), Gammas, zv);


        end
        
        % Calculate pressure coefficient
        Cp = 1 - abs(W).^2;

        % Set up graphic tools
        set(groot,'defaultAxesTickLabelInterpreter','latex');   
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        set(groot,'defaultTextFontSize',16);
        set(groot,'defaultAxesFontSize',16);
        figure('Name', 'Flow over Thin Airfoil Theory', 'NumberTitle', 'off');
        fig = gcf;
        fig.Color = 'w';
        fig.Position = [100 100 1200 800];
        
        contourf(X, Y, Cp, 200, 'LineStyle','None');
        colormap(bluewhitered(1024)); 
        c=colorbar('eastoutside');
        c.TickLabelInterpreter='latex';
        cmax = 1;
        cmin = floor(min(Cp, [], "all"));
        c.Limits = [cmin cmax];
        c.Title.String = "Cp";
       

        hold on
        h1 = plot(real(z), imag(z));
        h1.LineStyle  = '-';
        h1.LineWidth  = 5;
        h1.Color      = 'k';

        
        h4 = streamslice(X, Y, real(W), -imag(W), 4, "noarrows");
        set(h4, 'Color', 'k');
        set(h4, 'LineWidth', 0.8);
        

        ax = gca;
        xlabel(ax, "x/c", 'FontSize', 16);
        ylabel(ax, "y/c", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XLimitMethod = 'tight';
        ax.YLimitMethod = 'tight';
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        axis equal
        box on

        
end

