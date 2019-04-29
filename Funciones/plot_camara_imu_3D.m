
% funcion para la representacion y analisis de los datos de las camaras y
% los sensores inerciales

% med_cam: estructura que contiene los datos de las camaras
% med_imu:= {med_imu1, med_imu2...}estructura que contiene los datos de
%    los imus
% forma:= conjunto de puntos que se utilizaran para representar los
%   sensores en el plot3D
% ejes:= limites de los ejes

function []= plot_camara_imu_3D(med_cam,med_imu,m_ali,forma,ejes)

    % argumentos por defecto
    if (nargin<4)
		forma = struct('p1',[0,0,50],'p2',[0,0,-50],...
           'p3',[0,50,0]); 
       ejes=[-500 1200 -1000 600 -500 1000];
	elseif (nargin<5)
       ejes=[-500 1200 -1000 600 -500 1000];
    end
    
    % variables
    num_imus= length(med_imu);
    clear nombres_imus;

    for n=1:num_imus % igualamos frecuencias de los imus con las camaras
        nombres_imus{n}=med_imu{n}.Nombre;
              
    end
   
    rigid_bodies = fieldnames(med_cam.Rigid_Body);
    rigid_body_markers=fieldnames(med_cam.Rigid_Body_Marker);
    colores={'r','b','g','m','c','y','r','b','g','m','c','y','r','b','g','m','c','y'};
    
    items_3D={nombres_imus{:},rigid_bodies{:}};%cell(1,length(nombres_imus)+length(rigid_bodies))};
    items_3D_selec=zeros(1,length(nombres_imus)+length(rigid_bodies));
    
    % controles
    f=figure('Position',[200 100 1000 800]);
    ax_3D=axes('units','pixels','position',[100 100 500 700]);
    time_control = uicontrol('Parent',f,'Style','slider','Position',[50,50,900,25],...
              'value',1, 'min',1, 'max',length(med_cam.tiempo)-25);
       
    list_3D=uicontrol('Parent',f,'Style','listbox','position',[675 200 250 550],'Max',3,'Min',0,'String',items_3D,'Callback',@selection_3D);
       
    function selection_3D(src,event)
        val = list_3D.Value;
        if(items_3D_selec(val))
            items_3D_selec(val)=0;
        else
            items_3D_selec(val)=1;
        end
        
    end

    bl2 = uicontrol('Parent',f,'Style','text','Position',[625,96,60,23],...
                'String','Velocidad:');
    b2 = uicontrol('Parent',f,'Style','popupmenu','Position',[700,100,60,23],...
              'String',{'x1' 'x2' 'x3' 'x4' 'x5'});      
    b3 = uicontrol('Parent',f,'Style','togglebutton','Position',[780,100,60,23],...
              'String','Pausa','value',1);

  
     
    % bucle principal
    
    while true
        
        t=round(time_control.Value);
        multi=b2.Value;
        
        if(b3.Value)
            hold(ax_3D, 'off');
            for rb=rigid_bodies'
                if  items_3D_selec(strcmp(rb,items_3D))
                quaternion= med_cam.Rigid_Body.(rb{1}).Rotation(t,:) ;
         
                forma_rotada.p1 = [1 0 0; 0 0 -1; 0 1 0]*quatrotate(quaternion, forma.p1)';
                forma_rotada.p2 = [1 0 0; 0 0 -1; 0 1 0]*quatrotate(quaternion, forma.p2)';
                forma_rotada.p3 = [1 0 0; 0 0 -1; 0 1 0]*quatrotate(quaternion, forma.p3)';


                posicion= [1 0 0; 0 0 -1; 0 1 0]*med_cam.Rigid_Body.(rb{1}).Position(t,:)';% cambio de base entre sistema de coordenadas de las camaras al de matlab
 
                plot3(ax_3D,posicion(1)+[forma_rotada.p1(1), forma_rotada.p2(1)],...
                    posicion(2)+[forma_rotada.p1(2), forma_rotada.p2(2)],...
                    posicion(3)+[forma_rotada.p1(3),forma_rotada.p2(3)],'-k','LineWidth',2)
                hold(ax_3D, 'on');
                plot3(ax_3D,posicion(1)+[forma_rotada.p2(1), forma_rotada.p3(1)],...
                    posicion(2)+[forma_rotada.p2(2), forma_rotada.p3(2)],...
                    posicion(3)+[forma_rotada.p2(3),forma_rotada.p3(3)],'-k','LineWidth',2)
                plot3(ax_3D,posicion(1)+[forma_rotada.p3(1), forma_rotada.p1(1)],...
                    posicion(2)+[forma_rotada.p3(2), forma_rotada.p1(2)],...
                   posicion(3)+[forma_rotada.p3(3),forma_rotada.p1(3)],'-k','LineWidth',2)
                
                xlabel(ax_3D,'X')
                ylabel(ax_3D,'Y')
                zlabel(ax_3D,'Z')
                grid(ax_3D,'on')
                axis(ax_3D,'equal',ejes)

                end
            end
            
             for i=1:num_imus 
                if  items_3D_selec(strcmp( nombres_imus{i},items_3D))
                    if ~isnan(med_imu{strcmp( nombres_imus{i},items_3D)}.Quat)
                      
                        quaternion=med_imu{strcmp( nombres_imus{i},items_3D)}.euler2quat(t,:) ;

                        forma_rotada.p1 = [1 0 0; 0 0 -1; 0 1 0]*quatrotate(quaternion, forma.p1)';
                        forma_rotada.p2 = [1 0 0; 0 0 -1; 0 1 0]*quatrotate(quaternion, forma.p2)';
                        forma_rotada.p3 = [1 0 0; 0 0 -1; 0 1 0]*quatrotate(quaternion, forma.p3)';

                        posicion=[1 0 0; 0 0 -1; 0 1 0]* med_cam.Rigid_Body.(rb{1}).Position(t,:)';% cambio de base entre sistema de coordenadas de las camaras al de matlab

                        plot3(ax_3D,posicion(1)+[forma_rotada.p1(1), forma_rotada.p2(1)],...
                            posicion(2)+[forma_rotada.p1(2), forma_rotada.p2(2)],...
                            posicion(3)+[forma_rotada.p1(3),forma_rotada.p2(3)],'-k','LineWidth',2)
                        hold(ax_3D, 'on');
                        plot3(ax_3D,posicion(1)+[forma_rotada.p2(1), forma_rotada.p3(1)],...
                            posicion(2)+[forma_rotada.p2(2), forma_rotada.p3(2)],...
                            posicion(3)+[forma_rotada.p2(3),forma_rotada.p3(3)],'-k','LineWidth',2)
                        plot3(ax_3D,posicion(1)+[forma_rotada.p3(1), forma_rotada.p1(1)],...
                            posicion(2)+[forma_rotada.p3(2), forma_rotada.p1(2)],...
                           posicion(3)+[forma_rotada.p3(3),forma_rotada.p1(3)],'-k','LineWidth',2)
                       
                        xlabel(ax_3D,'X')
                        ylabel(ax_3D,'Y')
                        zlabel(ax_3D,'Z')
                        grid(ax_3D,'on')
                        axis(ax_3D,'equal',ejes)
                
                    end
                end
             end

            if t>=length(med_cam.tiempo)-5*multi
                time_control.Value=1;
            else
                time_control.Value=round(time_control.Value)+5*multi;
            end
            
        end
        drawnow
    end

end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           

