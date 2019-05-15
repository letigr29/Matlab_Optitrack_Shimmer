
%%      
% addpath('G:\Mi unidad\Universidad\Doctorado\Git_Matlab_Optitrack_Shimmer\Librerias\Shimmer Matlab Instrument Driver v2.8\');
% addpath('G:\Mi unidad\Universidad\Doctorado\Git_Matlab_Optitrack_Shimmer\Librerias\Shimmer Matlab Instrument Driver v2.8\quaternion');
% addpath('G:\Mi unidad\Universidad\Doctorado\Git_Matlab_Optitrack_Shimmer\Librerias\Shimmer Matlab Instrument Driver v2.8\Resources');

function [res]=configuracion_shimmer(puerto,freq,sensores)
addpath('G:\Mi unidad\Universidad\Doctorado\Git_Matlab_Optitrack_Shimmer\Librerias\Shimmer Matlab Instrument Driver v2.8\');

   shimmer = ShimmerHandleClass(puerto);
                              % assign user friendly macros for setenabledsensors

   while(~shimmer.connect())
        disp('Error al intentar conectar el sensor.')
   end      
   
   sensores_activar={'Accel',0;'LowNoiseAccel',0;'WideRangeAccel',0;'AlternativeAccel',0;...
       'Gyro',0;'Mag',0;'AlternativeMag',0;'ECG',0;'ECG 24BIT',0;'ECG 16BIT',0;...
       'EMG',0;'EMG 24BIT',0;'EMG 16BIT',0;'EXG1',0;'EXG1 24BIT',0;'EXG1 16BIT',0;...
       'EXG2',0;'EXG2 24BIT',0;'EXG2 16BIT',0;'GSR',0;'ExpBoard_A0',0;'ExpBoard_A7',0;...
       'EXT A7',0;'EXT A6',0;'EXT A15',0;'Strain Gauge',0;'Bridge Amplifier',0;...
       'Heart Rate',0;'BattVolt',0;'INT A1',0;'INT A12',0;'INT A13',0;'INT A14',0;...
       'Pressure',0};
   
   for i=1:length(sensores)
       activar=find(strcmp(sensores_activar, sensores{i}));
 
       if ~isempty(activar)
          sensores_activar{activar,2}=1; 
       end
   end
   
  % configuramos los sensores

   shimmer.setsamplingrate(freq);   
   
%    shimmer.disableallsensors;                                             % disable all sensors
   shimmer.setenabledsensors('Accel',sensores_activar{1,2},'LowNoiseAccel',sensores_activar{2,2},'WideRangeAccel',sensores_activar{3,2},'AlternativeAccel',sensores_activar{4,2},...
       'Gyro',sensores_activar{5,2},'Mag',sensores_activar{6,2},'AlternativeMag',sensores_activar{7,2},'ECG',sensores_activar{8,2},'ECG 24BIT',sensores_activar{9,2},'ECG 16BIT',sensores_activar{10,2},...
       'EMG',sensores_activar{11,2},'EMG 24BIT',sensores_activar{12,2},'EMG 16BIT',sensores_activar{13,2},'EXG1',sensores_activar{14,2},'EXG1 24BIT',sensores_activar{15,2},'EXG1 16BIT',sensores_activar{16,2},...
       'EXG2',sensores_activar{17,2},'EXG2 24BIT',sensores_activar{18,2},'EXG2 16BIT',sensores_activar{19,2},'GSR',sensores_activar{20,2},'ExpBoard_A0',sensores_activar{21,2},'ExpBoard_A7',sensores_activar{22,2},...
       'EXT A7',sensores_activar{23,2},'EXT A6',sensores_activar{24,2},'EXT A15',sensores_activar{25,2},'Strain Gauge',sensores_activar{26,2},'Bridge Amplifier',sensores_activar{27,2},...
       'Heart Rate',sensores_activar{28,2},'BattVolt',sensores_activar{29,2},'INT A1',sensores_activar{30,2},'INT A12',sensores_activar{31,2},'INT A13',sensores_activar{32,2},'INT A14',sensores_activar{33,2},...
       'Pressure',sensores_activar{34,2});    
  
%    if ~isempty(find(strcmp(sensores,'Quat')))
%         shimmer.setorientation3D(1); 
%         shimmer.setgyroinusecalibration(1);  
%    else
%         shimmer.setorientation3D(0);
%         shimmer.setgyroinusecalibration(0);  
%    end
%    if ~isempty(find(strcmp(sensores,'Unix')))
%         shimmer.enabletimestampunix(1);   
%    else
%        shimmer.enabletimestampunix(0);
%    end
%    
   shimmer.setrealtimeclock();
   
   shimmer.disconnect;
end