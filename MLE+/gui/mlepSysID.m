function [mlep] = mlepSysID(myhandle)
% Retrieve data
mlep = guidata(myhandle);

mlep.sysIDTab = uitab('parent',mlep.guiTab); % ,'title','2. System ID'
%set(mlep.guiTab,'SelectedTab',mlep.sysIDTab); 
mlep.sysIDPanel = uiextras.Panel( 'Parent', mlep.sysIDTab, 'BorderType', 'none', 'Padding', 15 );
    mlep.sysIDBox = uiextras.VBox( 'Parent', mlep.sysIDPanel, 'Padding', 0, 'Spacing', 15  );
        % INPUT/OUTPUT BOX
        mlep.sysIDVarPanel = uiextras.Panel('Parent', mlep.sysIDBox, 'Padding', 0, 'BorderType', 'none', 'BorderWidth', 1 ); % , 'Title', 'INPUT/OUTPUT AVAILABLE' etchedin etchedout beveledin beveledout line  
        mlep.sysIDVar = uiextras.HBox( 'Parent', mlep.sysIDVarPanel, 'Padding', 0, 'Spacing', 15 );
            % INPUT BOX
            mlep.sysIDVarInPanel = uiextras.Panel('Parent', mlep.sysIDVar, 'Padding', 10, 'BorderType', 'etchedin', 'BorderWidth', 1, 'Title', 'Input', 'ForegroundColor', 'b', 'FontSize', mlep.fontMedium);
            mlep.sysIDVarIn = uiextras.HBox( 'Parent', mlep.sysIDVarInPanel, 'Padding', 10, 'Spacing', 0 );
                mlep.sysIDInListbox = uicontrol( 'style', 'listbox', 'Parent', mlep.sysIDVarIn, 'Callback', {@mlepSysIDFunction,myhandle,'getInputIndex'}, 'FontSize', mlep.fontSmall  );
                uiextras.Empty( 'Parent', mlep.sysIDVarIn );
                mlep.sysIDInComment = uicontrol( 'style', 'edit', 'Parent', mlep.sysIDVarIn, 'Background', 'white', 'HorizontalAlignment', 'left', 'Callback', {@mlepSysIDFunction,myhandle,'editInputComment'}, 'FontSize', mlep.fontSmall  );
            set(mlep.sysIDVarIn, 'Sizes', [-3 -1 -3]);
            % OUTPUT BOX
            mlep.sysIDVarOutPanel = uiextras.Panel('Parent', mlep.sysIDVar, 'Padding', 10, 'BorderType', 'etchedin', 'BorderWidth', 1, 'Title', 'Output', 'ForegroundColor', 'r', 'FontSize', mlep.fontMedium ); % , 'ShadowColor', 'r'  
            mlep.sysIDVarOut = uiextras.HBox( 'Parent', mlep.sysIDVarOutPanel, 'Padding', 10, 'Spacing', 0 );
                mlep.sysIDOutListbox = uicontrol( 'style', 'listbox', 'Parent', mlep.sysIDVarOut, 'Callback', {@mlepSysIDFunction,myhandle,'getOutputIndex'}, 'FontSize', mlep.fontSmall );
                uiextras.Empty( 'Parent', mlep.sysIDVarOut );
                mlep.sysIDOutComment = uicontrol( 'style', 'edit', 'Parent', mlep.sysIDVarOut, 'Background', 'white', 'HorizontalAlignment', 'left', 'Callback', {@mlepSysIDFunction,myhandle,'editOutputComment'}, 'FontSize', mlep.fontSmall  );
            set(mlep.sysIDVarOut, 'Sizes', [-3 -1 -3]);
        % SYSID PANEL (SELECT VARIABLES and SYSID INPUTS)
        mlep.sysIDFeedbackPanel = uiextras.Panel('Parent', mlep.sysIDBox, 'Padding', 0, 'BorderType', 'none', 'BorderWidth', 0); % , 'Title', 'FEEDBACK' etchedin etchedout beveledin beveledout line  
            mlep.sysIDFeedbackBox = uiextras.HBox( 'Parent', mlep.sysIDFeedbackPanel, 'Padding', 0, 'Spacing', 20 );
                mlep.sysIDFeedbackLeft = uiextras.Panel('Parent', mlep.sysIDFeedbackBox, 'Padding', 0, 'BorderType', 'etchedin', 'BorderWidth', 1, 'Title', 'Configuration', 'FontSize', mlep.fontMedium );
                    mlep.sysIDLoadVariablesBox = uiextras.VButtonBox( 'Parent', mlep.sysIDFeedbackLeft, 'Spacing', 20, 'Padding', 20, 'ButtonSize', [200 50]); %, 
                        uicontrol( 'style', 'push', 'String', 'Variables', 'Parent', mlep.sysIDLoadVariablesBox, 'Callback', {@mlepSysIDFunction,myhandle,'loadVariables'}, 'FontSize', mlep.fontSmall );
                        uicontrol( 'style', 'push', 'String', 'Open EnergyPlus File', 'Parent', mlep.sysIDLoadVariablesBox, 'Callback', {@mlepSysIDFunction,myhandle,'openIdf'}, 'FontSize', mlep.fontSmall );
                        uicontrol( 'style', 'push', 'String', 'NOT AVAILABLE', 'Parent', mlep.sysIDLoadVariablesBox, 'Callback', {@mlepSysIDFunction,myhandle,'loadVariables'}, 'FontSize', mlep.fontSmall );
                        uicontrol( 'style', 'push', 'String', 'NOT AVAILABLE', 'Parent', mlep.sysIDLoadVariablesBox, 'Callback', {@mlepSysIDFunction,myhandle,'loadVariables'}, 'FontSize', mlep.fontSmall );

                mlep.sysIDFeedbackRight = uiextras.Panel('Parent', mlep.sysIDFeedbackBox, 'Padding', 10, 'BorderType', 'etchedin', 'BorderWidth', 1, 'Title', 'System Identification', 'FontSize', mlep.fontMedium ); 
                    % TAB 
                    mlep.sysIDFeedbackTab = uiextras.TabPanel( 'Parent', mlep.sysIDFeedbackRight, 'Padding', 5, 'TabSize', 150, 'FontSize', mlep.fontMedium   );
                    % Tab 1
                    mlep.sysIDFeedbackPanel1 = uiextras.Panel( 'Parent', mlep.sysIDFeedbackTab, 'BorderType', 'none' );
                        mlep.sysIDFeedback1Box = uiextras.HBox( 'Parent', mlep.sysIDFeedbackPanel1, 'Padding', 5, 'Spacing', 5 );
                            mlep.sysIDFeedback1BoxVBox = uiextras.VBox( 'Parent', mlep.sysIDFeedback1Box, 'Padding', 5, 'Spacing', 5 );
                                uicontrol( 'style', 'text', 'Parent', mlep.sysIDFeedback1BoxVBox, 'String', 'Input to EnergyPlus', 'FontSize', mlep.fontMedium );
                                mlep.sysIDInListboxID = uicontrol( 'style', 'listbox', 'Parent', mlep.sysIDFeedback1BoxVBox, 'Callback', {@mlepSysIDFunction,myhandle,'getInputIndexID'}, 'Background', mlep.colorWhite );
                                uicontrol( 'style', 'push', 'String', 'SYS ID','Parent', mlep.sysIDFeedback1BoxVBox, 'Callback', {@mlepSysIDFunction,myhandle,'sysID'} );
                            set(mlep.sysIDFeedback1BoxVBox,'Sizes',[-0.6 -5 -1]);    
                            mlep.sysID1HBox = uiextras.HBox( 'Parent', mlep.sysIDFeedback1Box, 'Padding', 5, 'Spacing', 5 );
                                mlep.sysIDParmeterPanel = uiextras.Panel( 'Parent', mlep.sysID1HBox, 'BorderType', 'etchedin', 'BorderWidth', 1, 'Title', 'Parameters IDINPUT', 'FontSize', mlep.fontMedium  );
                                mlep.sysID1HBoxVBox = uiextras.VBox( 'Parent', mlep.sysIDParmeterPanel, 'Padding', 5, 'Spacing', 5 );
                                    mlep.sysIDConrolStep = uiextras.HButtonBox( 'Parent', mlep.sysID1HBoxVBox, 'Padding', 5, 'Spacing', 5, 'ButtonSize', [200 50] );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDConrolStep, 'String', {'Control Step'}, 'FontSize', mlep.fontSmall );
                                        mlep.sysIDeditConrolStep = uicontrol( 'style', 'edit', 'Parent', mlep.sysIDConrolStep, 'Callback', {@mlepSysIDFunction,myhandle,'getConrolStep'}, 'Background', mlep.colorWhite );
                                    mlep.sysIDtype = uiextras.HBox( 'Parent', mlep.sysID1HBoxVBox, 'Padding', 5, 'Spacing', 5 );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDtype, 'String', {'Type'}, 'FontSize', mlep.fontSmall );
                                        mlep.sysIDpopupmenu = {'rgs';'rbs';'prbs';'sine'};
                                        mlep.sysIDpopupType = uicontrol( 'style', 'popupmenu', 'Parent', mlep.sysIDtype, 'Callback', {@mlepSysIDFunction,myhandle,'getType'}, 'String', mlep.sysIDpopupmenu, 'FontSize', mlep.fontMedium, 'Background', mlep.colorWhite  );
                                    mlep.sysIDband = uiextras.HBox( 'Parent', mlep.sysID1HBoxVBox, 'Padding', 5, 'Spacing', 5 );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDband, 'String', {'Band ='}, 'FontSize', mlep.fontSmall  );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDband, 'String', {'wlow'}, 'FontSize', mlep.fontSmall  );
                                        mlep.sysIDeditWlow = uicontrol( 'style', 'edit', 'Parent', mlep.sysIDband, 'Callback', {@mlepSysIDFunction,myhandle,'getWlow'}, 'Background', mlep.colorWhite );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDband, 'String', {'whigh'}, 'FontSize', mlep.fontSmall  );
                                        mlep.sysIDeditWhigh = uicontrol( 'style', 'edit', 'Parent', mlep.sysIDband, 'Callback', {@mlepSysIDFunction,myhandle,'getWhigh'}, 'Background', mlep.colorWhite );
                                    mlep.sysIDlevels = uiextras.HBox( 'Parent', mlep.sysID1HBoxVBox, 'Padding', 5, 'Spacing', 5 );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDlevels, 'String', {'Level ='}, 'FontSize', mlep.fontSmall  );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDlevels, 'String', {'minu'}, 'FontSize', mlep.fontSmall  );
                                        mlep.sysIDeditMinu = uicontrol( 'style', 'edit', 'Parent', mlep.sysIDlevels, 'Callback', {@mlepSysIDFunction,myhandle,'getMinu'}, 'Background', mlep.colorWhite );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDlevels, 'String', {'minu'}, 'FontSize', mlep.fontSmall  );
                                        mlep.sysIDeditManu = uicontrol( 'style', 'edit', 'Parent', mlep.sysIDlevels, 'Callback', {@mlepSysIDFunction,myhandle,'getManu'}, 'Background', mlep.colorWhite );
                                    uicontrol( 'style', 'push', 'Parent', mlep.sysID1HBox, 'Callback', {@mlepSysIDFunction,myhandle,'getInputIndexPID'} );

                        set(mlep.sysIDFeedback1Box,'Sizes',[-1 -4]);
                % Tab 2    
                mlep.sysIDPackagePanel = uiextras.Panel( 'Parent', mlep.sysIDFeedbackTab, 'BorderType', 'none' );
                    mlep.sysIDPackageBox = uiextras.HBox( 'Parent', mlep.sysIDPackagePanel, 'Padding', 5, 'Spacing', 15 );
                        % Panel to select output
                        mlep.sysIDOutputPanel = uiextras.Panel('Parent', mlep.sysIDPackageBox, 'Padding', 10, 'BorderType', 'etchedin', 'BorderWidth', 1, 'Title', 'Package Input/Ouput', 'ForegroundColor', 'b', 'FontSize', mlep.fontMedium ); % etchedin etchedout beveledin beveledout line  
                            mlep.sysIDOutput = uiextras.HBox( 'Parent', mlep.sysIDOutputPanel, 'Padding', 5, 'Spacing', 5 );
                                % LEFT SIDE
                                mlep.sysIDOutputBox = uiextras.HBox( 'Parent', mlep.sysIDOutput, 'Padding', 5, 'Spacing', 5 );
                                    % VARIABLES LISTBOX
                                    mlep.sysIDVariablesBox = uiextras.VBox( 'Parent', mlep.sysIDOutputBox, 'Padding', 0, 'Spacing', 0 );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDVariablesBox, 'String', {'Variables'}, 'FontSize', mlep.fontMedium );
                                        mlep.sysIDvarsListbox = uicontrol('style','listbox','Parent', mlep.sysIDVariablesBox,'Background', [1 1 1], 'Callback', {@mlepSysIDFunction,myhandle,'getVarsIndexSelected'} );
                                    set(mlep.sysIDVariablesBox,'Sizes',[-1 -8]);
                                    % ADD/DELETE BUTTON
                                    mlep.sysIDButtonBox = uiextras.VBox( 'Parent', mlep.sysIDOutputBox, 'Padding', 5, 'Spacing', 5 );
                                        mlep.sysIDInputButton = uiextras.VButtonBox( 'Parent', mlep.sysIDButtonBox, 'ButtonSize', [100 40], 'VerticalAlignment', 'bottom'  );
                                            uicontrol( 'style', 'push', 'string', 'add >>', 'Parent', mlep.sysIDInputButton, 'Callback', {@mlepSysIDFunction,myhandle,'addInput'});
                                            uicontrol( 'style', 'push', 'string', '<< delete', 'Parent', mlep.sysIDInputButton, 'Callback', {@mlepSysIDFunction,myhandle,'deleteInput'});
                                        mlep.sysIDOutputButton = uiextras.VButtonBox( 'Parent', mlep.sysIDButtonBox, 'ButtonSize', [100 40], 'VerticalAlignment', 'bottom'  );
                                            uicontrol( 'style', 'push', 'string', 'add >>', 'Parent', mlep.sysIDOutputButton, 'Callback', {@mlepSysIDFunction,myhandle,'addOutput'});
                                            uicontrol( 'style', 'push', 'string', '<< delete', 'Parent', mlep.sysIDOutputButton, 'Callback', {@mlepSysIDFunction,myhandle,'deleteOutput'});
                                    mlep.sysIDSelectedBox = uiextras.VBox( 'Parent', mlep.sysIDOutputBox, 'Padding', 0, 'Spacing', 0 );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDSelectedBox, 'String', {'Inputs'}, 'FontSize', mlep.fontMedium );
                                        mlep.sysIDInputListboxSelected = uicontrol( 'style', 'listbox', 'Parent', mlep.sysIDSelectedBox, 'Background', 'white', 'Callback', {@mlepSysIDFunction,myhandle,'getInputIDSelectedIndex'} );
                                        uicontrol( 'style', 'text', 'Parent', mlep.sysIDSelectedBox, 'String', {'Outputs'}, 'FontSize', mlep.fontMedium );
                                        mlep.sysIDOutputListboxSelected = uicontrol( 'style', 'listbox', 'Parent', mlep.sysIDSelectedBox, 'Background', 'white', 'Callback', {@mlepSysIDFunction,myhandle,'getOutputIDSelectedIndex'} );
                                    set(mlep.sysIDSelectedBox,'Sizes',[-1 -4 -1 -4]);
                                set(mlep.sysIDOutputBox,'Sizes', [-2.5 -1 -2.5]);    
                        % Panel to run iddata            
                        mlep.sysIDOutputSelectionPanel = uiextras.Panel('Parent', mlep.sysIDPackageBox, 'Padding', 10, 'BorderType', 'etchedin', 'BorderWidth', 1, 'Title', 'Sys ID', 'ForegroundColor', 'b', 'FontSize', mlep.fontMedium ); % etchedin etchedout beveledin beveledout line  
                            mlep.sysIDOutputSelectionButton = uiextras.VButtonBox( 'Parent', mlep.sysIDOutputSelectionPanel, 'ButtonSize', [200 40], 'VerticalAlignment', 'top'  );
                                uicontrol( 'style', 'push', 'string', 'iddata', 'Parent', mlep.sysIDOutputSelectionButton, 'Callback', {@mlepSysIDFunction,myhandle,'runIddata'});
                                uicontrol( 'style', 'push', 'string', 'Run Ident', 'Parent', mlep.sysIDOutputSelectionButton, 'Callback', {@mlepSysIDFunction,myhandle,'runIdent'});
                    % Set Size for Results Panel            
                    set(mlep.sysIDPackageBox,'Sizes',[-4 -1]);               


                % Tab 3    
                % Set Default Tab and Names
                mlep.sysIDFeedbackTab.TabNames = {'1. Define Inputs', '2. Package Data'}; %, '4. OTHER'
                mlep.sysIDFeedbackTab.SelectedChild = 1;
                
            % Set size Box 
            set(mlep.sysIDFeedbackBox, 'Sizes', [-1.5 -5]);

% SET SIZE            
set( mlep.sysIDBox, 'Sizes', [-2 -4]);
%set( mlep.sysIDBox, 'Sizes', [-2 -2 -1] );

% Store Data        
guidata(myhandle,mlep); 
end

