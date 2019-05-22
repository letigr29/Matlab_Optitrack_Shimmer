
% function [imus_calibrados]= calibracion_shimmer(imus)
%
% Funcion para la aplicacion de las matrices de calibracion para los
% sensores shimmer BFED, D54E y CE9F. El valor de las matrices es fijo y
% solo se podra cambiar editanto el codigo fuente de la función.
%
% Nota: Los datos deben estar medidos con los sensores configurados en el
% programa del fabricante con las matrices de calibracion por defecto
%
% Ej: imus_calibrados = calibracion_shimmer({imu1, imu2, imu3})
%
% Calculo de los datos calibrados:
%  c = inv(Rx)*inv(Kx)*(ux-bx)
%    
    %   c = 3x1 vector de señal calibrada
    %   Rx = 3x3 matriz de alineacion
    %   Kx = 3x3 matriz de sensibilidad
    %   ux = 3x1 vector de señal no calibrada
    %   bx = 3x1 vector offset

function [imus_calibrados]= calibracion_shimmer(imus)

    
    Accel_Low_Noise.BFED.Offset=[2042;2020;2024];
    Accel_Low_Noise.BFED.Sensitivity=[83,0,0;0,83,0;0,0,83];
    Accel_Low_Noise.BFED.Alignment=[-0.01,-1,0.02;-1,0,-0.01;0,-0.02,-1];
    
    Accel_Wide_Noise.g2.BFED.Offset=[-374;-346;-221];
    Accel_Wide_Noise.g2.BFED.Sensitivity=[1649,0,0;0,1687,0;0,0,1673];
    Accel_Wide_Noise.g2.BFED.Alignment=[-1,-0.01,0;0,1,-0.02;-0.01,-0.03,-1];
    
    Gyroscope.dps500.BFED.Offset=[-134;-2;36];
    Gyroscope.dps500.BFED.Sensitivity=[49.03,0,0;0,62.98,0;0,0,51.15];
    Gyroscope.dps500.BFED.Alignment=[0.01,-1,0.01;-1,0,0;0,-0.02,-1];
    
    Magnetometer.Ga1_3.BFED.Offset=[-2;610;-146];
    Magnetometer.Ga1_3.BFED.Sensitivity=[1232,0,0;0,1184,0;0,0,1103];
    Magnetometer.Ga1_3.BFED.Alignment=[-1,0,0;0,1,0;0,0,-1];
    
    
    
    Accel_Low_Noise.D54E.Offset=[2027;2008;2058];
    Accel_Low_Noise.D54E.Sensitivity=[82,0,0;0,83,0;0,0,83];
    Accel_Low_Noise.D54E.Alignment=[0,-1,0.02;-1,-0.01,0;0,-0.02,-1];
    
    Accel_Wide_Noise.g2.D54E.Offset=[-252;97;-193];
    Accel_Wide_Noise.g2.D54E.Sensitivity=[1680,0,0;0,1676,0;0,0,1666];
    Accel_Wide_Noise.g2.D54E.Alignment=[-1,-0.01,-0.02;-0,1,-0.02;-0,-0.02,-1];
    
    Gyroscope.dps500.D54E.Offset=[-42;20;100];
    Gyroscope.dps500.D54E.Sensitivity=[65.93,0,0;0,64.4,0;0,0,65.67];
    Gyroscope.dps500.D54E.Alignment=[0.01,-1,0.02;-1,0,-0.02;-0.02,-0.03,-1];
    
    Magnetometer.Ga1_3.D54E.Offset=[523;192;-365];
    Magnetometer.Ga1_3.D54E.Sensitivity=[683,0,0;0,686,0;0,0,574];
    Magnetometer.Ga1_3.D54E.Alignment=[-1,0,0;0,1,0;0,0,-1];
    
    
    
    Accel_Low_Noise.CE9F.Offset=[2023;2033;2046];
    Accel_Low_Noise.CE9F.Sensitivity=[83,0,0;0,82,0;0,0,82];
    Accel_Low_Noise.CE9F.Alignment=[0,-1,0.02;-1,-0.01,0.01;-0.01,-0.01,-1];
    
    Accel_Wide_Noise.g2.CE9F.Offset=[-245;-110;559];
    Accel_Wide_Noise.g2.CE9F.Sensitivity=[1643,0,0;0,1684,0;0,0,1706];
    Accel_Wide_Noise.g2.CE9F.Alignment=[-1,-0,0.01;0,1,-0.01;-0.01,-0.02,-1];
    
    Gyroscope.dps500.CE9F.Offset=[-6;-100;-10];
    Gyroscope.dps500.CE9F.Sensitivity=[64.91,0,0;0,65.55,0;0,0,65.55];
    Gyroscope.dps500.CE9F.Alignment=[0.01,-1,0.04;-1,-0.01,0;-0.03,0.01,-1];
    
    Magnetometer.Ga1_3.CE9F.Offset=[1093;-56;521];
    Magnetometer.Ga1_3.CE9F.Sensitivity=[686,0,0;0,674,0;0,0,607];
    Magnetometer.Ga1_3.CE9F.Alignment=[-1,0,0;0,1,0;0,0,-1];
    
    
    % Matrices calibracion por defecto
    
    Accel_Low_Noise.Offset=[2047;2047;2047];
    Accel_Low_Noise.Sensitivity=[83,0,0;0,83,0;0,0,83];
    Accel_Low_Noise.Alignment=[0,-1,0;-1,0,0;0,0,-1];
    
    Accel_Wide_Noise.g2.Offset=[0;0;0];
    Accel_Wide_Noise.g2.Sensitivity=[1631,0,0;0,1631,0;0,0,1631];
    Accel_Wide_Noise.g2.Alignment=[-1,0,0;0,1,0;0,0,-1];
    
    Gyroscope.dps500.Offset=[0;0;0];
    Gyroscope.dps500.Sensitivity=[65.50,0,0;0,65.50,0;0,0,65.50];
    Gyroscope.dps500.Alignment=[0,-1,0;-1,0,0;0,0,-1];
    
    Magnetometer.Ga1_3.Offset=[0;0;0;];
    Magnetometer.Ga1_3.Sensitivity=[1100,0,0;0,1100,0;0,0,980];
    Magnetometer.Ga1_3.Alignment=[-1,0,0;0,1,0;0,0,-1];
    
    num_imus= length(imus);
  
    for n=1:num_imus 
        imus_calibrados=imus;
        if imus{n}.Nombre=="BFED" || imus{n}.Nombre=="D54E" || imus{n}.Nombre=="CE9F"
            nom=imus{n}.Nombre;
            
            imus_calibrados{n}.Accel_LN=(Accel_Low_Noise.Sensitivity*Accel_Low_Noise.Alignment*imus{n}.Accel_LN'+Accel_Low_Noise.Offset)';
            imus_calibrados{n}.Accel_LN=(inv(Accel_Low_Noise.(nom).Alignment)*inv(Accel_Low_Noise.(nom).Sensitivity)*(imus_calibrados{n}.Accel_LN'-Accel_Low_Noise.(nom).Offset))';
            
            imus_calibrados{n}.Accel_WR=(Accel_Wide_Noise.g2.Sensitivity*(Accel_Wide_Noise.g2.Alignment)*imus{n}.Accel_WR'+Accel_Wide_Noise.g2.Offset)';
            imus_calibrados{n}.Accel_WR=(inv(Accel_Wide_Noise.g2.(nom).Alignment)*inv(Accel_Wide_Noise.g2.(nom).Sensitivity)*(imus_calibrados{n}.Accel_WR'-Accel_Wide_Noise.g2.(nom).Offset))';
            
            imus_calibrados{n}.Gyro=(Gyroscope.dps500.Sensitivity*(Gyroscope.dps500.Alignment)*imus{n}.Gyro'+Gyroscope.dps500.Offset)';
            imus_calibrados{n}.Gyro=(inv(Gyroscope.dps500.(nom).Alignment)*inv(Gyroscope.dps500.(nom).Sensitivity)*(imus_calibrados{n}.Gyro'-Gyroscope.dps500.(nom).Offset))';
            
%             imus_calibrados{n}.Mag=(Magnetometer.Ga1_3.Sensitivity*(Magnetometer.Ga1_3.Alignment)*imus{n}.Mag'+Magnetometer.Ga1_3.Offset)';
%             imus_calibrados{n}.Mag=(inv(Magnetometer.Ga1_3.(nom).Alignment)*inv(Magnetometer.Ga1_3.(nom).Sensitivity)*(imus_calibrados{n}.Mag'-Magnetometer.Ga1_3.(nom).Offset))';
            imus_calibrados{n}.Mag =  imus{n}.Mag;

            imus_calibrados{n}.Nombre=strcat(imus_calibrados{n}.Nombre,'_c');
        else
           
            imus_calibrados{n}.Accel_LN = imus{n}.Accel_LN ;
            imus_calibrados{n}.Accel_WR = imus{n}.Accel_WR ;
            imus_calibrados{n}.Gyro =  imus{n}.Gyro;
            imus_calibrados{n}.Mag =  imus{n}.Mag;
        end

    end 
end




