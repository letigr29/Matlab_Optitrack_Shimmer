function [m_imu]= transformacion_cuaterniones(m_imu,mcb0,mcb1)
    
    for t=1:length(m_imu.Quat)
        m_imu.Rotation(t,:)=(dcm2quat((mcb1)*quat2dcm(m_imu.Quat(t,:))*mcb0'));
    end
    
end