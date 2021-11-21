%{
Problema Lineal: 14800x1 + 9500x2 + 4600x3 -
(70(15-2y1)x1 + 70(10-1.5y1)x2 +70(5-0.5y1)x3 + 850y1 +85900)

Restricciones:

c(1) : 8446x1 + 3175x2 + 1588x3<= 70000
c(2) : 26.8x1 + 8.3x2 + 4.3x3<=470
c(3) : x1 + x2 + x3<=27
c(4) : x1 + x3<=13
c(5) : 1<=x1<=8 
c(6) : 3<=x2<=10
c(7) : 5<=x3<=13
c(8) : 0<=y1<=6
            
Se usará la funcion fmincon para encontrar el punto óptimo al problema
F.O es no lineal
Todas las restricciones son lineales                                
%}

%Limpiar el espacio de trabajo
clear all
clc

% x4: y1

%Funcion Objetivo:

fun = @(x) -((14800*x(1) + 9500*x(2) + 4600*x(3)) - (70*(15-2*x(4))*x(1) + 70*(10-1.5*x(4))*x(2) + 70*(5-0.5*x(4))*x(3) + 850*x(4) + 85900));


%Punto de arranque (se escogió de manera aleatoria):
x0=[5 1 3 1];

%{
Matriz de restricciones lineales:
Las filas representan las restricciones

Columna 1: x1
Columna 2: x2
Columna 3: x3
Columna 4: y1
%}

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
 
     
%Lado derecho de las restricciones de desigualdad

b=[70000; 470; 27; 13; 8; -1; 10; -3; 13; -5; 6; 0];

Aeq=[];
beq=[];
lb=[];
ub=[];
nonlcon=[];

options = optimoptions('fmincon','Display','iter','Algorithm','sqp'); 
X=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)

X=round(X)

f=-round(fun(X))





     



