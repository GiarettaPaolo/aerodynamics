function  plotThinAirfoilComparison(x_TAT, x_DVM, Cp4_TAT, Cp8_TAT, Cp16_TAT, Cp18_TAT, ...
    Cp4_DVM, Cp8_DVM, Cp16_DVM, Cp18_DVM, data)
        % Plots the side-by-side comparison of the differential pressure coefficient
        % curve between the reconstructed ones from the classical thin
        % airfoil theory and discrete vortex method and CFD data from the
        % paper.
        % x_TAT are the chordwise coordinates for the classical thin
        % airfoil theory
        % x_DVM are the chordwise coordinates for the discrete vortex
        % method
        % Cp4_TAT, Cp8_TAT, Cp16_TAT, Cp18_TAT are the curves obtained with
        % the classical airfoil theory for 4, 8, 16, 18 deg AoAs
        % Cp4_DVM, Cp8_DVM, Cp16_DVM, Cp18_DVM are the curves obtained for 
        % the discrete vortex method for 4, 8, 16, 18 deg AoAs
        % data is the data structure containing the respective curves from
        % the paper

       

        % Set up graphic tools
        set(groot,'defaultAxesTickLabelInterpreter','latex');   
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        set(groot,'defaultTextFontSize',16);
        set(groot,'defaultAxesFontSize',16);
        figure('Name', 'Compare pressure coefficients', 'NumberTitle', 'off');
        fig = gcf;
        fig.Color = 'w';
        fig.Position = [100 100 1200 800];
        
        subplot(2, 2, 1)
        hold on
        h1 = plot(x_TAT, Cp4_TAT);
        h1.LineWidth = 2;
        h1.LineStyle = '-';
        h1.Color = 'r';
        
        h2 = plot(x_DVM, Cp4_DVM);
        h2.LineWidth = 2;
        h2.LineStyle = '-';
        h2.Color = 'b';
        
        h3 = plot(data.DCp_4(1, :), data.DCp_4(2, :));
        h3.LineWidth = 2;
        h3.LineStyle = '--';
        h3.Color = 'k';

        ax = gca;
        xlabel(ax, "x/c", 'FontSize', 16);
        ylabel(ax, "$\Delta C_p$", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XLimitMethod = 'tickaligned';
        ax.YLim = [0 5];
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        legend(ax, {"Thin Airfoil", "Discrete Vortex Method", "Paper"}); 
        title("$\alpha = 4^\circ$")

        subplot(2, 2, 2)
        hold on
        h1 = plot(x_TAT, Cp8_TAT);
        h1.LineWidth = 2;
        h1.LineStyle = '-';
        h1.Color = 'r';
        
        h2 = plot(x_DVM, Cp8_DVM);
        h2.LineWidth = 2;
        h2.LineStyle = '-';
        h2.Color = 'b';
        
        h3 = plot(data.DCp_8(1, :), data.DCp_8(2, :));
        h3.LineWidth = 2;
        h3.LineStyle = '--';
        h3.Color = 'k';        

        ax = gca;
        xlabel(ax, "x/c", 'FontSize', 16);
        ylabel(ax, "$\Delta C_p$", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XLimitMethod = 'tickaligned';
        ax.YLim = [0 5];
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        legend(ax, {"Thin Airfoil", "Discrete Vortex Method", "Paper"}); 
        title("$\alpha = 8^\circ$")

        subplot(2, 2, 3)
        hold on
        h1 = plot(x_TAT, Cp16_TAT);
        h1.LineWidth = 2;
        h1.LineStyle = '-';
        h1.Color = 'r';
        
        h2 = plot(x_DVM, Cp16_DVM);
        h2.LineWidth = 2;
        h2.LineStyle = '-';
        h2.Color = 'b';
        
        h3 = plot(data.DCp_16(1, :), data.DCp_16(2, :));
        h3.LineWidth = 2;
        h3.LineStyle = '--';
        h3.Color = 'k';        

        ax = gca;
        xlabel(ax, "x/c", 'FontSize', 16);
        ylabel(ax, "$\Delta C_p$", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XLimitMethod = 'tickaligned';
        ax.YLim = [0 5];
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        legend(ax, {"Thin Airfoil", "Discrete Vortex Method", "Paper"}); 
        title("$\alpha = 16^\circ$")

        subplot(2, 2, 4)
        hold on
        h1 = plot(x_TAT, Cp18_TAT);
        h1.LineWidth = 2;
        h1.LineStyle = '-';
        h1.Color = 'r';
        
        h2 = plot(x_DVM, Cp18_DVM);
        h2.LineWidth = 2;
        h2.LineStyle = '-';
        h2.Color = 'b';
        
        h3 = plot(data.DCp_18(1, :), data.DCp_18(2, :));
        h3.LineWidth = 2;
        h3.LineStyle = '--';
        h3.Color = 'k';        

        ax = gca;
        xlabel(ax, "x/c", 'FontSize', 16);
        ylabel(ax, "$\Delta C_p$", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XLimitMethod = 'tickaligned';
        ax.YLim = [0 5];
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        legend(ax, {"Thin Airfoil", "Discrete Vortex Method", "Paper"}); 
        title("$\alpha = 18^\circ$")

        
end

