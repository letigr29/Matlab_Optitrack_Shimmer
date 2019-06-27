% function [m_imu]= transformacion_cuaterniones(m_imu,mcb0,mcb1)
%
% Funcion para la transformacion de los cuaterniones de un sensor mediante
% la aplicacion de la matriz de cambio de base (mbc0) entre el sistema de
% referencia de las cámaras y el del sensor, y la matriz de rotación
% establecida entre el cuerpo rigido y el sensor (mcb1).
%
% quat_final = mcb1*quat*inv(mcb0)

function [Rotation]= transformacion_cuaterniones(Quat,mcb0,mcb1)
    
    for t=1:length(Quat)
        Rotation(t,:)=(dcm2quat((mcb1)*quat2dcm(Quat(t,:))*inv(mcb0)));
    end
    
end