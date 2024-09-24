function  plotPotentialFlowComparison(Cl, alpha_vect, data)
        % Plots the side-by-side comparison of the Cl_alphas curve between
        % the reconstructed lift coefficietn curves contained in the matrix
        % Cl and the one sfrom the paper in the data structure data.mat. 
        
        % Convert to degrees for plotting
        alpha_vect = 180 / pi * alpha_vect;
        
        alpha_vect_paper = (-4:2:10);
        % Calculate absoulte errors
        clexp04 = interp1(data.cl04(1, :), data.cl04(2, :), alpha_vect_paper, 'spline');
        Cl_int1 = interp1(alpha_vect, Cl(1, :), alpha_vect_paper, 'spline');
        error(1,:) = abs(clexp04 - Cl_int1);
        clexp08 = interp1(data.cl08(1, :), data.cl08(2, :), alpha_vect_paper, 'spline');
        Cl_int2 = interp1(alpha_vect, Cl(2, :), alpha_vect_paper, 'spline');
        error(2,:) = abs(clexp08 - Cl_int2);
        clexp1 = interp1(data.cl1(1, :), data.cl1(2, :), alpha_vect_paper, 'spline');
        Cl_int3 = interp1(alpha_vect, Cl(3, :), alpha_vect_paper, 'spline');
        error(3,:) = abs(clexp1 - Cl_int3);
        clexpinf = interp1(data.clinf(1, :), data.clinf(2, :), alpha_vect_paper, 'spline');
        Cl_int4 = interp1(alpha_vect, Cl(4, :), alpha_vect_paper, 'spline');
        error(4,:) = abs(clexpinf - Cl_int4);
        
        % Print on terminal the errors
        % fprintf("\n Absolute error value for h/c = 0.4 : at -4deg : %f, at 0deg : %f, at 5deg : %f, at 10deg : %f", error(1, [1, 5, 10, 15]))
        % fprintf("\n Absolute error value for h/c = 0.8 : at -4deg : %f, at 0deg : %f, at 5deg : %f, at 10deg : %f", error(2, [1, 5, 10, 15]))
        % fprintf("\n Absolute error value for h/c = 1.0 : at -4deg : %f, at 0deg : %f, at 5deg : %f, at 10deg : %f", error(3, [1, 5, 10, 15]))
        % fprintf("\n Absolute error value for h/c = inf : at -4deg : %f, at 0deg : %f, at 5deg : %f, at 10deg : %f \n", error(4, [1, 5, 10, 15]))
        % 
        % fprintf("\n Relative error value for h/c = 0.4 : at -4deg : %f, at 0deg : %f, at 5deg : %f, at 10deg : %f", abs(error(1, [1, 5, 10, 15])./clexp04([1, 5, 10, 15])))
        % fprintf("\n Relative error value for h/c = 0.8 : at -4deg : %f, at 0deg : %f, at 5deg : %f, at 10deg : %f", abs(error(2, [1, 5, 10, 15])./clexp08([1, 5, 10, 15])))
        % fprintf("\n Relative error value for h/c = 1.0 : at -4deg : %f, at 0deg : %f, at 5deg : %f, at 10deg : %f", abs(error(3, [1, 5, 10, 15])./clexp1([1, 5, 10, 15])))
        % fprintf("\n Relative error value for h/c = inf : at -4deg : %f, at 0deg : %f, at 5deg : %f, at 10deg : %f \n", abs(error(4, [1, 5, 10, 15])./clexpinf([1, 5, 10, 15])))

        % Set up graphic tools
        set(groot,'defaultAxesTickLabelInterpreter','latex');   
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        set(groot,'defaultTextFontSize',16);
        set(groot,'defaultAxesFontSize',16);
        figure('Name', 'Comparison lift coefficietn curves', 'NumberTitle', 'off');
        fig = gcf;
        fig.Color = 'w';
        fig.Position = [100 100 1200 800];
        
        xlim = [min(alpha_vect) max(alpha_vect)];

        subplot(2, 2, 1)
        hold on
        h1 = plot(alpha_vect, Cl(1, :));
        h1.LineWidth = 2;
        h1.LineStyle = '-';
        h1.Color = 'b';
        h1.Marker = 'none';
        h1.MarkerSize = 10;
        
        h2 = plot(alpha_vect_paper, clexp04);
        h2.LineWidth = 2;
        h2.LineStyle = '--';
        h2.Color = 'k';
        h2.Marker = 'square';
        h2.MarkerSize = 8;

        h3 = plot(alpha_vect_paper, error(1,:));
        h3.LineWidth = 2;
        h3.LineStyle = '-';
        h3.Color = 'r';
        h3.Marker = 'diamond';
        h3.MarkerSize = 8;

        ax = gca;
        xlabel(ax, "$\alpha$", 'FontSize', 16);
        ylabel(ax, "$C_l$", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.YLim = [-0.5 2];
        ax.XLim = xlim;
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        lgd = legend(ax, {"Potential flow", "Paper", "Absolute error"});  
        lgd.Location = "northwest";
        title("h/c = 0.4")

        subplot(2, 2, 2)
        hold on

        h1 = plot(alpha_vect, Cl(2, :));
        h1.LineWidth = 2;
        h1.LineStyle = '-';
        h1.Color = 'b';
        h1.Marker = 'none';
        h1.MarkerSize = 5;
        
        h2 = plot(alpha_vect_paper, clexp08);
        h2.LineWidth = 2;
        h2.LineStyle = '--';
        h2.Color = 'k';
        h2.Marker = 'square';
        h2.MarkerSize = 8;

        h3 = plot(alpha_vect_paper, error(2,:));
        h3.LineWidth = 2;
        h3.LineStyle = '-';
        h3.Color = 'r';
        h3.Marker = 'diamond';
        h3.MarkerSize = 8;

        ax = gca;
        xlabel(ax, "$\alpha$", 'FontSize', 16);
        ylabel(ax, "$C_l$", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.YLim = [-0.5 2];
        ax.XLim = xlim;
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        lgd = legend(ax, {"Potential flow", "Paper", "Absolute error"});    
        lgd.Location = "northwest";
        title("h/c = 0.8")

        subplot(2, 2, 3)
        hold on
        h1 = plot(alpha_vect, Cl(3, :));
        h1.LineWidth = 2;
        h1.LineStyle = '-';
        h1.Color = 'b';
        h1.Marker = 'none';
        h1.MarkerSize = 5;

        h2 = plot(alpha_vect_paper, clexp1);
        h2.LineWidth = 2;
        h2.LineStyle = '--';
        h2.Color = 'k';
        h2.Marker = 'square';
        h2.MarkerSize = 8;

        h3 = plot(alpha_vect_paper, error(3,:));
        h3.LineWidth = 2;
        h3.LineStyle = '-';
        h3.Color = 'r';
        h3.Marker = 'diamond';
        h3.MarkerSize = 8;

        ax = gca;
        xlabel(ax, "$\alpha$", 'FontSize', 16);
        ylabel(ax, "$C_l$", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.YLim = [-0.5 2];
        ax.XLim = xlim;
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        lgd = legend(ax, {"Potential flow", "Paper", "Absolute error"});   
        lgd.Location = "northwest";
        title("h/c = 1.0")

        subplot(2, 2, 4)
        hold on
        h1 = plot(alpha_vect, Cl(4, :));
        h1.LineWidth = 2;
        h1.LineStyle = '-';
        h1.Color = 'b';
        h1.Marker = 'none';
        h1.MarkerSize = 5;
        
        h2 = plot(alpha_vect_paper, clexpinf); 
        h2.LineWidth = 2;
        h2.LineStyle = '--';
        h2.Color = 'k';
        h2.Marker = 'square';
        h2.MarkerSize = 8;

        h3 = plot(alpha_vect_paper, error(4,:));
        h3.LineWidth = 2;
        h3.LineStyle = '-';
        h3.Color = 'r';
        h3.Marker = 'diamond';
        h3.MarkerSize = 8;

        ax = gca;
        xlabel(ax, "$\alpha$", 'FontSize', 16);
        ylabel(ax, "$C_l$", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.YLim = [-0.5 2];
        ax.XLim = xlim;
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        lgd = legend(ax, {"Potential flow", "Paper", "Absolute error"});   
        lgd.Location = "northwest";
        title("h/c = $\infty$")

        
end