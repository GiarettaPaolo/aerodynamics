function plotExperimentalCp(data)
        % plots the Cp curves from the paper contained in the data.mat
        % data struct

        % Set up graphic tools
        set(groot,'defaultAxesTickLabelInterpreter','latex');   
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        set(groot,'defaultTextFontSize',16);
        set(groot,'defaultAxesFontSize',16);
        figure('Name', 'Experimental Cp coefficient', 'NumberTitle', 'off');
        fig = gcf;
        fig.Color = 'w';
        fig.Position = [100 100 1200 800];
        
        % Build legend and colormap
        colormap("hsv");
        
        hold on
        h1 = plot(data.DCp_4(1, :), data.DCp_4(2, :));
        h1.LineWidth = 1.6;
        h1.LineStyle = '-';
        
        h2 = plot(data.DCp_8(1, :), data.DCp_8(2, :));
        h2.LineWidth = 1.6;
        h2.LineStyle = '-';

        h3 = plot(data.DCp_16(1, :), data.DCp_16(2, :));
        h3.LineWidth = 1.6;
        h3.LineStyle = '-';

        h4 = plot(data.DCp_18(1, :), data.DCp_18(2, :));
        h4.LineWidth = 1.6;
        h4.LineStyle = '-';
        
        ax = gca;
        xlabel(ax, "x/c", 'FontSize', 16);
        ylabel(ax, "$\Delta C_p$", 'FontSize', 16);
        ax.XRuler.Exponent = 0;
        ax.YRuler.FontSize = 16;
        ax.XRuler.FontSize = 16;
        ax.XMinorTick = 'on';
        ax.YMinorTick = 'on';
        ax.XLimitMethod = 'tickaligned';
        ax.YLimitMethod = 'tickaligned';
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        leg = {"4", "8", "16", "18"};
        lgd = legend(ax, leg); 
        lgd.Location = 'northeast';
        lgd.FontSize = 16;
        lgd.Title.String = 'Angle of Attack';
        lgd.Title.FontSize = 12;

end

