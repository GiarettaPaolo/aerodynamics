function  plotExperimentalCl(data)
        % plots the Cl curves from the paper contained in the data.mat
        % data struct

        % Set up graphic tools
        set(groot,'defaultAxesTickLabelInterpreter','latex');   
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        set(groot,'defaultTextFontSize',16);
        set(groot,'defaultAxesFontSize',16);
        figure('Name', 'Experimental Lift Coefficient', 'NumberTitle', 'off');
        fig = gcf;
        fig.Color = 'w';
        fig.Position = [100 100 600 400];
        
        % Build legend and colormap
        colormap("hsv");
        
        alpha_vect_paper = (-4:2:10);
        % Calculate absoulte errors
        clexp04 = interp1(data.cl04(1, :), data.cl04(2, :), alpha_vect_paper, 'spline');
        clexp08 = interp1(data.cl08(1, :), data.cl08(2, :), alpha_vect_paper, 'spline');
        clexp1 = interp1(data.cl1(1, :), data.cl1(2, :), alpha_vect_paper, 'spline');
        clexpinf = interp1(data.clinf(1, :), data.clinf(2, :), alpha_vect_paper, 'spline');


        hold on
        h1 = plot(alpha_vect_paper, clexp04);
        h1.LineWidth = 1.2;
        h1.LineStyle = '-';
        h1.Marker = 'square';
        h1.MarkerSize = 5;
        
        h2 = plot(alpha_vect_paper, clexp08);
        h2.LineWidth = 1.2;
        h2.LineStyle = '-';
        h2.Marker = 'square';
        h2.MarkerSize = 5;

        h3 = plot(alpha_vect_paper, clexp1);
        h3.LineWidth = 1.2;
        h3.LineStyle = '-';
        h3.Marker = 'square';
        h3.MarkerSize = 5;

        h4 = plot(alpha_vect_paper, clexpinf);
        h4.LineWidth = 1.2;
        h4.LineStyle = '-';
        h4.Marker = 'square';
        h4.MarkerSize = 5;
        
        ax = gca;
        xlabel(ax, "Angle of attack [deg]", 'FontSize', 16);
        ylabel(ax, "Lift Coefficient", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.YLim = [-0.5 2];
        ax.XLim = [-4 10];
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        leg = {"0.4", "0.8", "1", "inf"};
        lgd = legend(ax, leg); 
        lgd.Location = 'southeast';
        lgd.FontSize = 16;
        lgd.Title.String = 'h/c';
        lgd.Title.FontSize = 12;
        title("Paper lift curves")
        
end

