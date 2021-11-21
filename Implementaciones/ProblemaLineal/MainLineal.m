%Limpiar espacio de trabajo
clear all
clc

disp('Scrpit que encuentra la solucion optima dado un Problema Lineal')
disp('Para realizar un mejor analisis, se comparan las soluciones dado un numero de trabajadores t ingresado')
disp('0<=t<=6')
prompt = 'Por favor, ingrese el numero de trabajadores: ';
y = input(prompt)

while y<0 || y>6
    disp('Numero ingresado incorrecto')
    prompt = 'Por favor, ingrese el numero de trabajadores: ';
    y = input(prompt)
end
message=['Se encontrará una solucion optima al problema dado ',num2str(y), ' trabajadores '];
disp(message)


[XB,Z]=CodigoLineal(y);

disp('Solución Optima: ')
XB

disp('Valor de la funcion Objetivo: ')
Z

