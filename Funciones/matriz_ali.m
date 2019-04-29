% funcion para calcular la matriz de alineacion de med_imu referido a
% med_cam

function [Rb]= matriz_ali(med_cal)

   
p1=med_cal.Rigid_Body_Marker.RigidBody_Marker1.Position;
p2=med_cal.Rigid_Body_Marker.RigidBody_Marker2.Position;
p3=med_cal.Rigid_Body_Marker.RigidBody_Marker3.Position;  
RB=med_cal.Rigid_Body.RigidBody.Position;

P1=mean(p1);
P2=mean(p2);
P3=mean(p3);

d1=sqrt(sum((P1-P2).^2));
d2=sqrt(sum((P1-P3).^2));
d3=sqrt(sum((P3-P2).^2));

if d1==max([d1,d2,d3])
    c=P3;
        
    if(d2>d3)
        bx=P1-c;
        bz=P2-c;
    else
        bx=P2-c;
        bz=P1-c;
    end

elseif  d2==max([d1,d2,d3])
    c=P2    

    if(d1>d3)
        bx=P1-c;
        bz=P3-c;
    else
        bx=P3-c;
        bz=P1-c;
    end
    
elseif  d3==max([d1,d2,d3])
    c=P1;    

    if(d1>d2)
        bx=P2-c;
        bz=P3-c;
    else
        bx=P3-c;
        bz=P2-c;
    end

end

by = cross(bz,bx);

bx=bx/norm(bx);
by=by/norm(by);
bz=bz/norm(bz);

matriz_ali=[bx',by',bz'];
    % variables
%     num_imus= length(med_imu);
% %     med_cam_euler=unwrap(quat2eul([med_cam.Rigid_Body.RigidBody.Rotation(:,4), med_cam.Rigid_Body.RigidBody.Rotation(:,1:3)]));
%     
%     for n=1:num_imus % igualamos frecuencias de los imus con las camaras
% %         med_imu_euler{n}=unwrap(quat2eul(med_imu{1}.Quat));
% %         
% %         m{n}=mean(med_cam_euler(1:init,:))-mean(med_imu_euler{n}(1:init,:));
% 
%         A1=quat2dcm(med_cam.Rigid_Body.RigidBody.Rotation);
% %         A2=quat2dcm(med_cam.Rigid_Body.RigidBody.Rotation(2000,:));
%         
%         B1=quat2dcm(med_imu{n}.Quat);
% %         B2=quat2dcm(med_imu{n}.Quat(2000,:));
%         
%         C=[0 0 1; 0 1 0; -1 0 0];
%         
%         for t=1:length(med_imu{n}.Quat)
%             med(:,:,t)=A1(:,:,t)*inv(C)*inv(B1(:,:,t));
%         end
%         Rb=mean(med,3);
% %         m_ali{n}=eul2quat(m{n},'XYZ')
%     end
    
    
end