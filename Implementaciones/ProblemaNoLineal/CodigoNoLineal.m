function [XB,Z]=CodigoNoLineal(y)
    %{
    Problema No Lineal: 14800x1 + 9500x2 + 4600x3 -
    (70(15-2y1)x1 + 70(10-1.5y1)x2 +70(5-0.5y1)x3 + 850y1 +85900)

    Restricciones:

    r(1) : 8446x1 + 3175x2 + 1588x3<= 70000
    r(2) : 26.8x1 + 8.3x2 + 4.3x3<=470
    r(3) : x1 + x2 + x3<=27
    r(4) : x1 + x3<=13
    r(5) : 1<=x1<=8 
    r(6) : 3<=x2<=10
    r(7) : 5<=x3<=13
    r(8) : 0<=y1<=6

    Se usará la funcion fmincon para encontrar el punto óptimo al problema
    F.O es no lineal
    Todas las restricciones son lineales                                
    %}

    %Limpiar el espacio de trabajo
%     clear all
%     clc
    rest1= { 'Restricciones:'

            'r(1) : 8446x1 + 3175x2 + 1588x3<= 70000'
            'r(2) : 26.8x1 + 8.3x2 + 4.3x3<=470'
            'r(3) : x1 + x2 + x3<=27'
            'r(4) : x1 + x3<=13'
            'r(5) : 1<=x1<=8 '
            'r(6) : 3<=x2<=10'
            'r(7) : 5<=x3<=13'
            'r(8) : 0<=y1<=6}'};
        
    rest2={ 'Restricciones:'

            'r(1) : 8446x1 + 3175x2 + 1588x3<= 70000'
            'r(2) : 26.8x1 + 8.3x2 + 4.3x3<=470'
            'r(3) : x1 + x2 + x3<=27'
            'r(4) : x1 + x3<=13'
            'r(5) : x1 + x2<=12'
            'r(6) : x2 + x3<=16'
            'r(7) : 1<=x1<=8 '
            'r(8) : 3<=x2<=10'
            'r(9) : 5<=x3<=13'
            'r(10) : 0<=y1<=6'};
    % x4: y1

    %Funcion Objetivo Original:
    fun = @(x) -((14800*x(1) + 9500*x(2) + 4600*x(3)) - (70*(15-2*x(4))*x(1) + 70*(10-1.5*x(4))*x(2) + 70*(5-0.5*x(4))*x(3) + 850*x(4) + 85900));



    %Funcion Objetivo cuando el salario de los trabajadores extra aumenta:
    fun2 = @(x) -((14800*x(1) + 9500*x(2) + 4600*x(3)) - (70*(15-2*x(4))*x(1) + 70*(10-1.5*x(4))*x(2) + 70*(5-0.5*x(4))*x(3) + 1800*x(4) + 85900));


    %Funcion Objetivo cuando se cambia el precio de transporte de cada caja:
    fun3 = @(x) -((24000*x(1) + 8000*x(2) + 6000*x(3)) - (70*(15-2*x(4))*x(1) + 70*(10-1.5*x(4))*x(2) + 70*(5-0.5*x(4))*x(3) + 850*x(4) + 85900));
    %{
    Precio de transporte por cada caja grande  (x1) : $24000
    Precio de transporte por cada caja mediana (x2) : $8000
    Precio de transporte por cada caja pequeña (x3) : $6000
    ***El precio está en dolares***
    %}



    %{
    Matriz de restricciones:
    Las filas representan las restricciones

    Columna 1: x1
    Columna 2: x2
    Columna 3: x3
    Columna 4: y1
    %}

    %Esta matriz se usa para el problema original
    A1=[8446, 3175, 1588,  0;
        26.8,  8.3,  4.3,  0;
         1,     1,    1,  0;
         1,     0,    1,  0;
         1,     0,    0,  0;
        -1,     0,    0,  0;
         0,     1,    0,  0;
         0,    -1,    0,  0;
         0,     0,    1,  0;
         0,     0,   -1,  0;
         0,     0,    0,  1;
         0,     0,    0, -1];



    %Lado derecho de las restricciones para el problema original
    b1=[70000; 470; 27; 13; 8; -1; 10; -3; 13; -5; 6; 0];



    %{
    -----------PROBLEMA LINEAL CON DOS RESTRICCIONES NUEVAS-------------
    F.O: 14800x1 + 9500x2 + 4600x3 -
    (70(15-2y1)x1 + 70(10-1.5y1)x2 +70(5-0.5y1)x3 + 850y1 +85900)

    Restricciones:

    r(1) : 8446x1 + 3175x2 + 1588x3<= 70000
    r(2) : 26.8x1 + 8.3x2 + 4.3x3<=470
    r(3) : x1 + x2 + x3<=27
    r(4) : x1 + x3<=13
    r(5) : x1 + x2<=12
    r(6) : x2 + x3<=16
    r(7) : 1<=x1<=8 
    r(8) : 3<=x2<=10
    r(9) : 5<=x3<=13
    r(10) : 0<=y1<=6

    IMPORTANTE: Cuando se consideran las dos restricciones nuevas, se trabaja
    con la funcion original, es decir, la variable fun

    %}


    %Esta matriz se usa para el problema con las dos restricciones adicionales
    A2=[8446, 3175, 1588,  0;
       26.8,  8.3,  4.3,  0;
         1,     1,    1,  0;
         1,     0,    1,  0;
         1,     1,    0,  0;
         0,     1,    1,  0;
         1,     0,    0,  0;
        -1,     0,    0,  0;
         0,     1,    0,  0;
         0,    -1,    0,  0;
         0,     0,    1,  0;
         0,     0,   -1,  0;
         0,     0,    0,  1;
         0,     0,    0, -1];


    %Lado derecho de las restricciones de desigualdad:
    b2=[70000; 470; 27; 13; 12; 16; 8; -1; 10; -3; 13; -5; 6; 0];


    %Punto de arranque (se escoge de manera aleatoria):
    x0=[randi([1 8],1,1), randi([3 10],1,1), randi([5 13],1,1), randi([1 5],1,1)];


    %Puesto que no hay restricciones de igualdad o no lineales, se
    %inicializan en vacio los siguientes vectores:
    Aeq=[];
    beq=[];
    lb=[];
    ub=[];
    nonlcon=[];

    
    %Opciones para resolver el problema por medio de conjuntos activos, además
    %de ver el algoritmo realizado en cada iteracion
    options = optimoptions('fmincon','Display','iter','Algorithm','active-set'); 
    
    if y==1
        
        funcion=func2str(fun);
        message=['\nFuncion Objetivo: \nf(x)= ',funcion(5:length(funcion)),'\n\n'];
        fprintf(message);
        fprintf('%s\n',rest1{:});
        

        x = fmincon(fun,x0,A1,b1,Aeq,beq,lb,ub,nonlcon,options);
        XB=round(x);
        Z=-round(fun(XB));

    elseif y==2
        
        funcion=func2str(fun2);
        message=['\nFuncion Objetivo: \nf(x)= ',funcion(5:length(funcion)),'\n'];
        fprintf(message);
        fprintf('%s\n',rest1{:});
 
        
        x=fmincon(fun2,x0,A1,b1,Aeq,beq,lb,ub,nonlcon,options);
        XB=round(x);
        Z=-round(fun2(XB));
    elseif y==3
        
        funcion=func2str(fun3);
        message=['\nFuncion Objetivo: \nf(x)= ',funcion(5:length(funcion)),'\n'];
        fprintf(message);
        fprintf('%s\n',rest1{:});
        
        
        x=fmincon(fun3,x0,A1,b1,Aeq,beq,lb,ub,nonlcon,options);
        XB=round(x);
        Z=-round(fun3(XB));
    elseif y==4
        
        funcion=func2str(fun);
        message=['\nFuncion Objetivo: \nf(x)= ',funcion(5:length(funcion)),'\n'];
        fprintf(message);
        fprintf('%s\n',rest2{:});   
        
        x=fmincon(fun,x0,A2,b2,Aeq,beq,lb,ub,nonlcon,options);
        XB=round(x);
        Z=-round(fun(XB));

    end


    %Se realiza aproximación subóptima
    

    %Valor de la función dado el punto optimo X
    
end 









