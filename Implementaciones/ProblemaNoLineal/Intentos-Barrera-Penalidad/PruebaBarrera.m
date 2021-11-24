%Barrera para Proyecto Optimización
clear all
clc

syms x1 x2 x3 x4 c
vars = [x1 x2 x3 x4];

%Tenemos la función objetiva y conjunto de restricciones de nuestro proyecto 
f= -(14800*x1+ 9500*x2+ 4600*x3 -(70*(15-2*x4)*x1+ 70*(10-1.5*x4)*x2+ 70*(5-0.5*x4)*x3+ 850*x4+ 85000 + 900))
f=simplify(f);

r = [8446*x1 + 3175*x2 + 1588*x3 - 70000;
    26.8*x1 + 8.3*x2 + 4.3*x3 - 470;
    x1 + x2 + x3 - 27;
    x1 + x3 - 13;
    x1 - 8;
   - x1 + 1;
    x2 - 10;
   - x2 + 3;
    x3 - 13;
   - x3 + 5;
    x4 - 6;
   - x4];
    

%Encontrar el q 
q = f;
for i=1:length(r)
    q = q +c*(r(i)^2);
end
q;

%Gradiente de q y ecuaciones obtenidas
delta_q = [];
for i=1:length(vars)
    delta_q = [delta_q; diff(q,vars(i))]
end
delta_q

eq1 = delta_q(1)
eq2 = delta_q(2)
eq3 = delta_q(3) 
eq4 = delta_q(4) 


%Nunca termino de resolver
[solx1,solx2,solx3,solx4]= solve(eq1==0,eq2==0,eq3==0,eq4==0)


sol_x1 = [];
for i=1:length(solx1)-1
    sol_x1 = [sol_x1 double(limit(solx1(i)))];
end
sol_x1
simplify(sol_x1)


sol_x2 = [];
for i=1:length(solx2)-1
    sol_x2 = [sol_x2 double(limit(solx2(i)))];
end
sol_x2


sol_x3 = [];
for i=1:length(solx3)-1
    sol_x3 = [sol_x3 double(limit(solx3(i)))];
end
sol_x3


sol_x4 = [];
for i=1:length(solx4)-1
    sol_x4 = [sol_x4 double(limit(solx4(i)))];
end
sol_x4



