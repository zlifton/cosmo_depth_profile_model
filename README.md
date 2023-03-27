# cosmo_depth_profile_model
This code was part of a project to model cosmogenic nuclide concentration and test how inheritance, erosion, and deposition affect concentrations at depth.

# Introduction
Terrestrial cosmogenic nuclides (TCNs) are radioisotopes that are produced in rock by interactions with galactic cosmic rays (Lal, 1991; Gosse and Phillips, 2001).  Galactic cosmic rays (GCR) are high energy particles that are bombarding the Earth at a rate that is believed to be constant (although the flux at Earth’s surface is governed by latitude and elevation).  By measuring the concentrations of the products of these interactions, we can calculate the age of exposure of the material.  Beryllium-10 (10Be) and Aluminum-26 (26Al) are two commonly used TCNs because they are both produced in nuclear spallations and negative muon capture reactions of O and Si, which are the most common elements at the Earth’s surface, usually in the form of the mineral quartz (SiO4).  Quartz is an ideal material to date because it is common, durable, and relatively easy to separate from other minerals (Bierman et al., 2002).
	
Many methods have been developed for using TCNs to date landforms and processes on Earth.  The simplest application is calculating an exposure age of a surface.  A material that is exposed at the surface of the Earth will act as a cosmic ray “dosimeter” (Bierman et al., 2002).  If production and decay rates are known for the TCNs that are produced by the cosmic rays, we can use the concentrations of these nuclides to determine the amount of time that a material has been exposed at the surface.  A common example of this method is the dating of glaciations using glacier-polished bedrock (e.g. Nishiizumi et al., 1989).  This is an excellent setting for exposure dating because glacier-polished bedrock is assumed to be freshly eroded, leaving a rock surface which has not been eroded or buried since glaciations and has no inherited TCNs from previous exposure.  More complex treatments of TCNs can yield information about inheritance of nuclides, transport history, erosion rates, denudation rates, exhumation rates, and deposition rates (Bierman et al., 2002; Anderson et al., 1996).
	
In order to calculate slip rates on faults we use the age and magnitude of faults that have offset alluvial fans.  The magnitude of offset can be measured in the field using careful surveying, and the age of the offset fan surface can be determined using 10Be geochronology.  Depth profiles, rather than single surface samples, are used to determine the inherited 10Be concentration that individual clasts in the alluvial fan might have.  By sampling to a depth beyond the attenuation length of GCRs, we expect to find the concentration asymptotically approaching its initial value (zero if there is no inheritance).  
	
# Modeling approach
In this study, I compare the results of my models with real soil profile data from three surfaces: 1) the Basento fluvial terrace in Italy, 2) the Sinni fluvial terrace in Italy, and 3) the Cucumongo Canyon alluvial fan in Death Valley, USA.  My goal is to understand the behavior of 10Be concentrations with depth in order to explain the depth profiles we measure in the field (Fig. 1).
I created a simple model to simulate 10Be concentration (atoms/gram) as a function of depth and time.  The fundamental equation was first derived by Lal (1991):

> Eq. 1

	N(x,t) = N(x,0) e^(-λt)+  (P(0))/(λ+με)  e^(-μx) (1 – e^(-(λ+με)t))

	where
	N(x,t) = the concentration of 10Be as a function of depth (x) and time (t) [atoms/gram]
	N(x,0) = initial concentration of 10Be [atoms/gram]
	λ = 10Be decay constant [year -1]
	P(0) = 10Be production rate [atoms/gram/year] 
	μ = absorption coefficient = ρ/Λ [cm -1]
	ρ = density of material [g/cm3]
	Λ = characteristic attenuation length [g/cm2]
	ε = material surface erosion rate [cm/year] 

In my models, λ = 5.09^10-7 [year -1] (Nishiizumi et al., 2007), P(0) = 4.8 [atoms/gram/year] (Gosse and Phillips, 2001), ρ = 2.0 [g/cm3] (Frankel,  pers. comm., 2009), Λ = 165 [g/cm2] (Gosse and Phillips, 2001), and μ = 0.012 [cm -1].  In all applications of TCN geochronology, the latitude and elevation of a site must be taken into account, as GCRs interact strongly with the geomagnetic field and the atmosphere.  These parameters are relatively well understood and are corrected for when measuring TCN concentrations.  In my models, I assume that the site is at ~45°N latitude and 0-5km elevation above sea level, and I chose parameter values accordingly. 
I made several variations to this model to simulate different cases: 1) inheritance, 2) instantaneous erosion, 3) constant erosion, 4) instantaneous deposition, and 5) constant deposition.  In each case the fundamental equation and/or the numerical methods were altered slightly. 
	For the simple case, there is no erosion, no deposition, and no inheritance (initial concentration is zero), so Eq. 1 simplifies to:

> Eq. 2

	N(x,t) =  (P(0))/λ  e^(-μx) (1 – e^(-λt))

