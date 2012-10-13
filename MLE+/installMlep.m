function installMlep()
%% MLEP PATH
mlepFolder = mfilename('fullpath');
% Remove 
indexHome = strfind(mlepFolder, ['installMlep']);
mlepFolder = mlepFolder(1:indexHome-1);
cd(mlepFolder);

%% Folders
EplusFolder = 'EnergyPlus-7-1-0';
JavaFolder = 'Java';
BcvtbFolder = 'bcvtb';

%% VERSION PATH
addpath([pwd filesep 'gui' filesep 'version']);

%% MLEP CORE/GUI PATH
addpath([pwd filesep 'core' filesep]);
addpath([pwd filesep 'gui' filesep]);
addpath(pwd);

%% STRUCTDLG
addpath([pwd filesep 'gui' filesep 'structdlg']);

%% DXF PATH
addpath([pwd filesep 'gui' filesep 'model3d']);

%% BACNET PATH
addpath([pwd filesep 'bacnet-tools-0.7.1']);

%% GUILAYOUT PATH
run(['GUILayout-v1p10' filesep 'install']);

%% INSTALLATION DIALOG
% CREATE FIGURE

if ispc
    [install myhandle] = pcInstall(mlepFolder);
else
    [install myhandle] = unixInstall(mlepFolder);
end

guidata(myhandle,install);




%% SAVEPATH
savepath;
end