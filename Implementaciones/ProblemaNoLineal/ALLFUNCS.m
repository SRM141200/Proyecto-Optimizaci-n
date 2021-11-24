classdef ALLFUNCS
    methods(Static)
          function [w,Aw] = work(A,b,x0)
              Aw=[];w=[];
              [m,n]=size(A)
              for i= 1:m
                  aux=A(i,:)*x0';
                  if aux==b(i)
                      w=[w,i];
                      Aw=[Aw;A(i,:)];
                  end
              end 
          end
          
          function [P,D] = paso1(Aw,fun,x0)
              der=Aw' * inv((Aw*Aw'))*Aw;
              P=eye(size(der,0))-der;
              D=-P*Gd(fun,x0)';
              
              
              
          end
          
          function gradiente = Gd(fun,x0)
              grad1(y1) =  gradient(fun,x1);
              grad2(y1) =  gradient(fun,x2);
              grad3(y1) =  gradient(fun,x3);
              grad4(x1,x2,x3) =  gradient(fun,y1);
              gradiente=[grad1(x0(4)) , grad2(x0(4)), grad3(x0(4)), grad4(x0(1),x0(2),x0(3))]  
          end
          
          
          function [miu] = paso2(w,Aw,fun,x0,D,A,b)
              syms alfa1 alfa2
              if D==0
                  miu=-inv(Aw*Aw')*Aw*Gd(fun,x0)
                  if miu>=0
                      return
                  else
                      [m,i] = min(A);
                      w(i)=[]
                  end
                  
              else
                 temp=x0+alfa1*D;
                 Atemp2=[]
                 for i= 1:size(A,1)
                     aux=A(i,:)*temp<=b(i);
                     Atemp2=[Atemp2,aux];
                 end
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
              
              
          end
    end
end
