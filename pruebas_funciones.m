%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% sincronizacion, calibracion y representacion 2D de los datos %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
addpath('Funciones\')

med_cal=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack\10-05-2019\Calibracion Robot_Shimmer.csv');
med_cam=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack\10-05-2019\Take 2019-05-10 12.55.42 PM.csv');
med_imu=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\10-05-2019\2019-05-10_12.51 (1).11_default_exp_SD_Session1\default_exp_Session1_idBFED_Calibrated_SD','BFED');
med_cam.Rigid_Body.RigidBody.Rotation=-[med_cam.Rigid_Body.RigidBody.Rotation(:,4), med_cam.Rigid_Body.RigidBody.Rotation(:,1:3)];


%% Sincronizacion manual de los sensores y las camaras

med_imu_s=sincronizar_imus(med_cam,{med_imu},1);
plot_camara_imu_2D(med_cam,med_imu_s); 
%%
med_imu_s=sincronizar_imus(med_cam,{med_imu},3950-1115); % Indicamos la diferencia temporal en muestras que tienen ambos sensores, extraido del apartado anterior
plot_camara_imu_2D(med_cam,med_imu_s);

%% calculo y aplicacion cambio de base entre espacios de camara y sensores imu

[mcb0,mcb1]=matriz_cambio_base(med_cal,med_imu_s{1},1,'Shimmer');
med_imu_s{1}=transformacion_cuaterniones(med_imu_s{1},mcb0,mcb1)
plot_camara_imu_2D(med_cam,med_imu_s);




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calibracion de los sensores imu para su comparacion con las camaras %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculamos las matries de cambio de base para poder expresor los giros en
% el mismo espacio y comparar las mediciones entre imus y camaras

clc
clear all
addpath('Funciones\')

med_cal=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack-shimmers\17-05-2019\test1\Calibracion_imus.csv');
med_cam=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack-shimmers\17-05-2019\test1\Take 2019-05-17 01.44.21 PM.csv');
med_imu=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack-shimmers\17-05-2019\test1\default_exp_Session1_idBFED_Calibrated_SD.csv','BFED');

% med_imu.Quat=med_imu.Quat(:,5:8);
med_cam.Rigid_Body.RigidBody.Rotation=-[med_cam.Rigid_Body.RigidBody.Rotation(:,4), med_cam.Rigid_Body.RigidBody.Rotation(:,1:3)];

%% Calculo de los cuaterniones y sincronizacion

imus_calibrados=[];
imus_calibrados{1}=med_imu;
imus_calibrados{1}.Quat=quaternion_6DOF(imus_calibrados{1},mean(1./diff(med_imu.tiempo)*1000));
imus_calibrados=sincronizar_imus(med_cam,imus_calibrados,3710-1237);

%% Cambio de base y represnetacion

[mcb0,mcb1]=matriz_cambio_base(med_cal,imus_calibrados{1},1,'RigidBody',[1 0 0; 0 1  0 ; 0 0 1]);
imus_calibrados{1}=transformacion_cuaterniones(imus_calibrados{1},mcb0,mcb1)
plot_camara_imu_2D(med_cam,imus_calibrados);





%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Ejemplo configuracion Sensores %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Configuracion de un shimmer por bluetooth

SensorMacros = SetEnabledSensorsMacrosClass;    
configuracion_shimmer('5',100,{SensorMacros.LNACCEL,SensorMacros.GYRO,SensorMacros.MAG,'Quat'})




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Error de las camaras en comparacion con el movimiento real del robot %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cargar datos
% Fecha:10/05/2019

clear all
clc

addpath('Funciones\')
med_cal=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack\10-05-2019\Calibracion Robot_Shimmer.csv');
med_cam=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack\10-05-2019\Take 2019-05-10 12.55.42 PM.csv');
med_imu=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\10-05-2019\2019-05-10_12.51 (1).11_default_exp_SD_Session1\default_exp_Session1_idBFED_Calibrated_SD.csv','BFED');
med_cam.Rigid_Body.RigidBody.Rotation=-[med_cam.Rigid_Body.RigidBody.Rotation(:,4), med_cam.Rigid_Body.RigidBody.Rotation(:,1:3)];

%% Sincronizacion manual de los sensores y las camaras

med_imu_s=sincronizar_imus(med_cam,{med_imu},1);
plot_camara_imu_2D(med_cam,med_imu_s); 
%%
med_imu_s=sincronizar_imus(med_cam,{med_imu},3236-1144); % Indicamos la diferencia temporal en muestras que tienen ambos sensores, extraido del apartado anterior
plot_camara_imu_2D(med_cam,med_imu_s);

%% Movimientos del robot

T0=1160; % Tiempo parado hasta el primer movimiento 
T=2055-1610; % tiempo parado entre movimientos
q1=[0.6533   -0.2706    0.6533   -0.2706].*ones(T0,4);
q2=[0   -0.3827    0.9239         0].*ones(T,4);
q3=[0    0.3827    0.9239         0].*ones(T,4);
q4=[0    0.9239     0.3827         0].*ones(T,4); %[0   -0.9239   -0.3827         0]
q5=[0   -0.9239    0.3827         0].*ones(T,4);
q6=[0.9239         0         0   -0.3827].*ones(T,4);

% Transitorio=ones(50,4);
med_robot=[];
med_robot.Quat=[q1;q2;q3;q4;q5;q6];
med_robot.Nombre='robot';
[mcb0,mcb1]=matriz_cambio_base(med_cal,med_robot,100,'Robot',[1 0 0; 0 1  0 ; 0 0 1]);
med_robot=transformacion_cuaterniones(med_robot,mcb0,mcb1);


[mcb0,mcb1]=matriz_cambio_base(med_cal,med_imu_s{1},500,'Shimmer',[1 0 0; 0 1  0 ; 0 0 1]);
med_imu_s{1}=transformacion_cuaterniones(med_imu_s{1},mcb0,mcb1)


med_robot.Euler=quat2eul(med_robot.Rotation);
med_robot.Axang=quat2axang(med_robot.Rotation);

med_cam.Rigid_Body.RigidBody.Euler=quat2eul(med_cam.Rigid_Body.RigidBody.Rotation);
med_cam.Rigid_Body.RigidBody.Axang=quat2axang(med_cam.Rigid_Body.RigidBody.Rotation);

med_imu_s{1}.Euler=quat2eul(med_imu_s{1}.Rotation);
med_imu_s{1}.Axang=quat2axang(med_imu_s{1}.Rotation);


plot_camara_imu_2D(med_cam,{med_robot med_imu_s{1}});


%% Calculo error en angulos de euler

% Se calculara el error comparando las ventanas de movimientos en parado.
% Si el periodo es de T, se dejara un margen de 50 muestras entre cada
% ventana en cada movimiento para evitar el transitorio.

T1=T0-T; % Inicio de la primera ventana
Err=[];
margen=30;
for i=1:6
   
    dif_ventanas_cam=abs(angdiff(med_robot.Euler(T1+T*(i-1)+margen:T1+T*i-margen,:),med_cam.Rigid_Body.RigidBody.Euler(T1+T*(i-1)+margen:T1+T*i-margen,:)));
    dif_ventanas_imu=abs(angdiff(med_robot.Euler(T1+T*(i-1)+margen:T1+T*i-margen,:),med_imu_s{1}.Euler(T1+T*(i-1)+margen:T1+T*i-margen,:)));
    Err_cam(i,:)=mean(dif_ventanas_cam,1);
    Err_imu(i,:)=mean(dif_ventanas_imu,1);
end

% disp("Eje x, Eje y, Eje z")
% Err

figure()
subplot(1,2,1)
c = categorical({'Giro1 X ','Giro2 Z ','Giro3 Z ','Giro4 Z ','Giro5 Z+X ','Giro6 X '});
bar(c,Err_cam*180/pi)
title('Error camaras [º]')
ylim([0 10])
legend('Eje X','Eje Y','Eje Z')

subplot(1,2,2)
c = categorical({'Giro1 X ','Giro2 Z ','Giro3 Z ','Giro4 Z ','Giro5 Z+X ','Giro6 X '});
bar(c,Err_imu*180/pi)
title('Error imus [º]')
ylim([0 10])
legend('Eje X','Eje Y','Eje Z')




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Comparaicon del calculo de cuaterniones en online y offline %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fecha:21/05/2019

med_imu=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\21-05-2019\2019-05-21_10.16.03_default_exp_SD_Session1\default_exp_Session1_Shimmer_BAD7_Calibrated_SD.csv','BAD7');
med_imu2=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\21-05-2019\2019-05-21_10.51.17_default_exp_SD_Session1\default_exp_Session1_Shimmer_BAD7_Calibrated_SD.csv','BAD7');
med_imu3=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\21-05-2019\2019-05-21_10.51.17_default_exp_SD_Session1_quat\default_exp_Session1_Shimmer_BAD7_Calibrated_SD.csv','BAD7');
med_imu4=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\21-05-2019\2019-05-21_14.00.34_default_exp_SD_Session1\default_exp_Session1_Shimmer_BAD7_Calibrated_SD.csv','BAD7');
med_imu5=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\21-05-2019\2019-05-21_14.10.28_default_exp_SD_Session1\default_exp_Session1_Shimmer_BAD7_Calibrated_SD.csv','BAD7');
med_imu6=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\21-05-2019\2019-05-21_14.17.38_default_exp_SD_Session1\default_exp_Session1_Shimmer_BAD7_Calibrated_SD.csv','BAD7');
med_imu7=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\21-05-2019\2019-05-21_14.17.38_default_exp_SD_Session1_quat\default_exp_Session1_Shimmer_BAD7_Calibrated_SD.csv','BAD7');
med_imu8=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\21-05-2019\2019-05-21_14.17.38_default_exp_SD_Session1_quat_LN\default_exp_Session1_Shimmer_BAD7_Calibrated_SD.csv','BAD7');

%%

plot(med_imu.Quat,'r') % Online, sensores sin calibrar
hold on
plot(med_imu2.Quat,'b') % Online, sensores calibrados
plot(med_imu3.Quat(:,9:12),'g') % Online, sensores calibrados; Offline, 6DOF, 9DOF
plot(med_imu4.Quat,'y') % Online, opcion MPU gyro
plot(med_imu5.Quat,'c') % Online, solo activos low noise accel y gyros
plot(med_imu6.Quat,'c') % Online, Todos los sensores activos activo
plot(med_imu7.Quat(:,5:8),'c') %Online y Offline, 6DOF
plot(med_imu8.Quat,'c') % Offline, 6DOF calculado con Accel_LN