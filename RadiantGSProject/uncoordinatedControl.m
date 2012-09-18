function [eplus_in_curr, userdata] = uncoordinatedControl(cmd,eplus_out_prev, eplus_in_prev, time, stepNumber, userdata)
if strcmp(cmd,'init')
    % Initialization mode. This part sets the
    % input parameters for the first time step.
    % ---------------WRITE YOUR CODE---------------
    
    userdata = [];
    %% GENERATE ALL NECESSARY CONTORL PARAMETERS
    userdata.timeStep = 1;   % time step in minute
    userdata.deltaT = userdata.timeStep*60;  % time step in seconds
    userdata.timeStepsPerMin = 60/userdata.timeStep;
    
    userdata.HiThres = 24;
    userdata.LoThres = 22;
    
    % Time of day to start pre-heating
    userdata.PreheatTime = 5*userdata.timeStepsPerMin + 1;
    
    % Time of day to start and stop control
    userdata.startTime = 8*userdata.timeStepsPerMin + 1;
    userdata.endTime = 18*userdata.timeStepsPerMin + 1;
    
    % WRITE INPUTS
    eplus_in_curr.rad1 = 1;
    eplus_in_curr.rad2 = 1;
    eplus_in_curr.rad3 = 1;
    
elseif strcmp(cmd,'normal')
    % Regular mode. This part sets the
    % input parameters for the following time steps.
    % ---------------WRITE YOUR CODE---------------
    % Time of Day
    timeOfDay = mod(stepNumber, 24*userdata.timeStepsPerMin);
    if stepNumber == 481
        disp('here');
    end
    
    % Compute control values
    if timeOfDay < userdata.PreheatTime || timeOfDay >= userdata.endTime
        radiant1 = 1;
        radiant2 = 1;
        radiant3 = 1;
    elseif timeOfDay < userdata.startTime
        radiant1 = 1;
        radiant2 = 1;
        radiant3 = 1;
    else
        switch eplus_in_prev.rad1(end)
            case 0
                if eplus_out_prev.temp1(end) <= userdata.LoThres
                    radiant1 = 1;
                else
                    radiant1 = eplus_in_prev.rad1(end);
                end

            case 1
                if eplus_out_prev.temp1(end) >= userdata.HiThres
                    radiant1 = 0;
                else
                    radiant1 = eplus_in_prev.rad1(end);
                end

        end
        
        switch eplus_in_prev.rad2(end)
            case 0
                if eplus_out_prev.temp2(end) <= userdata.LoThres
                    radiant2 = 1;
                else
                    radiant2 = eplus_in_prev.rad2(end);
                end
            case 1
                if eplus_out_prev.temp2(end) >= userdata.HiThres
                    radiant2 = 0;
                else
                    radiant2 = eplus_in_prev.rad2(end);
                end
        end
        
        switch eplus_in_prev.rad3(end)
            case 0
                if eplus_out_prev.temp3(end) <= userdata.LoThres
                    radiant3 = 1;
                else
                    radiant3 = eplus_in_prev.rad3(end);
                end
            case 1
                if eplus_out_prev.temp3(end) >= userdata.HiThres
                    radiant3 = 0;
                else
                    radiant3 = eplus_in_prev.rad3(end);
                end
        end
    end
    
    % WRITE INPUTS
    eplus_in_curr.rad1 = radiant1;
    eplus_in_curr.rad2 = radiant2;
    eplus_in_curr.rad3 = radiant3;
    
end
