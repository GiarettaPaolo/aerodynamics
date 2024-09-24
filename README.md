# aerodynamics
_Why does ground effect increase lift? Can classical aerodynamics predict it?_

## Overview
This project aims to reproduce results from the paper titled "Airfoil Aerodynamics in Ground Effect for Wide Range of Angles of Attack" by Qiulin Qu, Wei Wang, and Peiqing Liu, published in the AIAA Journal in 2014. The focus is on analyzing the aerodynamics of airfoils in ground effect using potential flow theory and thin airfoil theory, compared against viscous Computational Fluid Dynamics (CFD) results.

### Potential Flow Theory
1. **Conformal Mapping**: The project utilizes a conformal mapping technique to transform the geometry of the airfoils with ground effect into two circles. This method allows for easier analytical solutions for potential flow over the airfoils.
   <img src="ConformalMaps.png" alt="Conformal mapping of airfoils" width="600"/>

2. **Flow over Cylinders**: Once the airfoil shapes are mapped to circles, the flow properties over two cylinders are calculated. This provides the necessary aerodynamic properties to analyze the effects of ground proximity.
   <img src="images/FlowOverCylinders.png" alt="Flow over two cylinders" width="600"/>

### Thin Airfoil Theory (No Ground Effect)
- **Classical Thin Airfoil Theory**: This section employs classical thin airfoil theory to derive expressions for lift and drag coefficients without considering ground effect. The theory uses trigonometric expansions to model the flow around the airfoil.

- **Discrete Vortex Method**: The Discrete Vortex Method (DVM) is implemented to visualize the flow field around the airfoil and compute aerodynamic properties. The DVM discretizes the circulation around the airfoil to obtain lift and drag characteristics effectively.
   <img src="images/thinairfoilComparison.png" alt="Results comparison for thin airfoil theory" width="600"/>
   <img src="images/tatflow.png" alt="Flow visualization over the airfoil" width="600"/>

## Conclusion
We encourage you to explore the results generated from this project and delve deeper into the analysis provided. The insights gained from the comparison of potential flow theory and thin airfoil theory with CFD results offer valuable perspectives on airfoil performance in ground effect. For a comprehensive understanding, we recommend reading the full report to grasp the methodologies and findings in detail.
