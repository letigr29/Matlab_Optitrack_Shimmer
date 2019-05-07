function [imus_calibrados]= calibracion_shimmer(imus)

    BFED.Accel_Low_Noise.Offset=[2042;2020;2024];
    BFED.Accel_Low_Noise.Sensitivity=[83,0,0;0,83,0;0,0,83];
    BFED.Accel_Low_Noise.Alignment=[-0.01,-1,0.02;-1,0,-0.01;0,-0.02,-1];
    
    BFED.Accel_Wide_Noise.g2.Offset=[-374;-346;-221];
    BFED.Accel_Wide_Noise.g2.Sensitivity=[1649,0,0;0,1687,0;0,0,1673];
    BFED.Accel_Wide_Noise.g2.Alignment=[-1,-0.01,0;0,1,-0.02;-0.01,-0.03,-1];
    
    BFED.Gyroscope.dps500.Offset=[-134;-2;36];
    BFED.Gyroscope.dps500.Sensitivity=[49.03,0,0;0,62.98,0;0,0,51.15];
    BFED.Gyroscope.dps500.Alignment=[0.01,-1,0.01;-1,0,0;0,-0.02,-1];
    
    BFED.Magnetometer.Ga1_3.Offset=[-804;405;-400];
    BFED.Magnetometer.Ga1_3.Sensitivity=[707,0,0;0,736,0;0,0,620];
    BFED.Magnetometer.Ga1_3.Alignment=[-1,0,0;0,1,0;0,0,-1];
    
    
    
    D54E.Accel_Low_Noise.Offset=[2027;2008;2058];
    D54E.Accel_Low_Noise.Sensitivity=[82,0,0;0,83,0;0,0,83];
    D54E.Accel_Low_Noise.Alignment=[0,-1,0.02;-1,-0.01,0;0,-0.02,-1];
    
    D54E.Accel_Wide_Noise.g2.Offset=[-252;97;-193];
    D54E.Accel_Wide_Noise.g2.Sensitivity=[1680,0,0;0,1676,0;0,0,1666];
    D54E.Accel_Wide_Noise.g2.Alignment=[-1,-0.01,-0.02;-0,1,-0.02;-0,-0.02,-1];
    
    D54E.Gyroscope.dps500.Offset=[-42;20;100];
    D54E.Gyroscope.dps500.Sensitivity=[65.93,0,0;0,64.4,0;0,0,65.67];
    D54E.Gyroscope.dps500.Alignment=[0.01,-1,0.02;-1,0,-0.02;-0.02,-0.03,-1];
    
    D54E.Magnetometer.Ga1_3.Offset=[523;192;-365];
    D54E.Magnetometer.Ga1_3.Sensitivity=[683,0,0;0,686,0;0,0,574];
    D54E.Magnetometer.Ga1_3.Alignment=[-1,0,0;0,1,0;0,0,-1];
    
    
    
    CE9F.Accel_Low_Noise.Offset=[2023;2033;2046];
    CE9F.Accel_Low_Noise.Sensitivity=[83,0,0;0,82,0;0,0,82];
    CE9F.Accel_Low_Noise.Alignment=[0,-1,0.02;-1,-0.01,0.01;-0.01,-0.01,-1];
    
    CE9F.Accel_Wide_Noise.g2.Offset=[-245;-110;559];
    CE9F.Accel_Wide_Noise.g2.Sensitivity=[1643,0,0;0,1684,0;0,0,1706];
    CE9F.Accel_Wide_Noise.g2.Alignment=[-1,-0,0.01;0,1,-0.01;-0.01,-0.02,-1];
    
    CE9F.Gyroscope.dps500.Offset=[-6;-100;-10];
    CE9F.Gyroscope.dps500.Sensitivity=[64.91,0,0;0,65.55,0;0,0,65.55];
    CE9F.Gyroscope.dps500.Alignment=[0.01,-1,0.04;-1,-0.01,0;-0.03,0.01,-1];
    
    CE9F.Magnetometer.Ga1_3.Offset=[1093;-56;521];
    CE9F.Magnetometer.Ga1_3.Sensitivity=[686,0,0;0,674,0;0,0,607];
    CE9F.Magnetometer.Ga1_3.Alignment=[-1,0,0;0,1,0;0,0,-1];
    
    
    
    
end