%cargar archivos csv de las camaras Optitrack
%
% file: archivo a cargar
% debe exportarse los datos usando el sistema de coordenadas global
% Ejemplo: [medicion]= cargar_datos_camara('medicion.csv')

function [medicion]= cargar_datos_camara(file)
    cabeceras=readtable(file, 'ReadVariableNames',false);
    tabla=csvread(file,7,0);
    
    % Se almacena los datos en la estructura medicion
    medicion=[];
    medicion.tiempo=tabla(:,2)*1000;
    [valores_unicos, ind_unicos] = unique( cabeceras{4,:});
    
    for i=3:size(tabla,2)
        if isfield(medicion,(replace(cabeceras{1,i}{1},{' ',':'},'_')))
            if isfield(medicion.(replace(cabeceras{1,i}{1},{' ',':'},'_')),(replace(cabeceras{2,i}{1},{' ',':'},'_')))
                if isfield(medicion.(replace(cabeceras{1,i}{1},{' ',':'},'_')).(replace(cabeceras{2,i}{1},{' ',':'},'_')),(replace(cabeceras{4,i}{1},{' ',':'},'_')))
                    medicion.(replace(cabeceras{1,i}{1},{' ',':'},'_')).(replace(cabeceras{2,i}{1},{' ',':'},'_')).(replace(cabeceras{4,i}{1},{' ',':'},'_'))=[...
                        medicion.(replace(cabeceras{1,i}{1},{' ',':'},'_')).(replace(cabeceras{2,i}{1},{' ',':'},'_')).(replace(cabeceras{4,i}{1},{' ',':'},'_')) tabla(:,i)];
                else
                    medicion.(replace(cabeceras{1,i}{1},{' ',':'},'_')).(replace(cabeceras{2,i}{1},{' ',':'},'_')).(replace(cabeceras{4,i}{1},{' ',':'},'_'))=tabla(:,i);
                end
            else
                medicion.(replace(cabeceras{1,i}{1},{' ',':'},'_')).(replace(cabeceras{2,i}{1},{' ',':'},'_')).(replace(cabeceras{4,i}{1},{' ',':'},'_'))=tabla(:,i);
            end
        else
            medicion.(replace(cabeceras{1,i}{1},{' ',':'},'_')).(replace(cabeceras{2,i}{1},{' ',':'},'_')).(replace(cabeceras{4,i}{1},{' ',':'},'_'))=tabla(:,i);
        end
    end
    

%      rigid_body_markers=fieldnames(medicion.Rigid_Body_Marker);
%       for i=1:length(rigid_body_markers)
%           
%           medicion.Rigid_Body.RigidBody
%       end
end