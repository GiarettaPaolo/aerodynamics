function plotClCurves(alpha_vect, h_vect, Cl)
        % Plots the ilft coefficient curves for different
        % ride heights. 
        % The range of angles of attack is contained in alpha_vect, whereas
        % the ride heights in h_vect. The Cl matrix presents for each row
        % the values of lift coefficients for the span of angle of attack.
        
        % Set up graphic tools
        set(groot,'defaultAxesTickLabelInterpreter','latex');   
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        set(groot,'defaultTextFontSize',16);
        set(groot,'defaultAxesFontSize',16);
        figure('Name', 'Lift coefficient curves', 'NumberTitle', 'off');
        fig = gcf;
        fig.Color = 'w';
        fig.Position = [100 100 600 400];
        
        % Build legend and colormap
        l = length(h_vect);
        colormap("hsv");
        leg = cell(size(h_vect));
        
        % Convert alphas into degrees
        alpha_vect = alpha_vect * 180 / pi;

        % Plot
        hold on
        for i=1:l
            
            h = plot(alpha_vect, Cl(i, :));
            h.LineWidth = 1.2;
            h.LineStyle = '-';
            h.Marker = 'square';
            h.MarkerSize = 5;
                
                
             % Build legend
             leg{i} = num2str(h_vect(i), "%.1f"); 
             if h_vect(i) > 5
                 leg{i} = "$\infty$";
             end
        end
        
        ax = gca;
        xlabel(ax, "Angle of attack [deg]", 'FontSize', 16);
        ylabel(ax, "Lift Coefficient", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.XLim = [-4 10];
        ax.YLim = [-0.5 2];
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        lgd = legend(ax, leg); 
        lgd.Location = 'southeast';
        lgd.FontSize = 16;
        lgd.Title.String = 'h/c';
        lgd.Title.FontSize = 12;
        title("Potential Flow lift curves")


end

