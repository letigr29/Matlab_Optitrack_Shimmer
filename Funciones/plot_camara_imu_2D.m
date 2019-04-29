
% funcion para la representacion y analisis de los datos de las camaras y
% los sensores inerciales

% med_cam: estructura que contiene los datos de las camaras
% med_imu:= {med_imu1, med_imu2...}estructura que contiene los datos de
%    los imus
% forma:= conjunto de puntos que se utilizaran para representar los
%   sensores en el plot3D
% ejes:= limites de los ejes

function []= plot_camara_imu_2D(med_cam,med_imu,senhales,forma,ejes)

    % argumentos por defecto
    if (nargin<4)
		forma = struct('p1',[50,0,50],'p2',[-50,0,50],...
           'p3',[0,0,-50]); 
       ejes=[0 1200 -600 -0 0 1000];
	elseif (nargin<5)
       ejes=[500 1200 -600 -0 0 1000];
    end
    
    % variables
    num_imus= length(med_imu);
    clear nombres_imus;

    for n=1:num_imus % igualamos frecuencias de los imus con las camaras
        nombres_imus{n}=med_imu{n}.Nombre;
    end
    
    
    rigid_bodies = fieldnames(med_cam.Rigid_Body);
    rigid_body_markers=fieldnames(med_cam.Rigid_Body_Marker);
    colores={'r','b','g','m','c','y','r','b','g','m','c','y','r','b','g','m','c','y','r','b','g','m','c','y','r','b','g','m','c','y','r','b','g','m','c','y'};
    
    
    datos=med_cam;
    for i=1:length(nombres_imus)
         datos.imus.(nombres_imus{i})= med_imu{i};
    end
    
    items_2D={};
    fields_datos=fieldnames(datos);
    for i1=2:length(fields_datos)
        fields2_datos=fieldnames(datos.(fields_datos{i1}));  
        for i2=1:length(fields2_datos)
            fields3_datos=fieldnames(datos.(fields_datos{i1}).(fields2_datos{i2}));
            for i3=1:length(fields3_datos)
                items_2D{end+1}= strcat((fields_datos{i1}),'.',(fields2_datos{i2}),'.',(fields3_datos{i3}));
            end
        end
    end
    items_2D_selec=zeros(1,length(items_2D));
    
    % controles
    f=figure('Position',[200 100 1300 700]);
    ax_2D=axes('units','pixels','position',[100 290 1100 325]);
    list_2D=uicontrol('Parent',f,'Style','listbox','position',[100 50 450 200],'String',items_2D,'Callback',@selection_2D);
          
    function selection_2D(src,event)
        val = list_2D.Value;
        if(items_2D_selec(val))
            items_2D_selec(val)=0;
        else
            items_2D_selec(val)=1;
        end
        
        cla(ax_2D)
        hold(ax_2D,'off')
        leg=[];       
        color=1;
        for i=1:length(items_2D_selec)
            clear split_dot
            split_dot=strsplit(items_2D{i},'.');
            dato=datos.(split_dot{1}).(split_dot{2}).(split_dot{3});
            if items_2D_selec(i) && isnumeric(dato)
                for l=1:size(dato,2)
                plot(ax_2D,dato(:,l),colores{color},'LineWidth',2)
                 color=color+1;
                hold(ax_2D,'on')
                leg{end+1}=strcat(items_2D{i},'.',num2str(l));
                end
%                 color=color+1;
            end
        end

        legend(leg,'units','pixels','Position',[600 50 450 200]);    
        drawnow 
    end
    
end

