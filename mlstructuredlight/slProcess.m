
% SLPROCESS Implements "Structured Lighting" post-processing.
%    SLPROCESS implements an inexpensive 3D photography system
%    using binary and Gray-coded structured lighting.
%
%    This script can be used to reconstruct captured sequences 
%    generated by our reference implementation. Please read the 
%    SIGGRAPH 2009 course notes for additional details.
%
%       D. Lanman and G. Taubin, "Build Your Own 3D Scanner: 3D 
%       Photography for Beginners", ACM SIGGRAPH 2009 Course 
%       Notes, 2009.
%
% Douglas Lanman and Gabriel Taubin 
% Brown University
% 18 May 2009

% Add required subdirectories.
addpath('./utilities');

% Reset Matlab environment.
clear; clc;

% Set structured lighting parameters.
objName      = 'man';   % object name (should correspond to a data dir.)
seqName      = 'v1';    % sequence name (subdirectory of object)
seqType      = 'Gray';  % structured light sequence type ('Gray' or 'bin')
dSampleProj  = 1;       % downsampling factor (i.e., min. system resolution)
projValue    = 255;     % Gray code intensity
minContrast  = 0.2;     % minimum contrast threshold (for Gray code pattern)

% Set reconstruction parameters.
dSamplePlot = 100;      % down-sampling rate for Matlab point cloud display
distReject  = Inf;      % rejection distance (for outlier removal)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part I: Project Grey code sequence to recover illumination plane(s).

% Load calibration data.
load('./calib/calib_results/calib_cam_proj.mat');
  
% Display prompt to begin scanning.
clc; disp('[Reconstruction of Structured Light Sequences]');

% Determine number of cameras and image resolution(s).
disp('+ Extracting data set properties...');
D = dir(['./data/',seqType,'/',objName]);
nCam = nnz([D.isdir])-2;
nBitPlanes = cell(1,nCam);
camDim = cell(1,nCam);
for camIdx = 1:nCam
   dataDir = ['./data/',seqType,'/',objName,'/v',int2str(camIdx),'/'];
   nBitPlanes{camIdx} = ((length(dir(dataDir))-2)-2)/4;
   I = imread([dataDir,'01.bmp']);
   camDim{camIdx} = [size(I,1) size(I,2)];
end
width = camDim{1}(2);
height = camDim{1}(1);

% Generate vertical and horizontal Gray code stripe patterns.
% Note: P{j} contains the Gray code patterns for "orientation" j.
%       offset(j) is the integer column/row offset for P{j}.
%       I{j,i} are the OpenGL textures corresponding to bit i of P{j}.
%       J{j,i} are the OpenGL textures of the inverse of I{j,i}.
disp('+ Regenerating structured light sequence...');
if strcmp(seqType,'Gray')
   [P,offset] = graycode(1024/dSampleProj,768/dSampleProj);
else
   [P,offset] = bincode(1024/dSampleProj,768/dSampleProj);
end

% Load captured structured lighting sequences.
disp('+ Loading data set...');
for camIdx = 1:nCam
   dataDir = ['./data/',seqType,'/',objName,'/v',int2str(camIdx),'/'];
   if ~exist(dataDir,'dir')
      error(['Sequence ',objName,'_',seqName,'_',seqType,' is not available!']);
   end
   T{1}{camIdx} = imread([dataDir,num2str(1,'%0.02d'),'.bmp']);
   T{2}{camIdx} = imread([dataDir,num2str(2,'%0.02d'),'.bmp']);
   frameIdx = 3;
   for j = 1:2
      for i = 1:nBitPlanes{camIdx}
         A{j,i}{camIdx} = imread([dataDir,num2str(frameIdx,'%0.02d'),'.bmp']);
         frameIdx = frameIdx + 1;
         B{j,i}{camIdx} = imread([dataDir,num2str(frameIdx,'%0.02d'),'.bmp']);
         frameIdx = frameIdx + 1;
      end
   end
end

% Estimate column/row label for each pixel (i.e., decode Gray codes).
% Note: G{j,k} is the estimated Gray code for "orientation" j and camera k.
%       D{j,k} is the integer column/row estimate.
%       M{j,k} is the per-pixel mask (i.e., pixels with enough contrast).
disp('+ Recovering projector rows/columns from structured light sequence...');
G = cell(size(A,1),nCam);
D = cell(size(A,1),nCam);
M = cell(size(A,1),nCam);
C = inv([1.0 0.956 0.621; 1.0 -0.272 -0.647; 1.0 -1.106 1.703]);
C = C(1,:)';
for k = 1:nCam
   for j = 1:size(A,1)
      G{j,k} = zeros(size(T{1}{1},1),size(T{1}{1},2),size(A,2),'uint8');
      M{j,k} = false(size(T{1}{1},1),size(T{1}{1},2));
      for i = 1:size(A,2)
      
         % Convert image pair to grayscale.
         %grayA = rgb2gray(im2double(A{j,i}{k}));
         %grayB = rgb2gray(im2double(B{j,i}{k}));
         grayA = imlincomb(C(1),A{j,i}{k}(:,:,1),...
                           C(2),A{j,i}{k}(:,:,2),...
                           C(3),A{j,i}{k}(:,:,3),'double');
         grayB = imlincomb(C(1),B{j,i}{k}(:,:,1),...
                           C(2),B{j,i}{k}(:,:,2),...
                           C(3),B{j,i}{k}(:,:,3),'double');
         
         % Eliminate all pixels that do not exceed contrast threshold.
         M{j,k}(abs(grayA-grayB) > 255*minContrast) = true;
         
         % Estimate current bit of Gray code from image pair.        
         bitPlane = zeros(size(T{1}{1},1),size(T{1}{1},2),'uint8');
         bitPlane(grayA(:,:) >= grayB(:,:)) = 1;
         G{j,k}(:,:,i) = bitPlane;
         
      end
      if strcmp(seqType,'Gray')
         D{j,k} = gray2dec(G{j,k})-offset(j);
      else
         D{j,k} = bin2dec(G{j,k})-offset(j);
      end
      D{j,k}(~M{j,k}) = NaN;
   end
