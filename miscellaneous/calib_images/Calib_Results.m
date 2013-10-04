% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 704.187002128649970 ; 706.828641798925330 ];

%-- Principal point:
cc = [ 319.165146241272850 ; 198.128770424052250 ];

%-- Skew coefficient:
alpha_c = 0.001853509136364;

%-- Distortion coefficients:
kc = [ 0.187884984418104 ; -0.686161697418254 ; -0.001244871664500 ; 0.001163900726828 ; -0.263247290048780 ];

%-- Focal length uncertainty:
fc_error = [ 4.496039524311616 ; 4.320955001011965 ];

%-- Principal point uncertainty:
cc_error = [ 7.448353660876268 ; 6.700651379721490 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.001591260067692;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.065416929053530 ; 1.056964028047412 ; 0.004585471367047 ; 0.004967931716244 ; 4.863374066618040 ];

%-- Image size:
nx = 640;
ny = 360;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 9;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 1;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 1 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.202729e+000 ; 2.153865e+000 ; -1.414851e-001 ];
Tc_1  = [ -1.053424e+002 ; -8.406327e+001 ; 5.403861e+002 ];
omc_error_1 = [ 7.249490e-003 ; 8.214548e-003 ; 1.697112e-002 ];
Tc_error_1  = [ 5.715114e+000 ; 5.136950e+000 ; 3.691452e+000 ];

%-- Image #2:
omc_2 = [ 1.981631e+000 ; 1.753411e+000 ; 2.988341e-001 ];
Tc_2  = [ -1.019404e+002 ; -8.036986e+001 ; 5.153385e+002 ];
omc_error_2 = [ 8.430241e-003 ; 7.168927e-003 ; 1.384820e-002 ];
Tc_error_2  = [ 5.470327e+000 ; 4.911507e+000 ; 3.634242e+000 ];

%-- Image #3:
omc_3 = [ -2.054453e+000 ; -1.679429e+000 ; 6.117526e-001 ];
Tc_3  = [ -8.343837e+001 ; -5.080745e+001 ; 6.522620e+002 ];
omc_error_3 = [ 9.253642e-003 ; 6.809009e-003 ; 1.382400e-002 ];
Tc_error_3  = [ 6.861654e+000 ; 6.179749e+000 ; 3.745753e+000 ];

%-- Image #4:
omc_4 = [ 1.773260e+000 ; 1.641915e+000 ; -7.405471e-001 ];
Tc_4  = [ -9.261326e+001 ; -2.903047e+001 ; 5.764443e+002 ];
omc_error_4 = [ 6.602337e-003 ; 8.829432e-003 ; 1.216850e-002 ];
Tc_error_4  = [ 6.077059e+000 ; 5.459742e+000 ; 3.485195e+000 ];

%-- Image #5:
omc_5 = [ -2.026647e+000 ; -2.011825e+000 ; -7.735478e-001 ];
Tc_5  = [ -1.982516e+002 ; -7.727093e+001 ; 5.490061e+002 ];
omc_error_5 = [ 7.565499e-003 ; 8.871080e-003 ; 1.648657e-002 ];
Tc_error_5  = [ 5.795781e+000 ; 5.425345e+000 ; 4.846732e+000 ];

%-- Image #6:
omc_6 = [ -2.385303e+000 ; -1.343375e+000 ; 1.110856e+000 ];
Tc_6  = [ -2.581296e+001 ; -2.318671e+001 ; 7.441474e+002 ];
omc_error_6 = [ 1.128860e-002 ; 4.558154e-003 ; 1.421537e-002 ];
Tc_error_6  = [ 7.865622e+000 ; 7.023168e+000 ; 4.248855e+000 ];

%-- Image #7:
omc_7 = [ 1.131395e+000 ; 2.078474e+000 ; 1.022754e-001 ];
Tc_7  = [ -4.835018e+001 ; -1.116571e+002 ; 5.835520e+002 ];
omc_error_7 = [ 6.558712e-003 ; 9.455441e-003 ; 1.188826e-002 ];
Tc_error_7  = [ 6.148386e+000 ; 5.536873e+000 ; 3.948042e+000 ];

%-- Image #8:
omc_8 = [ -1.564353e+000 ; -1.715903e+000 ; 4.198995e-001 ];
Tc_8  = [ 1.629148e+001 ; -1.053303e+002 ; 7.114150e+002 ];
omc_error_8 = [ 7.744628e-003 ; 8.678333e-003 ; 1.170446e-002 ];
Tc_error_8  = [ 7.497134e+000 ; 6.734508e+000 ; 4.528380e+000 ];

%-- Image #9:
omc_9 = [ 2.224106e+000 ; 1.420494e+000 ; 1.052858e+000 ];
Tc_9  = [ -1.265513e+002 ; -3.395129e+001 ; 5.073553e+002 ];
omc_error_9 = [ 1.097623e-002 ; 4.883118e-003 ; 1.412934e-002 ];
Tc_error_9  = [ 5.409814e+000 ; 4.878115e+000 ; 3.911681e+000 ];

