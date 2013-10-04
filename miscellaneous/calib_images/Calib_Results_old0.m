% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 704.534064954247700 ; 707.195186691710890 ];

%-- Principal point:
cc = [ 317.007441189189930 ; 198.111241832285090 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.194583845876265 ; -0.748105715753439 ; -0.001250408284653 ; 0.000083044945442 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 4.517921772372696 ; 4.353427607185807 ];

%-- Principal point uncertainty:
cc_error = [ 7.183150541014250 ; 6.765964215438516 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.033818603796767 ; 0.243276969138356 ; 0.004659730517109 ; 0.004881409739238 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 360;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 9;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.203304e+000 ; 2.153136e+000 ; -1.389156e-001 ];
Tc_1  = [ -1.037684e+002 ; -8.400348e+001 ; 5.406205e+002 ];
omc_error_1 = [ 7.342243e-003 ; 8.210358e-003 ; 1.683110e-002 ];
Tc_error_1  = [ 5.528070e+000 ; 5.181090e+000 ; 3.697500e+000 ];

%-- Image #2:
omc_2 = [ 1.981706e+000 ; 1.752384e+000 ; 2.942974e-001 ];
Tc_2  = [ -1.004254e+002 ; -8.031163e+001 ; 5.156196e+002 ];
omc_error_2 = [ 8.467764e-003 ; 7.047746e-003 ; 1.322247e-002 ];
Tc_error_2  = [ 5.290887e+000 ; 4.953664e+000 ; 3.640480e+000 ];

%-- Image #3:
omc_3 = [ -2.052048e+000 ; -1.675529e+000 ; 6.115367e-001 ];
Tc_3  = [ -8.153770e+001 ; -5.076965e+001 ; 6.527478e+002 ];
omc_error_3 = [ 9.082011e-003 ; 5.948231e-003 ; 1.385817e-002 ];
Tc_error_3  = [ 6.637431e+000 ; 6.237225e+000 ; 3.745445e+000 ];

%-- Image #4:
omc_4 = [ 1.773064e+000 ; 1.642781e+000 ; -7.420015e-001 ];
Tc_4  = [ -9.090319e+001 ; -2.901483e+001 ; 5.768973e+002 ];
omc_error_4 = [ 6.690098e-003 ; 8.817928e-003 ; 1.204716e-002 ];
Tc_error_4  = [ 5.871374e+000 ; 5.510619e+000 ; 3.481336e+000 ];

%-- Image #5:
omc_5 = [ -2.027735e+000 ; -2.009583e+000 ; -7.652796e-001 ];
Tc_5  = [ -1.968686e+002 ; -7.732291e+001 ; 5.506017e+002 ];
omc_error_5 = [ 7.565299e-003 ; 8.695585e-003 ; 1.497999e-002 ];
Tc_error_5  = [ 5.656577e+000 ; 5.482758e+000 ; 4.719502e+000 ];

%-- Image #6:
omc_6 = [ -2.382804e+000 ; -1.340641e+000 ; 1.111095e+000 ];
Tc_6  = [ -2.359732e+001 ; -2.316857e+001 ; 7.450968e+002 ];
omc_error_6 = [ 1.113989e-002 ; 3.896111e-003 ; 1.422396e-002 ];
Tc_error_6  = [ 7.606746e+000 ; 7.095725e+000 ; 4.214087e+000 ];

%-- Image #7:
omc_7 = [ 1.132625e+000 ; 2.079324e+000 ; 9.847942e-002 ];
Tc_7  = [ -4.673963e+001 ; -1.115802e+002 ; 5.838221e+002 ];
omc_error_7 = [ 6.575081e-003 ; 9.389928e-003 ; 1.140278e-002 ];
Tc_error_7  = [ 5.964029e+000 ; 5.586250e+000 ; 3.957561e+000 ];

%-- Image #8:
omc_8 = [ -1.562857e+000 ; -1.711475e+000 ; 4.201068e-001 ];
Tc_8  = [ 1.826888e+001 ; -1.052488e+002 ; 7.114959e+002 ];
omc_error_8 = [ 7.677212e-003 ; 7.797404e-003 ; 1.174243e-002 ];
Tc_error_8  = [ 7.266033e+000 ; 6.795863e+000 ; 4.551312e+000 ];

%-- Image #9:
omc_9 = [ 2.226578e+000 ; 1.419950e+000 ; 1.047085e+000 ];
Tc_9  = [ -1.251091e+002 ; -3.396095e+001 ; 5.082809e+002 ];
omc_error_9 = [ 1.081823e-002 ; 4.846883e-003 ; 1.319616e-002 ];
Tc_error_9  = [ 5.248272e+000 ; 4.927292e+000 ; 3.864871e+000 ];