end
%clear A B G grayA grayB bitPlane;

% Eliminate invalid column/row estimates.
% Note: This will exclude pixels if either the column or row is missing.
%       D{j,k} is the column/row for "orientation" j and camera k.
%       mask{k} is the overal per-pixel mask for camera k.
mask = cell(1,nCam);
for k = 1:nCam
   mask{k} = M{1,k};
   for j = 1:size(D,1)
      if j == 1
         D{j,k}(D{j,k} > width) = NaN;
      else
         D{j,k}(D{j,k} > height) = NaN;
      end
      D{j,k}(D{j,k} < 1) = NaN;
      for i = 1:size(D,1)
         D{j,k}(~M{i,k}) = NaN;
         mask{k} =  mask{k} & M{i,k};
      end
   end
end

% Display recovered projector column/row.
figure(1); clf;
imagesc(D{1,1}); axis image; colormap(jet(256));
title('Recovered Projector Column Indices'); drawnow;
figure(2); clf;
imagesc(D{2,1}); axis image; colormap(jet(256));
title('Recovered Projector Row Indices'); drawnow;
figure(3); clf;
imagesc(T{1}{1}); axis image; colormap(jet(256));
title('Reference Image for Texture Mapping'); drawnow;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part II: Reconstruct surface using line-plane intersection.

% Reconstruct 3D points using intersection with illumination plane(s).
% Note: Reconstructs from all cameras in the first camera coordinate system.
vertices = cell(1,length(Nc));
colors   = cell(1,length(Nc));
disp('+ Reconstructing 3D points...');
for i = 1:length(Nc)
   idx       = find(~isnan(D{1,i}) & ~isnan(D{2,i}));
   [row,col] = ind2sub(size(D{1,i}),idx);
   npts      = length(idx);
   colors{i} = 0.65*ones(npts,3);
   Rc        = im2double(T{1}{i}(:,:,1));
   Gc        = im2double(T{1}{i}(:,:,2));
   Bc        = im2double(T{1}{i}(:,:,3));
   vV = intersectLineWithPlane(repmat(Oc{i},1,npts),Nc{i}(:,idx),wPlaneCol(D{1,i}(idx),:)');
   vH = intersectLineWithPlane(repmat(Oc{i},1,npts),Nc{i}(:,idx),wPlaneRow(D{2,i}(idx),:)');
   vertices{i} = vV';
   rejectIdx = find(sqrt(sum((vV-vH).^2)) > distReject);
   vertices{i}(rejectIdx,1) = NaN;
   vertices{i}(rejectIdx,2) = NaN;
   vertices{i}(rejectIdx,3) = NaN;
   colors{i}(:,1) = Rc(idx);
   colors{i}(:,2) = Gc(idx);
   colors{i}(:,3) = Bc(idx);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part III: Display reconstruction results and export VRML model.

% Display status.
disp('+ Displaying results and exporting VRML model...');

% Display project/camera calibration results.
procamCalibDisplay;

% Display the recovered 3D point cloud (with per-vertex color).
% Note: Convert to indexed color map for use with FSCATTER3.
for i = 1:length(Nc)
   C = reshape(colors{i},[size(colors{i},1) 1 size(colors{i},2)]);
   [C,cmap] = rgb2ind(C,256);
   hold on;
      fscatter3(vertices{i}(1:dSamplePlot:end,1),...
                vertices{i}(1:dSamplePlot:end,3),...
               -vertices{i}(1:dSamplePlot:end,2),...
                double(C(1:dSamplePlot:end)),cmap);
   hold off;
   axis tight; drawnow;
end

% Export colored point cloud as a VRML file.
% Note: Interchange x and y coordinates for j3DPGP.
clear idx; mergedVertices = []; mergedColors = [];
for i = 1:length(Nc)
   idx{i} = find(~isnan(vertices{i}(:,1)));
   vertices{i}(:,2) = -vertices{i}(:,2);
   vrmlPoints(['./data/',seqType,'/',objName,'/v',int2str(i),'.wrl'],...
      vertices{i}(idx{i},[1 2 3]),colors{i}(idx{i},:));
   mergedVertices = [mergedVertices; vertices{i}(idx{i},[1 2 3])];
   mergedColors = [mergedColors; colors{i}(idx{i},:)];
end
if length(Nc) > 1
   vrmlPoints(['./data/',seqType,'/',objName,'/merged.wrl'],...
      mergedVertices,mergedColors);
end
disp(' ');
