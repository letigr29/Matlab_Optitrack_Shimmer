 function quaternionData = quaternion_9DOF(med_imu,freq)
 
            % Updates quaternion data based on accelerometer, gyroscope and
            % magnetometer data inputs: accelCalibratedData,
            % gyroCalibratedData and magCalibratedData.
            %
            % Implementation of MARG algorithm from:
            % Madgwick, S.O.H.; Harrison, A. J L; Vaidyanathan, R., "Estimation of IMU and MARG orientation using a gradient descent algorithm,"
            % Rehabilitation Robotics (ICORR), 2011 IEEE International Conference on , vol., no., pp.1,7, June 29 2011-July 1 2011, doi: 10.1109/ICORR.2011.5975346
            
            accelCalibratedData=med_imu.Accel_LN;
            gyroCalibratedData=med_imu.Gyro;
            magCalibratedData=med_imu.Mag;
            
            numSamples = size(accelCalibratedData,1);
            quaternionData = zeros(numSamples,4);
            
            % Normalise accelerometer and magnetometer data.
            accelMagnitude = sqrt(sum(accelCalibratedData.^2,2));
            magMagnitude = sqrt(sum(magCalibratedData.^2,2));
            
            if(min(accelMagnitude) ~= 0 && min(magMagnitude) ~= 0)
                accelNormalised = accelCalibratedData./repmat(accelMagnitude,1,3);
                magNormalised = magCalibratedData./repmat(magMagnitude,1,3);
                
                previousQuaternion = [0.5, 0.5, 0.5, 0.5];
                
                iSample = 1;
                
                while(iSample <= numSamples)
                    q1 = previousQuaternion(1);
                    q2 = previousQuaternion(2);
                    q3 = previousQuaternion(3);
                    q4 = previousQuaternion(4);
                    
                    ax = accelNormalised(iSample,1);
                    ay = accelNormalised(iSample,2);
                    az = accelNormalised(iSample,3);
                    mx = magNormalised(iSample,1);
                    my = magNormalised(iSample,2);
                    mz = magNormalised(iSample,3);
                    gx = gyroCalibratedData(iSample,1)/180*pi;
                    gy = gyroCalibratedData(iSample,2)/180*pi;
                    gz = gyroCalibratedData(iSample,3)/180*pi;
                    
                    q1q1 = q1*q1;
                    q2q2 = q2*q2;
                    q3q3 = q3*q3;
                    q4q4 = q4*q4;
                    
                    twoq1 = 2*q1;
                    twoq2 = 2*q2;
                    twoq3 = 2*q3;
                    twoq4 = 2*q4;
                    
                    q1q2 = q1*q2;
                    q1q3 = q1*q3;
                    q1q4 = q1*q4;
                    q2q3 = q2*q3;
                    q2q4 = q2*q4;
                    q3q4 = q3*q4;
                    
                    % Calculate reference direction of Earth's magnetic
                    % field.
                    hx = mx*(q1q1 + q2q2 - q3q3-q4q4) + 2*my*(q2q3 - q1q4) + 2*mz*(q2q4 + q1q3);
                    hy = 2*mx*(q1q4 + q2q3) + my*(q1q1 - q2q2 + q3q3 - q4q4) * 2*mz*(q3q4 - q1q2);
                    twobx = sqrt(hx^2 + hy^2); % horizontal component
                    twobz = 2*mx*(q2q4 - q1q3) + 2*my*(q1q2 + q3q4) + mz*(q1q1 - q2q2 - q3q3 + q4q4); % vertical component
                    
                    % Calculate corrective step for gradient descent
                    % algorithm.
                    s1 = -twoq3 * (2*(q2q4 - q1q3) - ax) + ...
                        twoq2*(2*(q1q2 + q3q4) - ay) - ...
                        twobz*q3*(twobx*(0.5 - q3q3 - q4q4) + twobz*(q2q4 - q1q3) - mx) + ...
                        (-twobx*q4 + twobz*q2)*(twobx*(q2q3 - q1q4) + twobz*(q1q2 + q3q4) - my) + ...
                        twobx*q3*(twobx*(q1q3 + q2q4) + twobz*(0.5 - q2q2 - q3q3) - mz);
                    
                    s2 = twoq4*(2*(q2q4 - q1q3) - ax) + ...
                        twoq1*(2*(q1q2 + q3q4) - ay) - ...
                        4*q2*(1 - 2*(q2q2 + q3q3) - az) + ...
                        twobz*q4*(twobx*(0.5 - q3q3 - q4q4) + twobz*(q2q4 - q1q3) - mx) + ...
                        (twobx*q3 + twobz*q1)*(twobx*(q2q3 - q1q4) + twobz*(q1q2 + q3q4) - my) + ...
                        (twobx*q4 - twobz*twoq2)*(twobx*(q1q3 + q2q4) + twobz*(0.5 - q2q2 - q3q3) - mz);
                    
                    s3 = -twoq1*(2*(q2q4 - q1q3) - ax) + ...
                        twoq4*(2*(q1q2 + q3q4) - ay) - ...
                        4*q3*(1 - 2*(q2q2 + q3q3) - az) + ...
                        (-twobx*twoq3 - twobz*q1)*(twobx*(0.5 - q3q3 - q4q4) + twobz*(q2q4 - q1q3) - mx) + ...
                        (twobx * q2 + twobz * q4)*(twobx*(q2q3 - q1q4) + twobz*(q1q2 + q3q4) - my) + ...
                        (twobx * q1 - twobz*twoq3)*(twobx*(q1q3 + q2q4) + twobz*(0.5 - q2q2 - q3q3) - mz);
                    
                    s4 = twoq2 * (2.0 * (q2q4 - q1q3) - ax) + ...
                        twoq3 * (2*(q1q2 + q3q4) - ay) + ...
                        (-twobx * twoq4 + twobz * q2) * (twobx * (0.5 - q3q3 - q4q4) + twobz * (q2q4 - q1q3) - mx) + ...
                        (-twobx * q1 + twobz * q3) * (twobx * (q2q3 - q1q4) + twobz * (q1q2 + q3q4) - my) + ...
                        twobx * q2 * (twobx * (q1q3 + q2q4) + twobz * (0.5 - q2q2 - q3q3) - mz);
                    
                    sNormalised = [s1, s2, s3, s4]/sqrt(sum([s1 s2 s3 s4].^2));
                    
                    % Rate of change from gyro values...
                    dqdt(1) = 0.5 * (-q2 * gx - q3 * gy - q4 * gz);
                    dqdt(2) = 0.5 * ( q1 * gx - q4 * gy + q3 * gz);
                    dqdt(3) = 0.5 * ( q4 * gx + q1 * gy - q2 * gz);
                    dqdt(4) = 0.5 * (-q3 * gx + q2 * gy + q1 * gz);
                    
                    % ...plus rate of change from gradient descent step.
                    beta = 0.5;
                    dqdt = dqdt - beta*sNormalised;
                    
                    tempQuaternion = previousQuaternion + dqdt./freq;
                    quaternionData(iSample, :) = tempQuaternion/(sqrt(sum(tempQuaternion.^2)));
                    
                    previousQuaternion = quaternionData(iSample, :);
                    iSample = iSample + 1;
                end
       
            end
            
        end %function updatequaternion