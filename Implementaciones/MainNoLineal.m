%Limpiar espacio de trabajo
clear all
clc

disp('Scrpit que encuentra la solucion optima dado un Problema No Lineal')
disp('Para realizar un mejor analisis, se suponen 4 casos: ')
disp(' [1] Resolver problema no lineal original ')
disp(' [2] Resolver problema no lineal dado que el salario de los trabajadores extra aumenta ')
disp(' [3] Resolver problema no lineal dado que se cambia el precio de transporte de cada caja ')
disp(' [4] Resolver problema no lineal con nuevas restricciones ')
prompt = 'Por favor, ingrese el numero del caso que desea resolver: ';
y = input(prompt)
Y=[1 2 3 4];
while ~ismember(y,Y)
    disp('Numero ingresado incorrecto')
    prompt = 'Por favor, ingrese el numero del caso que desea resolver: ';
    y = input(prompt)
end
message=['Se encontrará una solucion optima al problema escogido '];
disp(message)


[XB,Z]=CodigoNoLineal(y);

disp('Solución Optima: ')
XB

disp('Valor de la funcion Objetivo: ')
Z
