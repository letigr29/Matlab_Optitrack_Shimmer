
addpath('Funciones\')
med_cal=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack\29-04-2019\Take 2019-04-29 11.50.13 AM.csv');
med_cam=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack\29-04-2019\Take 2019-04-29 01.14.29 PM.csv');
med_imu=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos shimmer\29-04-2019\orientacion_Session1_idBFED_Calibrated_SD.csv');
 med_cam.Rigid_Body.RigidBody.Rotation=-[med_cam.Rigid_Body.RigidBody.Rotation(:,4), med_cam.Rigid_Body.RigidBody.Rotation(:,1:3)];
%med_cam.Rigid_Body.RigidBody.Rotation=-med_cam.Rigid_Body.RigidBody.Rotation;
%%
plot_camara_imu_2D(med_cam,{med_imu});
%%
med_imu_s=sincronizar_imus(med_cam,{med_imu},3083-1128);
plot_camara_imu_2D(med_cam,med_imu_s);
%%

m_ali=matriz_ali(med_cal)

%%

plot_camara_imu_3D(med_cam,med_imu_s) 
% RB= m_ali
%%

% med_imu_s{1}.euler2quat=eul2quat(unwrap(quat2eul(med_imu_s{1}.Quat)));
for t=1:length(med_imu_s{1}.Quat)
    med_imu_s{1}.euler2quat(t,:)=([1 0 0 0 ;0 0 1 0 ;0 0 0 1;0 1 0 0]*(med_imu_s{1}.Quat(t,:)'));
end

 [pitch, roll, yaw]=quat2angle( med_imu_s{1}.euler2quat,'XYZ');
med_imu_s{1}.angle=unwrap([pitch, roll, yaw]);

 [pitch, roll, yaw]=quat2angle( med_cam.Rigid_Body.RigidBody.Rotation,'XYZ');
med_cam.Rigid_Body.RigidBody.angle=unwrap([pitch, roll, yaw]);
% med_cam.Rigid_Body.RigidBody.euler2quat=eul2quat(unwrap(quat2eul( med_cam.Rigid_Body.RigidBody.Rotation)));

for t=1:length(med_cam.Rigid_Body.RigidBody.Rotation)
    med_cam.Rigid_Body.RigidBody.euler2quat(t,:)=dcm2quat(quat2dcm(med_cam.Rigid_Body.RigidBody.Rotation(t,:))*[0 0 1; 0 1 0; -1 0 0]);
end
%%
plot_camara_imu_2D(med_cam,med_imu_s);

