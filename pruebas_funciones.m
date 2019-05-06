
addpath('Funciones\')
med_cal=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack\30-04-2019\calibracion.csv');
med_cam=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack\30-04-2019\Take 2019-04-30 12.17.32 PM.csv');
med_imu=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\30-04-2019\orientacion_Session1_idBFED_Calibrated_SD.csv');
med_cam.Rigid_Body.RigidBody.Rotation=-[med_cam.Rigid_Body.RigidBody.Rotation(:,4), med_cam.Rigid_Body.RigidBody.Rotation(:,1:3)];
%med_cam.Rigid_Body.RigidBody.Rotation=-med_cam.Rigid_Body.RigidBody.Rotation;
%%
plot_camara_imu_2D(med_cam,{med_imu});
%%
med_imu_s=sincronizar_imus(med_cam,{med_imu},1);
plot_camara_imu_2D(med_cam,med_imu_s);
%%
med_imu_s=sincronizar_imus(med_cam,{med_imu},4768-950);
%02-05-2019: 5804-911

plot_camara_imu_2D(med_cam,med_imu_s);
%% calculo y aplicacion cambio de base entre espacios de camara y sensores imu

[mcb0,mcb1]=matriz_cambio_base(med_cal,med_imu_s{1},100);
med_imu_s{1}=transformacion_quaterniones(med_imu_s{1},mcb0,mcb1)
%%

plot_camara_imu_2D(med_cam,med_imu_s);