This equation was solved for depths of 0 to 500 cm below the surface using a for loop, which was nested inside a time for loop that solved the equation for 10 Myr in 1 Myr time steps (Appendix 1).

The inheritance case includes a term for initial concentration of 10Be; I chose an arbitrary initial concentration of 23000 [atoms/gram] (Appendix 2).  Because there is an initial concentration, the equation includes an N(x,0) term:

> Eq. 3

	N(x,t) = N(x,0) e^(-λt)+  (P(0))/λ  e^(-μx) (1 – e^(-λt))

The constant erosion case includes an erosion term, ε, and can be solved with the fundamental form of the equation (Eq. 1; Appendix 4).  The instantaneous erosion case uses Eq. 2 and is solved by adjusting the index of the vector.  An original profile can be calculated in the same way as the simple case, and these values can then be “moved” closer to the surface and “truncated” be erosion.  For example, if we take the original simple profile and remove the first 50 values in the vector, then reassign the 51st value as the 1st value, the 52nd value as the 2nd value, and so on, then we can simulate an erosion event which is removing material from the surface (Appendix 3).

For the constant deposition case, the initial concentration in the first step is zero but for all other steps the initial concentration is the solution from the previous step.  In this model I converted all the units from centimeters to millimeters and at each time step shifted all the values “down” one place (e.g. the 14th value became the 15th value) and added a zero to the top (the 1st position in the vector) (Appendix 6).  The simulated a 1 mm incremental deposition; to calculate a smaller increment I would convert all the units appropriately.  The instantaneous deposition case uses the same approach as the constant deposition, except that it moves the vector values down by the amount of burial rather than incrementally (Appendix 5).

Finally, I plotted the 10Be concentration depth profiles from two fluvial terraces in Italy (Basento and Sinni) and an alluvial fan in Death Valley, California.  I used the Curve Fitting Toolbox in Matlab to fit exponential curves to these data, and also compared the real data to the results of the models.

# Results
The results of the simple case model show the expected exponential decrease of 10Be concentration with depth (Lal, 1991; Gosse and Phillips, 2001) (Fig. 2).  Figure 2 has 10 time steps plotted together and the convergence of the curves as time progresses suggests the 10Be concentration approaches secular equilibrium (the condition in which production equals decay) after about 6 Myr.  Figure 2 also shows that even after very long exposures, the 10Be concentration falls off to zero at a depth of about 4.5 meters below the surface.  The plot of results from the inheritance case shows only one curve: the 10Be concentration at 100 kyr (Fig. 3).  The inheritance curve is simply shifted to the right by the amount of initial concentration and it asymptotically decreases to the initial concentration.
	
Results from the constant erosion case are plotted in Figures 4 and 5.  Each subplot of Figure 4 shows 10Be concentration as a function of depth for 10 time steps of 1000 years.  The subplots represent increasing erosion rates, from 0.1 mm/yr to 1.0 mm/yr in 0.1 mm/yr increments.  Figure 5 is the same as Figure 4, but with erosion rates ranging from 1.0 mm/yr to 10 mm/yr in 1.0 mm/yr increments.  At lower erosion rates, the depth profile of 10Be concentration approaches secular equilibrium relatively quickly (less than 10 kyr), and the upper limb of the curves grow steeper as the surface material is removed and the profiles are truncated (Fig. 4).  In cases where erosion is high, the depth profile of 10Be concentration reaches secular equilibrium extremely quickly (usually less than one time step) because material is being removed from the surface so fast that a well-developed depth profile does not have a chance to form (Fig. 5). 
	
The instantaneous erosion model produced two plots.  The first plot shows the original (un-eroded) profile after 100 kyr of exposure as a dashed line and the truncated profile after an erosion event instantaneously removed 50 cm of material from the surface as a red line (Fig. 6).  The second plot shows the depth profiles of 10Be concentration for 100 kyr in 10 kyr time steps, with the truncated profile as the initial conditions (Fig. 7).  The depth profiles after the erosion event are essentially the same as they would have been without an erosion event; the instantaneous erosion event acts to slow down the production of 10Be, but does not change the shape of the depth profile.  The 10Be concentration “catches up” to the pre-erosion depth profile by about 50 kyr and then continues as if no erosion event occurred.
	
For the constant deposition case model I made 8 different runs to model the 10Be concentration depth profile at 500 years, 1000 years, 2500 years, 5000 years, 10 kyr, 25 kyr, 50 kyr, and 100 kyr (Fig. 8).  The deposition rate in all cases is 1 mm/yr.  The 10Be concentration is low at the surface (because this is where the newest, least exposed material is located), increases with depth to some maximum value, then decreases exponentially with further depth.  Interestingly, the depth of maximum 10Be concentration varies in a systematic way with time.  At short exposure times, the maximum concentration is shallow.  But as exposure time increases the maximum concentration depth increases.  Further exposure time causes the depth of maximum concentration to decrease and get closer to the surface.
	
