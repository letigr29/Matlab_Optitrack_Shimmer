
clc
clear all

% Código para reiniciary leer datos del sick.
% Lectura por sondeo y lectura continua

%%%%%% mensajes recibidos

% msg={'02' '80' '17' '00' '90'... 
%     '4C' '4D' '53' '32' '30' '30' '3B' '33' '30' '31' '30' '36' '33' '3B' '56' '30' '32' '2E' '31' '30' '20' '10'...
%     '63' '5E'};% Power-on
%  
% msg={'02' '80' '03' '00' '06'...
%     '00' '10'...
%     '16' '0A'}%ack
% 
% msg={'02' '80' '03' '00' 'A0'...
%     '00' '10'...
%     '16' '0A'}% respuesta a comando Installation Mode correcto

%%%%%% mensajes a enviar

% msg={'02' '00' '0A' '00' '20'...
%     '00' '53' '49' '43' '4B' '5F' '4C' '4D' '53'...
%     'BE' 'C5'}; % entrar en Installation Mode y enviar contraseña
% 
% msg={'02' '00' '02' '00' '20'...
%     '24'...
%     '34' '08'}; % entrar en monitoring mode (25 por sondeo, 24 constante)
% 
% msg={'02' '00' '02' '00' '30'...
%     '01'...
%     '31' '18'} %solicitar dato
% 
% msg={'02' '00' '01' '00' '10' '34' '12'} % reset

%% incializamos el puerto serie

x=serial('COM3');
x.InputBufferSize=733; % tamaño del buffer de entrada 
fopen(x);


%% Reinciamos el sick para restablecer los parametros de configuración

msg={'02' '00' '01' '00' '10' '34' '12'}; % reset
h=hex2dec(msg);

x.Timeout=10;
fwrite(x,h,'uint8','async');
pause(0.1)

% aseguramos que el buffer esta vacio

  while (x.BytesAvailable>0)
        % Vaciar el puerto 
        % OJO!!! Los datos se perderan
        disp(['>>> AVISO: Se descartaran ' int2str(x.BytesAvailable) ' datos']);
        fread(x, x.BytesAvailable,'uint8');
        pause(0.1)
  end
  

%% Lectura por sondeo

desp_X=[];
desp_Y=[];

msg={'02' '00' '02' '00' '30'...
    '01'...
    '31' '18'}; %solicitar dato

h=hex2dec(msg);
ang=0:pi/361:pi;

for iter=1:100
   fwrite(x,h,'uint8','async');

    % Se espera a recibir la contestacion
  
    [ack1,cnt,ms]=fread(x,733,'uint8');
    
    data=ack1(7:end-3);
    len=length(data);
    dis=[];

    for i=1:2:len
        dis=[dis data(i)+data(i+1)*256];
    end
    
    X=cos(ang).*dis;
    Y=sin(ang).*dis;
    
    plot(X,Y)
    axis equal 
    grid on

    hold off
    pause(1/100)
    
    iter
end

%% Lectura constante

msg={'02' '00' '02' '00' '20'...
    '24'...
    '34' '08'}; %Lectura constante

h=hex2dec(msg);
fwrite(x,h,'uint8','async');

ack=[];
while true

    if x.BytesAvailable>0
        % Se espera a recibir la contestacion
        [ack1,cnt,ms]=fread(x,x.BytesAvailable,'uint8');
        ack=[ack ; ack1];
        ack_hex=dec2hex(ack)';
        
        ind_cabecera=strfind(ack_hex(:)','0280D602B0');
        
        if length(ind_cabecera)>1
        
            data=ack((ind_cabecera(1)+1)/2+5:(ind_cabecera(1)+1)/2+5+724-1);
            
            ack=ack((ind_cabecera(1)+1)/2+5+724:end);
            len=length(data);

            dis=[];

            for i=1:2:len
                dis=[dis data(i)+data(i+1)*256];
            end
 
            ang=0:pi/361:pi;
            X=cos(ang).*dis;
            Y=sin(ang).*dis;
   
            plot(X,Y,'r', 'LineWidth',2)
            axis([-10000 10000 0 10000])
            hold off
            
            pause(0.01)
            
        end
    end
end

