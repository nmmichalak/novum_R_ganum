* load data

GET
  FILE='/Users/nicholasmichalak/Desktop/novum_R_ganum/dummy_cont_data.sav'.
DATASET NAME dummy_cont_data WINDOW=FRONT.

* plot

GRAPH
   /BAR = MEAN(y) BY cont1 * cont2
   /INTERVAL  CI(95).

* dummy code model with marginal mean estimates

GLM y WITH dummy1 dummy2
   /INTERCEPT = INCLUDE
   /DESIGN = dummy1 dummy2 dummy1*dummy2
   /LMATRIX = INTERCEPT 1 dummy1 0 dummy2 0 dummy1*dummy2 0
   /LMATRIX = INTERCEPT 1 dummy1 0 dummy2 1 dummy1*dummy2 0
   /LMATRIX = INTERCEPT 1 dummy1 1 dummy2 0 dummy1*dummy2 0
   /LMATRIX = INTERCEPT 1 dummy1 1 dummy2 1 dummy1*dummy2 1.

* contrast code model with marginal mean estimates

GLM y WITH cont1 cont2
   /INTERCEPT = INCLUDE
   /DESIGN = cont1 cont2 cont1*cont2
   /LMATRIX = INTERCEPT 1 cont1 -0.5 cont2 -0.5 cont1*cont2 0.25
   /LMATRIX = INTERCEPT 1 cont1 0.5 cont2 -0.5 cont1*cont2 -0.25
   /LMATRIX = INTERCEPT 1 cont1 0.5 cont2 -0.5 cont1*cont2 -0.25
   /LMATRIX = INTERCEPT 1 cont1 0.5 cont2 0.5 cont1*cont2 -0.25.
