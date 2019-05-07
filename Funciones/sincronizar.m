
function [med_imu_s]= sincronizar(med_cam,med_imu_s,init_)

   yy1 = smooth(med_cam.Rigid_Body.RigidBody.Rotation(:,1),0.001,'rloess');

 [c,lag]=xcorr(yy1,med_imu_s.Rotation(1:end,1));
 
 [~,I]=max(abs(c));
    
 lag(I);

end