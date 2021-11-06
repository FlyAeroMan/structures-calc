# structures-calc
A set of MATLAB codes that use data from a spreadsheet to calculate buckling location and failure loads for advanced aerospace beams

This codebase will contain codes meant for structural analysis of advanced aerospace beams under a specific loading condition. The loading condition of focus is that of an upward force "P" at the center of a cross section, and a smaller "q" force of magnitude 5lbf on the Leading edge (LE) of the cross section, acting on a wingbox. The fixed end of the wing box is located at x=0in, while the free end is defined as an arbitrary positive value of x.

The code will be entirely controlled through a spreadsheet which is ingested by the code to define all properties of the wingbox including size, volume, moments of inertia, material properties, and much more. The codes will be capable of handling non-homogenious cross sections, but assumes a 0°F change in temperature. See the full list of assumptions below. All units are in english engineering units(slugs, lbf, psi, in, etc.), unless otherwise notated. The primary language in this repository will be MATLAB.

Assumptions:
[To be Compiled Later]

>NOTE: Due to these assumptions, the answers provided from this code are at best approximate in nature, so USE AT YOUR OWN RISK!
