% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 704.556396101106540 ; 707.189550897599020 ];

%-- Principal point:
cc = [ 317.198962560724570 ; 197.823440840378250 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.191440098675335 ; -0.726475970023690 ; -0.001502168664816 ; 0.000259266600716 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 4.504976954068057 ; 4.341036054505900 ];

%-- Principal point uncertainty:
cc_error = [ 7.229659840777476 ; 6.763468397158132 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.033668450562730 ; 0.241183026632263 ; 0.004645206269606 ; 0.004900958143444 ; 0.000000000000000 ];

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
omc_1 = [ 2.203000e+000 ; 2.152782e+000 ; -1.388414e-001 ];
Tc_1  = [ -1.039175e+002 ; -8.378207e+001 ; 5.405840e+002 ];
omc_error_1 = [ 7.341113e-003 ; 8.218557e-003 ; 1.685035e-002 ];
Tc_error_1  = [ 5.563523e+000 ; 5.179467e+000 ; 3.688579e+000 ];

%-- Image #2:
omc_2 = [ 1.981278e+000 ; 1.752115e+000 ; 2.942351e-001 ];
Tc_2  = [ -1.005648e+002 ; -8.009996e+001 ; 5.155838e+002 ];
omc_error_2 = [ 8.472426e-003 ; 7.073281e-003 ; 1.325692e-002 ];
Tc_error_2  = [ 5.324509e+000 ; 4.952042e+000 ; 3.631897e+000 ];

%-- Image #3:
omc_3 = [ -2.052458e+000 ; -1.675663e+000 ; 6.117369e-001 ];
Tc_3  = [ -8.171228e+001 ; -5.050325e+001 ; 6.527154e+002 ];
omc_error_3 = [ 9.122630e-003 ; 5.986261e-003 ; 1.387788e-002 ];
Tc_error_3  = [ 6.679707e+000 ; 6.235199e+000 ; 3.735451e+000 ];

%-- Image #4:
omc_4 = [ 1.772864e+000 ; 1.642385e+000 ; -7.419390e-001 ];
Tc_4  = [ -9.105636e+001 ; -2.878028e+001 ; 5.768608e+002 ];
omc_error_4 = [ 6.684944e-003 ; 8.848350e-003 ; 1.208689e-002 ];
Tc_error_4  = [ 5.909024e+000 ; 5.508964e+000 ; 3.472185e+000 ];

%-- Image #5:
omc_5 = [ -2.027583e+000 ; -2.009685e+000 ; -7.657688e-001 ];
Tc_5  = [ -1.969898e+002 ; -7.707347e+001 ; 5.504359e+002 ];
omc_error_5 = [ 7.556115e-003 ; 8.715677e-003 ; 1.504509e-002 ];
Tc_error_5  = [ 5.690039e+000 ; 5.480064e+000 ; 4.713961e+000 ];

%-- Image #6:
omc_6 = [ -2.383274e+000 ; -1.340621e+000 ; 1.111190e+000 ];
Tc_6  = [ -2.380010e+001 ; -2.286634e+001 ; 7.450645e+002 ];
omc_error_6 = [ 1.118353e-002 ; 3.904091e-003 ; 1.425187e-002 ];
Tc_error_6  = [ 7.654848e+000 ; 7.093100e+000 ; 4.200224e+000 ];

%-- Image #7:
omc_7 = [ 1.132290e+000 ; 2.078979e+000 ; 9.824281e-002 ];
Tc_7  = [ -4.689815e+001 ; -1.113416e+002 ; 5.838138e+002 ];
omc_error_7 = [ 6.579233e-003 ; 9.436244e-003 ; 1.141072e-002 ];
Tc_error_7  = [ 6.001795e+000 ; 5.584357e+000 ; 3.945370e+000 ];

%-- Image #8:
omc_8 = [ -1.563209e+000 ; -1.711666e+000 ; 4.202992e-001 ];
Tc_8  = [ 1.807244e+001 ; -1.049580e+002 ; 7.114839e+002 ];
omc_error_8 = [ 7.703998e-003 ; 7.851832e-003 ; 1.175343e-002 ];
Tc_error_8  = [ 7.312212e+000 ; 6.793048e+000 ; 4.536818e+000 ];

%-- Image #9:
omc_9 = [ 2.226073e+000 ; 1.419903e+000 ; 1.046988e+000 ];
Tc_9  = [ -1.252460e+002 ; -3.374958e+001 ; 5.082104e+002 ];
omc_error_9 = [ 1.085662e-002 ; 4.864363e-003 ; 1.322911e-002 ];
Tc_error_9  = [ 5.280799e+000 ; 4.925833e+000 ; 3.856402e+000 ];

