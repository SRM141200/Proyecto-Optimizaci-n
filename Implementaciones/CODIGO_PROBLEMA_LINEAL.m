A = [ 8446 3175 1588 1 0 0 0 0 0 0 0 0;
      26.8 8.3  4.3  0 1 0 0 0 0 0 0 0;
      1     1     1  0 0 1 0 0 0 0 0 0;
      1     0     0  0 0 0 1 0 0 0 0 0;
      1     0     0  0 0 0 0 -1 0 0 0 0;
      0     1     0  0 0 0 0 0 1 0 0 0;
      0     1     0  0 0 0 0 0 0 -1 0 0;
      0     0     1  0 0 0 0 0 0 0 1 0;
      0     0     1  0 0 0 0 0 0 0 0 -1];

b = [70000 470 27 8 1 10 3 13 5];
c = [-14170 -9115 -4355 0 0 0 0 0 0 0 0 0];

%Tamaño de A
[m, n] = size(A);

%Matriz identidad (mxm)
I = eye(m);

%Se añade la identidad a la matriz A
Atemp = [A I]; 

%Coeficientes dado que se creo la matriz Atemp
ctemp=[0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1];

%Indices
Ib = n+1:n+m;
In = 1:n;


para = 0;

%Simplex
while para == 0


    [m, n] = size(Atemp);
    B = Atemp(:, Ib);
    N = Atemp(:, In);
    Cb = ctemp(:, Ib);
    Cn = ctemp(:, In);
    Xb = inv(B)*b.';
    z0 = Cb*Xb;

    %Cj gorro
    CJ = Cn - Cb*inv(B)*N;

    %Evuluar si se debe continuar
    MinCJ = min(CJ);
    if MinCJ >= 0
      para = 1;
    else
        %indice = find(CJ == MinCJ, size(CJ, 2));
        indice=find(MinCJ==CJ);
        
        %Posibles candidatos a entrar a la base
        k = In(indice);
        
        %Ciclaje Bland
        
        if size(indice, 2) > 1
          indices = In(indice);
          k = min(indices);
        end
        
        %Criterio de la Razón Minima
        yk = inv(B)*Atemp(:, k);
 
        for i=1:numel(yk)
            if yk(i,1)<=0
                yk(i,1)=nan;
            end
        end
        by = Xb./yk;
        
        %Argumento Minimo
        argmin = find(by == min(by));
        
        
        %Variable que sale de la base
        r = Ib(argmin);
        
        Ib = Ib(Ib ~= r);
        In = In(In ~= k);
        Ib = [Ib k];
        In = [In r];
        Ib = sort(Ib);
        In = sort(In);
        
    end
end

disp("Solución Óptima: ")
Xb