Figure 9 shows the results of the instantaneous deposition case model.  The dashed line represents the original surface (horizontal portion) and the original depth profile after 100 kyr of exposure and instantaneous burial by 50 cm of material.  The blue line is the depth profile – with initial concentration of the buried profile – 100 kyr after the deposition event.  This case creates an “upside-down Christmas tree” depth profile.  Adding another instantaneous deposition event of 50 cm followed by 100 kyr exposure creates another step in the profile (Fig. 10).
	
The Basento fluvial terrace depth profile data fits an exponential curve very well (R2 = 0.99; Fig. 11).  The Sinni fluvial terrace depth profile shows a little more scatter than Basento (especially in the shallow portion of the profile), but is also very well characterized by an exponential curve (R2 = 0.92; Fig. 11).  The Cucumongo Canyon alluvial fan depth profile data are quite a bit more scattered than the profile data from the fluvial terraces (Fig. 11).  Some portions of the Cucumongo depth profile appear to be linear, but the data are significantly correlated to an exponential curve (R2 = 0.80; Fig. 11).  
	
# Discussion & Conclusions
Interpreting 10Be concentration depth profiles requires knowledge of the conditions and history of the sample location.  In the case of the Basento and Sinni depth profiles, the samples come from unconsolidated river floodplain sediments in an area with a long history of human development and agriculture.  Fluvial terraces provide excellent conditions for farming, thus these terraces have probably undergone quite a bit of surficial disturbance due to agricultural activities.  Cucumongo Canyon alluvial fan is in Death Valley and presumably has been relatively undisturbed by humans.  The Cucumongo Canyon 10Be concentrations are also much higher than the Basento and Sinni fluvial terrace concentrations, thus the Cucumongo surface is probably older.
	
The Basento and Sinni profiles are strongly correlated to exponential curves and probably represent a simple exposure history with little or no inheritance and no deposition.  Erosion history is difficult to determine because the post-instantaneous-erosion depth profiles are essentially indistinguishable from non-erosion profiles (Fig. 7).  Constant erosion profiles may or may not shallower concentration curves (Figs. 4 & 5).
	
Assuming that the Cucumongo Canyon alluvial fan has been mostly undisturbed by humans, I hypothesize that the anomalous 10Be concentration depth profile is the result of some type of deposition on the surface.  Surface inflation is a common process in arid environments and entails the deposition of wind-blown, fine-grained particles.  Inflation tends to increase surface elevations over time.  An inflation scenario would be similar to the constant deposition case model (Fig. 8).  The Cucumongo depth profile could also be explained by a series of instantaneous deposition episodes, producing an “upside-down Christmas tree” depth profile (Figs. 9 & 10).  Alluvial fans are composed of a series of debris flow deposits that periodically issue from the mountain front.  These debris flow deposits would provide an ideal instantaneous deposition event.  However, geomorphologists tend to avoid sampling surfaces with obvious signs of activity or re-working of sediment, so instantaneous deposition might not be a feasible explanation in this case.
	
These models explicitly illustrate how 10Be concentration depth profiles behave under different erosion, deposition, and inheritance conditions.  However, a model combining inheritance, instantaneous and constant erosion, and instantaneous and constant deposition could be made that would fit nearly any depth profile shape.  Thus a model result that fits real data is not a unique solution and should not be treated as such.  The primary utility of these models is not in exactly matching curves to real data, but in providing insight into processes and behavior when interpreting real data.  
	
# References

Anderson, R.S., Repka, J.L., and Dick, G.S., 1996, Explicit treatment of inheritance in dating 
depositional surfaces using in situ (super 10) Be and (super 26) Al: Geology (Boulder), v. 24, no. 1, p. 47-51.  

Bierman, P.R., Caffee, M.W., Davis, P.T., Marsella, K., Pavich, M.J., Colgan, P., Mickelson, D.M., and Larsen, J., 2002, Rates and timing of Earth surface processes from in situ-produced cosmogenic Be-10: Reviews in Mineralogy and Geochemistry, v. 50, p. 147-205.  

Gosse, J.C., and Phillips, F.M., 2001, Terrestrial in situ cosmogenic nuclides; theory and application: Quaternary Science Reviews, v. 20, no. 14, p. 1475-1560.

Lal, D., 1991, Cosmic ray labeling of erosion surfaces; in situ nuclide production rates and erosion models: Earth and Planetary Science Letters, v. 104, no. 2-4, p. 424-439.  

Nishiizumi, K., Winterer, E.L., Kohl, C.P., Klein, J., Middleton, R., Lal, D., and Arnold, J.R., 1989, Cosmic ray production rates of (super 10) Be and (super 26) Al in quartz from glacially polished rocks: Journal of Geophysical Research, v. 94, no. B12, p. 17,907-17,915.  

Nishiizumi, K., Imamura, M., Caffee, M.W., Southon, J.R., Finkel, R.C., and McAninch, J., 2007, Absolute calibration of 10Be AMS standards: Nuclear Instruments and Methods in Physics Research Section B: Beam Interactions with Materials and Atoms, v. 258, no. 2, p. 403-413.  
