
addpath('Funciones\')
% med_cal=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack\25-04-2019\Take 2019-04-25 12.19.51 PM_001.csv');
med_cam=cargar_datos_camara('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack-shimmers\04-04-2019\datos_vicon_session4\Take 2019-04-04 12.13.10 PM.csv');
med_imu=cargar_datos_shimmer('G:\Mi unidad\Universidad\Doctorado\Mediciones\Datos optitrack-shimmers\04-04-2019\datos_imu_Session4\default_exp_Session4_idBFED_Calibrated_SD.csv');
med_cam.Rigid_Body.RigidBody.Rotation=-[med_cam.Rigid_Body.RigidBody.Rotation(:,4), med_cam.Rigid_Body.RigidBody.Rotation(:,1:3)];
%%
plot_camara_imu_2D(med_cal,{med_imu});
med_imu_s=sincronizar_imus(med_cam,{med_imu},1818);

%%

[m_ali0,m_ali]=matriz_ali(med_imu_s,med_cam);
m_ali0=real(m_ali0)
m_ali=real(m_ali)

%%

plot_camara_imu_3D(med_cam,med_imu_s) 
% RB= m_ali
%%

% med_imu_s{1}.euler2quat=eul2quat(unwrap(quat2eul(med_imu_s{1}.Quat)));
for t=1:length(med_imu_s{1}.Quat)
    med_imu_s{1}.euler2quat(t,:)=(m_ali0*quat2dcm(med_imu_s{1}.Quat)*m_ali);
end

 [pitch, roll, yaw]=quat2angle( med_imu_s{1}.euler2quat,'XYZ');
med_imu_s{1}.angle=unwrap([pitch, roll, yaw]);

 [pitch, roll, yaw]=quat2angle( med_cam.Rigid_Body.RigidBody.Rotation,'XYZ');
med_cam.Rigid_Body.RigidBody.angle=unwrap([pitch, roll, yaw]);
% med_cam.Rigid_Body.RigidBody.euler2quat=eul2quat(unwrap(quat2eul( med_cam.Rigid_Body.RigidBody.Rotation)));

for t=1:length(med_cam.Rigid_Body.RigidBody.Rotation)
    med_cam.Rigid_Body.RigidBody.euler2quat(t,:)=(quat2dcm(med_cam.Rigid_Body.RigidBody.Rotation(t,:)));
end
%%
plot_camara_imu_2D(med_cam,med_imu_s);

