% funcion para la medicion de sensores shimmer

% puertos={'COM1','COM2',...};
% n_serie={}


function [datos]= leer_shimmer(puertos,n_serie,t)

    fclose('all');
    
    % conectamos los sensores
    for i=1:length(puertos)
        shimmer{i}=ShimmerHandleClass(puertos{i});
        
        while (~shimmer{i}.connect())
            disp('Error al conectar con el sensor. Se volvera a intentar')
        end
        
    end
    
    disp('Shimmers conectados')
    
    % configuramos los sensores
    for i=1:length(puertos)
        shimmer{i}.enabletimestampunix(1);
    end
    
    
    % inicio la lectura
    for i=1:length(puertos)
        if (~shimmer{i}.start())
            disp('Error al iniciar la medida')
            exit(1);
        end
        
        file{i}=fopen(strcat('Sensor_',n_serie{i},'.txt'),'w+');
        datos.(n_serie{i})=[];
    end
 
    % leemos
    for i=1:length(puertos)

        [newData,signalNameArray,~,~] = shimmer{i}.getdata('c');
         
        while( isempty(newData) )
        
            [newData,signalNameArray,~,~] = shimmer{i}.getdata('c');
          
            disp(strcat('no se reciben datos del sensor',num2str(i),' / ',num2str(length(puertos))))
            pause(1)
        end
        fprintf(file{i},'%s \t %s \t %s \t %s \t %s \t %s \t %s \t %s \t %s \t %s \t %s',...
           signalNameArray{1},signalNameArray{2},signalNameArray{3},signalNameArray{4},signalNameArray{5},signalNameArray{6},signalNameArray{7},signalNameArray{8},signalNameArray{9},signalNameArray{10},signalNameArray{11});
        fprintf(file{i},'\n');
    end
    disp('comienza a medir')
    
    for iter=1:t
        for i=1:length(puertos)   
               
            [newData,signalNameArray,signalFormatArray,signalUnitArray] = shimmer{i}.getdata('c');
           
            if(~isempty(newData))
                 for n=1:size(newData,1)
                    fprintf(file{i},'%f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f',...
                       newData(n,1),newData(n,2),newData(n,3),newData(n,4),newData(n,5),newData(n,6),newData(n,7),newData(n,8),newData(n,9),newData(n,10),newData(n,11));
                    fprintf(file{i},'\n');
                    datos.(n_serie{i})=[datos.(n_serie{i});newData];
                 end
            end
            
        end
        pause(1)
    end
    disp('Fin de mediccion')
    
    % Terminamos conexion
    for i=1:length(puertos)  
        shimmer{i}.stop;
        shimmer{i}.disconnect;
        fclose(file{i});
    
    end
    clear shimmer  
    
end