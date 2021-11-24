
clear all
clc

%Matriz de restricciones
A=[8446, 3175, 1588,  0;
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
 
%Lado derecho de las restricciones
b=[70000; 470; 27; 13; 8; -1; 10; -3; 13; -5; 6; 0];

%Espacio de trabajo
Aw=[];w=[];

%Tamaño de la matriz de restricciones
[m,n]=size(A)
x0=[3 10 10 6];

%Variable para el desarrollo del algoritmo
intentar=true;

%Miu se inicializa negativo para que entre al while
miu=[-1];

%Criterio de parada: iter<10
iter=0;


while any(miu<0) && iter<10

    %x0=[1 3 5 0]
    iter=iter+1;
    
    %Busca restricciones activas dado X0
    if intentar
        disp("Soy x0")
        x0
        for i= 1:m
          aux=A(i,:)*x0';
           if aux==b(i)
              w=[w,i];
              Aw=[Aw;A(i,:)];
           end
        end
     end  

    w
    Aw

    %Proyector
    der=Aw' * inv((Aw*Aw'))*Aw
    P=eye(size(der,1))-der
    
    %Variable simbolicas para obtener el gradiente de la funcion
    %Y luego evaluarlo en x0
    
    syms x1 x2 x3 y1 alfa1
    fun =  -(14800*x1+ 9500*x2+ 4600*x3 -(70*(15-2*y1)*x1+ 70*(10-1.5*y1)*x2+ 70*(5-0.5*y1)*x3+ 850*y1+ 85000 + 900))
    %gd=  gradient(fun,[x1,x2,x3,y1])
    grad1(y1) =  gradient(fun,x1)
    grad2(y1) =  gradient(fun,x2)
    grad3(y1) =  gradient(fun,x3)
    grad4(x1,x2,x3) =  gradient(fun,y1)
    gradiente=[grad1(x0(4)) , grad2(x0(4)), grad3(x0(4)), grad4(x0(1),x0(2),x0(3))]

    %Dirección
    D=-P*gradiente'
    
    %Caso 1:
    if D==0
        miu=-inv(Aw*Aw')*Aw*gradiente'
        %Si miu es positivo o igual a cero, el algoritmo acaba
        if miu>=0
            break
        else
        %De otra manera, saca de w la variable dual mas negativa
            [m,i] = min(A);
            w(i)=[]
            intentar=false;
        end
    else
        %Caso2: Miu negativo
        
        %X + alfa*D
        temp=x0'+alfa1*D
        intentar=true;
        
        %Restricciones evaluadas en X+alfa*D
        Atemp=[]; alfa=[]; Atemp2=[];
        for i= 1:size(A,1)
          aux=A(i,:)*temp<=b(i);
          Atemp2=[Atemp2,aux];
        end
        
        %Encontrar alfa:
        %Resolver las restricciones para alfa
        As= solve(Atemp2,alfa1,'ReturnConditions',true); 
        a = As.conditions
        a=char(a)
        
        %Extraer el alfa maximo
        newStr = extractAfter(a,"x <= ")
        if newStr(length(newStr)) == 'x'
            disp("Estoy en el primer caso")
            num=extractBefore(newStr," &")
            alfa1=str2num(num)
        else
            disp("Estoy en el segundo caso")
            %num=extractAfter(newStr,"x <= ")
            alfa1=str2num(newStr)
        end

        %Puesto que alfa no puede ser menor a cero, se toma alfa=0
        if alfa1<0
            alfa1=0;
        end
        %Nuevo punto
        x0=x0+alfa1*D'
        Aw=[]
        w=[]
    end

    disp("X0 redondeado")
    round(x0)

end

