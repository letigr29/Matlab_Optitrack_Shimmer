% Funcion que sincroniza las mediciones de los imu, respecto a los tiempos
% y frecuencias de la camara.


function [med_imu_s]= sincronizar_imus(med_cam,med_imu,init_)

   
    % variables
    num_imus= length(med_imu);
    clear nombres_imus;
    if (nargin<3)
         for n=1:num_imus
            init(n)=1;
         end
    else 
        for n=1:num_imus
            init(n)=init_;
        end
    end
    for n=1:num_imus % igualamos frecuencias de los imus con las camaras
        med_imu_s{n}.Nombre=med_imu{n}.Nombre;
        
        fields=fieldnames(med_imu{n});
        for i=3:length(fields)
           if ~isnan(med_imu{n}.(fields{i}))
               TS=timeseries(med_imu{n}.(fields{i}), med_imu{n}.tiempo);
               TS=resample(TS,med_imu{n}.tiempo(1):med_cam.tiempo(2):TS.Time(end));
               med_imu_s{n}.(fields{i})=TS.Data(init(n):end,:);
           end
        end 
        
%         m{n}=med_imu{n}.Quat(1,:)-med_imu_s{n}.Quat(1,:);
%         med_imu_s{n}.Quat=med_imu_s{n}.Quat+m{n};
        med_imu_s{n}.tiempo=TS.Time(init(n):end,:);
        
    end
  
end