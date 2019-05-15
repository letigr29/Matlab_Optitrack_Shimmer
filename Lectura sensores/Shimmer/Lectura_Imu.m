clear all
clc
fclose('all');
%%      
addpath('G:\Mi unidad\Universidad\Doctorado\Git_Matlab_Optitrack_Shimmer\Librerias\Shimmer Matlab Instrument Driver v2.8\');
addpath('G:\Mi unidad\Universidad\Doctorado\Git_Matlab_Optitrack_Shimmer\Librerias\Shimmer Matlab Instrument Driver v2.8\quaternion');
addpath('G:\Mi unidad\Universidad\Doctorado\Git_Matlab_Optitrack_Shimmer\Librerias\Shimmer Matlab Instrument Driver v2.8\Resources');
%% conexion y configuración

% Conectamos Shimmer

shimmer = ShimmerHandleClass('5');
shimmer2 = ShimmerHandleClass('15');
% COM5  -> BAD7
% COM15 -> 3BE8
SensorMacros = SetEnabledSensorsMacrosClass;                               % assign user friendly macros for setenabledsensors
fs = 512;                                                                  % sample rate in [Hz]


while(~shimmer.connect() || ~shimmer2.connect())
    disp('Error al intentar conectar el sensor.')
    shimmer.disconnect;                                                   % Disconnect from shimmer1
    shimmer2.disconnect;
end

disp('Shimmer connected')
    
    
% configuramos los sensores

% shimmer.disableallsensors;                                             % disable all sensors
% shimmer.setenabledsensors(SensorMacros.LNACCEL,1,SensorMacros.WRACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
%     SensorMacros.GYRO,1);    
% shimmer.setorientation3D(1);                                           % Enable orientation3D
% shimmer.setgyroinusecalibration(1);                                    % Enable gyro in-use calibration  

% shimmer.setrealtimeclock()
% shimmer2.setrealtimeclock()

   
shimmer.getrealtimeclock()
shimmer2.getrealtimeclock()

% % Note: these constants are only relevant to this examplescript and are not used
% % by the ShimmerHandle Class
% DELAY_PERIOD = 0.2;  
% captureDuration=60;
% 

%     if (shimmer.start)                                                     % TRUE if the shimmer starts streaming
%         
%   
%         while (elapsedTime < captureDuration)
%             
%             pause(DELAY_PERIOD);                                           % Pause for this period of time on each iteration to allow data to arrive in the buffer
%             
%             [newData,signalNameArray,signalFormatArray,signalUnitArray] = shimmer.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
%             
%          
%             if ~isempty(newData)                                                                          % TRUE if new data has arrived
%                 
%                 allData = [allData; newData];
%                 
%                 %dlmwrite(fileName, newData, '-append', 'delimiter', '\t','precision',16);                                % Append the new data to the file in a tab delimited format
%                 
%                 quaternionChannels(1) = find(ismember(signalNameArray, 'Quaternion 0'));                  % Find Quaternion signal indices.
%                 quaternionChannels(2) = find(ismember(signalNameArray, 'Quaternion 1'));
%                 quaternionChannels(3) = find(ismember(signalNameArray, 'Quaternion 2'));
%                 quaternionChannels(4) = find(ismember(signalNameArray, 'Quaternion 3'));
%                 
%                 quaternion = newData(end, quaternionChannels);                                            % Only use the most recent quaternion sample for the graphic
%                                 
%                 shimmer3dRotated.p1 = quatrotate(quaternion, [0 shimmer3d.p1]);                           % Rotate the vertices
%                 shimmer3dRotated.p2 = quatrotate(quaternion, [0 shimmer3d.p2]);
%                 shimmer3dRotated.p3 = quatrotate(quaternion, [0 shimmer3d.p3]);
%                 shimmer3dRotated.p4 = quatrotate(quaternion, [0 shimmer3d.p4]);
%                 shimmer3dRotated.p5 = quatrotate(quaternion, [0 shimmer3d.p5]);
%                 shimmer3dRotated.p6 = quatrotate(quaternion, [0 shimmer3d.p6]);
%                 shimmer3dRotated.p7 = quatrotate(quaternion, [0 shimmer3d.p7]);
%                 shimmer3dRotated.p8 = quatrotate(quaternion, [0 shimmer3d.p8]);
%                 shimmer3dRotated.p9 = quatrotate(quaternion, [0 shimmer3d.p9]);
%                 shimmer3dRotated.p10 = quatrotate(quaternion, [0 shimmer3d.p10]);
%                 shimmer3dRotated.p11 = quatrotate(quaternion, [0 shimmer3d.p11]);
%                 shimmer3dRotated.p12 = quatrotate(quaternion, [0 shimmer3d.p12]);
%                 shimmer3dRotated.p13 = quatrotate(quaternion, [0 shimmer3d.p13]);
%                 shimmer3dRotated.p14 = quatrotate(quaternion, [0 shimmer3d.p14]);
%                 shimmer3dRotated.p15 = quatrotate(quaternion, [0 shimmer3d.p15]);
%                 shimmer3dRotated.p16 = quatrotate(quaternion, [0 shimmer3d.p16]);
%                 x = [shimmer3dRotated.p1(2),shimmer3dRotated.p2(2),shimmer3dRotated.p3(2),shimmer3dRotated.p4(2),...      % Calculate the convex hull for the graphic
%                      shimmer3dRotated.p5(2),shimmer3dRotated.p6(2),shimmer3dRotated.p7(2),shimmer3dRotated.p8(2),...      
%                      shimmer3dRotated.p9(2),shimmer3dRotated.p10(2),shimmer3dRotated.p11(2),shimmer3dRotated.p12(2)]';
%                 y = [shimmer3dRotated.p1(3),shimmer3dRotated.p2(3),shimmer3dRotated.p3(3),shimmer3dRotated.p4(3),...
%                      shimmer3dRotated.p5(3),shimmer3dRotated.p6(3),shimmer3dRotated.p7(3),shimmer3dRotated.p8(3),...      
%                      shimmer3dRotated.p9(3),shimmer3dRotated.p10(3),shimmer3dRotated.p11(3),shimmer3dRotated.p12(3)]';
%                 z = [shimmer3dRotated.p1(4),shimmer3dRotated.p2(4),shimmer3dRotated.p3(4),shimmer3dRotated.p4(4),...
%                      shimmer3dRotated.p5(4),shimmer3dRotated.p6(4),shimmer3dRotated.p7(4),shimmer3dRotated.p8(4),...      
%                      shimmer3dRotated.p9(4),shimmer3dRotated.p10(4),shimmer3dRotated.p11(4),shimmer3dRotated.p12(4)]';
%                  
%                 X = [x,y,z];
%                 K = convhulln(X);      
%                 set(0,'CurrentFigure',h.figure1);
%                 hold off;
%                 % Plot object surface
%                 trisurf(K,X(:,1),X(:,2),X(:,3),'EdgeColor','None','FaceColor','w');
%                 hold on;
%                 % Plot object outlines
%                 plot3([shimmer3dRotated.p1(2), shimmer3dRotated.p2(2)],[shimmer3dRotated.p1(3), shimmer3dRotated.p2(3)],[shimmer3dRotated.p1(4), shimmer3dRotated.p2(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p2(2), shimmer3dRotated.p3(2)],[shimmer3dRotated.p2(3), shimmer3dRotated.p3(3)],[shimmer3dRotated.p2(4), shimmer3dRotated.p3(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p3(2), shimmer3dRotated.p4(2)],[shimmer3dRotated.p3(3), shimmer3dRotated.p4(3)],[shimmer3dRotated.p3(4), shimmer3dRotated.p4(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p4(2), shimmer3dRotated.p1(2)],[shimmer3dRotated.p4(3), shimmer3dRotated.p1(3)],[shimmer3dRotated.p4(4), shimmer3dRotated.p1(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p5(2), shimmer3dRotated.p6(2)],[shimmer3dRotated.p5(3), shimmer3dRotated.p6(3)],[shimmer3dRotated.p5(4), shimmer3dRotated.p6(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p6(2), shimmer3dRotated.p7(2)],[shimmer3dRotated.p6(3), shimmer3dRotated.p7(3)],[shimmer3dRotated.p6(4), shimmer3dRotated.p7(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p7(2), shimmer3dRotated.p8(2)],[shimmer3dRotated.p7(3), shimmer3dRotated.p8(3)],[shimmer3dRotated.p7(4), shimmer3dRotated.p8(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p8(2), shimmer3dRotated.p5(2)],[shimmer3dRotated.p8(3), shimmer3dRotated.p5(3)],[shimmer3dRotated.p8(4), shimmer3dRotated.p5(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p9(2), shimmer3dRotated.p10(2)],[shimmer3dRotated.p9(3), shimmer3dRotated.p10(3)],[shimmer3dRotated.p9(4), shimmer3dRotated.p10(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p10(2), shimmer3dRotated.p11(2)],[shimmer3dRotated.p10(3), shimmer3dRotated.p11(3)],[shimmer3dRotated.p10(4), shimmer3dRotated.p11(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p11(2), shimmer3dRotated.p12(2)],[shimmer3dRotated.p11(3), shimmer3dRotated.p12(3)],[shimmer3dRotated.p11(4), shimmer3dRotated.p12(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p12(2), shimmer3dRotated.p9(2)],[shimmer3dRotated.p12(3), shimmer3dRotated.p9(3)],[shimmer3dRotated.p12(4), shimmer3dRotated.p9(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p1(2), shimmer3dRotated.p5(2)],[shimmer3dRotated.p1(3), shimmer3dRotated.p5(3)],[shimmer3dRotated.p1(4), shimmer3dRotated.p5(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p2(2), shimmer3dRotated.p6(2)],[shimmer3dRotated.p2(3), shimmer3dRotated.p6(3)],[shimmer3dRotated.p2(4), shimmer3dRotated.p6(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p3(2), shimmer3dRotated.p7(2)],[shimmer3dRotated.p3(3), shimmer3dRotated.p7(3)],[shimmer3dRotated.p3(4), shimmer3dRotated.p7(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p4(2), shimmer3dRotated.p8(2)],[shimmer3dRotated.p4(3), shimmer3dRotated.p8(3)],[shimmer3dRotated.p4(4), shimmer3dRotated.p8(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p1(2), shimmer3dRotated.p9(2)],[shimmer3dRotated.p1(3), shimmer3dRotated.p9(3)],[shimmer3dRotated.p1(4), shimmer3dRotated.p9(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p2(2), shimmer3dRotated.p10(2)],[shimmer3dRotated.p2(3), shimmer3dRotated.p10(3)],[shimmer3dRotated.p2(4), shimmer3dRotated.p10(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p3(2), shimmer3dRotated.p11(2)],[shimmer3dRotated.p3(3), shimmer3dRotated.p11(3)],[shimmer3dRotated.p3(4), shimmer3dRotated.p11(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p4(2), shimmer3dRotated.p12(2)],[shimmer3dRotated.p4(3), shimmer3dRotated.p12(3)],[shimmer3dRotated.p4(4), shimmer3dRotated.p12(4)],'-k','LineWidth',2)
%                 % Plot outline of dock connector
%                 plot3([shimmer3dRotated.p13(2), shimmer3dRotated.p14(2)],[shimmer3dRotated.p13(3), shimmer3dRotated.p14(3)],[shimmer3dRotated.p13(4), shimmer3dRotated.p14(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p14(2), shimmer3dRotated.p15(2)],[shimmer3dRotated.p14(3), shimmer3dRotated.p15(3)],[shimmer3dRotated.p14(4), shimmer3dRotated.p15(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p15(2), shimmer3dRotated.p16(2)],[shimmer3dRotated.p15(3), shimmer3dRotated.p16(3)],[shimmer3dRotated.p15(4), shimmer3dRotated.p16(4)],'-k','LineWidth',2)
%                 plot3([shimmer3dRotated.p16(2), shimmer3dRotated.p13(2)],[shimmer3dRotated.p16(3), shimmer3dRotated.p13(3)],[shimmer3dRotated.p16(4), shimmer3dRotated.p13(4)],'-k','LineWidth',2)
%                 xlim([-2,2])
%                 ylim([-2,2])
%                 zlim([-2,2])
%                 grid on
%                 view(cameraPosition(2:4))
%                 set(gca,'CameraUpVector',cameraUpVector(2:4));
%             end
%             
%             elapsedTime = elapsedTime + toc;                                                              % Stop timer and add to elapsed time
%             tic;                                                                                          % Start timer
%             
%         end
%         
%         elapsedTime = elapsedTime + toc;                                                                  % Stop timer
%         fprintf('The percentage of received packets: %d \n',shimmer.getpercentageofpacketsreceived(allData(:,1))); % Detect lost packets
%         shimmer.stop;                                                                                     % Stop data streaming
%         
%     end
% 
% 

