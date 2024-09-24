function plotFlowOverCylinders(r1, r2, c1, c2, N, ang1, ang2)
            
            % Plots the flow over two cylinders in the complex plane of
            % radii r1, r2 and centers c1, c2. 
            % N is the number of applications of the Milne-Thomson circel
            % theorem per cylinder
            % ang1 the angular position wrt the horizontal where to impose
            % the Kutta condition on the first cylinder
            % ang2 the angular positin wrt the horizontal where to impose
            % the Kutta condition on th second cylinder
            
            % Calculate points where to impose the Kutta condition
            zTE1 = c1 + r1 * exp(1i * ang1);
            zTE2 = c2 + r2 * exp(1i * ang2);
            
            % Solve for the flow over the cylinders
            [c, A] = ComputeCoefficients(c1, c2, r1, r2, N, 0);
            Gammas = CalculateGammas(zTE1, zTE2, c, A, 0);
            Gammas = real(Gammas);
            
            % Define computational domain to plot streamlines and Cp
            x = 4*linspace(min(real(c1-r1), real(c2-r2))-1, max(real(c1+r1), real(c2+r2))+1, 400);
            y = 2*linspace(min(imag(c1-r1), imag(c2-r2))-1, max(imag(c1+r1), imag(c2+r2))+1, 400);
            [X, Y] = meshgrid(x, y);
            Z = X + 1i * Y;
            
            % pre-allcoate memory
            f = zeros(size(Z));
            df = zeros(size(Z));
            
            % Calculate potential and flow by passing row by row
            for i=1:size(f, 2)

                [f(:, i), df(:, i)] = CalculatePotential(Z(:, i), c, A, 0, Gammas);

            end
            
            % Calculate Cp field
            df(or(abs(Z-c1) < r1, abs(Z-c2)<r2)) = nan;
            Cp = 1 - abs(df).^2;
            
            % Discretize cylidner boundaries
            theta = linspace(0, 2*pi, 1000);
            Z1 = c1 + r1 * exp(1i * theta);
            Z2 = c2 + r2 * exp(1i * theta);

            % Set up graphic tools
            set(groot,'defaultAxesTickLabelInterpreter','latex');   
            set(groot,'defaulttextinterpreter','latex');
            set(groot,'defaultLegendInterpreter','latex');
            set(groot,'defaultTextFontSize',16);
            set(groot,'defaultAxesFontSize',16);
            figure('Name', 'Flow over Cylinders', 'NumberTitle', 'off');
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
            fill(real(Z1), imag(Z1), 'w');
            h1 = plot(real(Z1), imag(Z1));
            h1.LineStyle  = '-';
            h1.LineWidth  = 3;
            h1.Color      = 'k';
            
            fill(real(Z2), imag(Z2), 'w');
            h2 = plot(real(Z2), imag(Z2));
            h2.LineStyle  = '-';
            h2.LineWidth  = 3;
            h2.Color      = 'k';
        
            
            h4 = streamslice(X, Y, real(df), -imag(df), 4, "noarrows");
            set(h4, 'Color', 'k');
            set(h4, 'LineWidth', 0.8);
            
            plot(zTE1, 'MarkerSize', 20, 'Marker', '.', 'Color', 'k')
            plot(zTE2, 'MarkerSize', 20, 'Marker', '.', 'Color', 'k')
        
            ax = gca;
            xlabel(ax, "x/c", 'FontSize', 16);
            ylabel(ax, "y/c", 'FontSize', 16);
            ax.XRuler.Exponent = 0;
            ax.YRuler.FontSize = 16;
            ax.XRuler.FontSize = 16;
            ax.XMinorTick = 'on';
            ax.YMinorTick = 'on';
            ax.XLimitMethod = 'tickaligned';
            ax.YLimitMethod = 'tickaligned';
            ax.XGrid = 'off';
            ax.YGrid = 'off';
            ax.XMinorGrid = 'off';
            ax.YMinorGrid = 'off';
            axis equal
            box on
        
end

