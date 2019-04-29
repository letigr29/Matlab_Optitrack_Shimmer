
function []= plot_camara(medicion,forma,ejes)

    % argumentos por defecto
    if (nargin<2)
		forma = struct('p1',[50,0,50],'p2',[-50,0,50],...
           'p3',[0,0,-50]); 
       ejes=[0 1200 -600 -0 0 1000];
	elseif (nargin<3)
       ejes=[500 1200 -600 -0 0 1000];
    end
    rigid_bodies = fieldnames(medicion.Rigid_Body);
    rigid_body_markers=fieldnames(medicion.Rigid_Body_Marker);
    colores={'r','b','g','m','c','y','r','b','g','m','c','y','r','b','g','m','c','y'};
    
    % controles
    f=figure('Position',[200 200 1300 500]);
    ax1=subplot('position',[0.1 0.26  0.20 0.7]);
    ax21=subplot('position',[0.45 0.66  0.30 0.2]);
    ax22=subplot('position',[0.45 0.38  0.30 0.2]);
    ax23=subplot('position',[0.45 0.1  0.30 0.2]);
    
    b = uicontrol('Parent',f,'Style','slider','Position',[100,54,400,23],...
              'value',1, 'min',1, 'max',length(medicion.tiempo)-25);
    b2 = uicontrol('Parent',f,'Style','popupmenu','Position',[100,24,60,23],...
              'String',{'x1' 'x2' 'x3' 'x4' 'x5'});      
    b3 = uicontrol('Parent',f,'Style','togglebutton','Position',[300,24,60,23],...
              'String','Pausa','value',1);
    bl1 = uicontrol('Parent',f,'Style','text','Position',[20,50,60,23],...
                'String','Frame:');
    bl2 = uicontrol('Parent',f,'Style','text','Position',[20,20,60,23],...
                'String','Velocidad:');
            
    panel_markers = uipanel(f,'Position',[0.77 0.05 0.20 0.90]);        
    pos=400;
    for rb=1:length(rigid_body_markers')        
        check_marker{rb} = uicontrol(panel_markers,'Style','checkbox','Position',[10,pos,200,23],...
              'String',rigid_body_markers{rb} );      
          pos=pos-30;
    end       
    % bucle principal
    
    while true
        
        t=round(b.Value);
        multi=b2.Value;
        
        if(b3.Value)
            hold(ax1, 'off');
            for rb=rigid_bodies'
                
                quaternion=medicion.Rigid_Body.(rb{1}).Rotation(t,:) ;

                forma_rotada.p1 = quatrotate(quaternion, forma.p1)*[1 0 0; 0 0 1; 0 -1 0];
                forma_rotada.p2 = quatrotate(quaternion, forma.p2)*[1 0 0; 0 0 1; 0 -1 0];
                forma_rotada.p3 = quatrotate(quaternion, forma.p3)*[1 0 0; 0 0 1; 0 -1 0];


                posicion= medicion.Rigid_Body.(rb{1}).Position(t,:)*[1 0 0; 0 0 1; 0 -1 0];% cambio de base entre sistema de coordenadas de las camaras al de matlab

    %           
                
                plot3(ax1,posicion(1)+[forma_rotada.p1(1), forma_rotada.p2(1)],...
                    posicion(2)+[forma_rotada.p1(2), forma_rotada.p2(2)],...
                    posicion(3)+[forma_rotada.p1(3),forma_rotada.p2(3)],'-k','LineWidth',2)
                hold(ax1, 'on');
                plot3(ax1,posicion(1)+[forma_rotada.p2(1), forma_rotada.p3(1)],...
                    posicion(2)+[forma_rotada.p2(2), forma_rotada.p3(2)],...
                    posicion(3)+[forma_rotada.p2(3),forma_rotada.p3(3)],'-k','LineWidth',2)
                plot3(ax1,posicion(1)+[forma_rotada.p3(1), forma_rotada.p1(1)],...
                    posicion(2)+[forma_rotada.p3(2), forma_rotada.p1(2)],...
                   posicion(3)+[forma_rotada.p3(3),forma_rotada.p1(3)],'-k','LineWidth',2)

                grid(ax1,'on')
                axis(ax1,'equal',ejes)
                
                
                
                for i=1:length(rigid_body_markers)
                    if check_marker{i}.Value
                        plot(ax21,medicion.Rigid_Body_Marker.(rigid_body_markers{i}).Position(:,1),'-k','LineWidth',1)
                         hold(ax21,'on')
                         plot(ax21,medicion.Marker.(rigid_body_markers{i}).Position(:,1),strcat('-',colores{i}),'LineWidth',1)
                         plot(ax21,ones(2,1)*t,[0,1500],'-k','LineWidth',1)
                        plot(ax22,medicion.Rigid_Body_Marker.(rigid_body_markers{i}).Position(:,2),'-k','LineWidth',1)
                         hold(ax22,'on')
                         plot(ax22,medicion.Marker.(rigid_body_markers{i}).Position(:,2),strcat('-',colores{i}),'LineWidth',1)
                         plot(ax22,ones(2,1)*t,[0,1500],'-k','LineWidth',1)
                        plot(ax23,medicion.Rigid_Body_Marker.(rigid_body_markers{i}).Position(:,3),'-k','LineWidth',1)
                         hold(ax23,'on')
                         plot(ax23,medicion.Marker.(rigid_body_markers{i}).Position(:,3),strcat('-',colores{i}),'LineWidth',1)
                         plot(ax23,ones(2,1)*t,[0,1500],'-k','LineWidth',1)
                    end
                end

                
                grid(ax21,'on')
                grid(ax22,'on')
                grid(ax23,'on')
                hold(ax21,'off')
                hold(ax22,'off')
                hold(ax23,'off')
                
    %             axis(ax1,'equal',ejes)

            end
%             drawnow
%               pause(0.05)
        
            if t>=length(medicion.tiempo)-5*multi
                b.Value=1;
            else
                b.Value=round(b.Value)+5*multi;
            end
            
        end
        drawnow
    end

end

