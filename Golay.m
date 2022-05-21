function v=Golay(w)

w     %w: es la palabra que recibimos.
u=[]; %u: es el patron de error.
v=[]; %v: es la palabra que se envio.
i=0;  %i: posicion donde ocurre un error.
e=[]; %e: vector con todo ceros salvo en la posicion i.

B=[[1,1,0,1,1,1,0,0,0,1,0,1];
   [1,0,1,1,1,0,0,0,1,0,1,1];
   [0,1,1,1,0,0,0,1,0,1,1,1];
   [1,1,1,0,0,0,1,0,1,1,0,1];
   [1,1,0,0,0,1,0,1,1,0,1,1];
   [1,0,0,0,1,0,1,1,0,1,1,1];
   [0,0,0,1,0,1,1,0,1,1,1,1];
   [0,0,1,0,1,1,0,1,1,1,0,1];
   [0,1,0,1,1,0,1,1,1,0,0,1];
   [1,0,1,1,0,1,1,1,0,0,0,1];
   [0,1,1,0,1,1,1,0,0,0,1,1];
   [1,1,1,1,1,1,1,1,1,1,1,0]];

I=[[1,0,0,0,0,0,0,0,0,0,0,0];
   [0,1,0,0,0,0,0,0,0,0,0,0];
   [0,0,1,0,0,0,0,0,0,0,0,0];
   [0,0,0,1,0,0,0,0,0,0,0,0];
   [0,0,0,0,1,0,0,0,0,0,0,0];
   [0,0,0,0,0,1,0,0,0,0,0,0];
   [0,0,0,0,0,0,1,0,0,0,0,0];
   [0,0,0,0,0,0,0,1,0,0,0,0];
   [0,0,0,0,0,0,0,0,1,0,0,0];
   [0,0,0,0,0,0,0,0,0,1,0,0];
   [0,0,0,0,0,0,0,0,0,0,1,0];
   [0,0,0,0,0,0,0,0,0,0,0,1]];

   
%Definimos la matriz de control de paridad.

H=[I;B];

%Calculamos el primer sindrome s1, para tener los resultados en modulo 2 
%usamos la función rem(.,2).

%%%%%%%%%%%%%%%Los pasos para el primer sindrome%%%%%%%%%%%%%%%%%

%%%%%%%%%%Se calcula el primer sindrome%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1=rem(w*H,2); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%Se se calcula la fila donde un error en el segundo bloque.
i=buscar(s1,B);
e=ei(i,12);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if wt(s1)<=3
  u=[s1,0,0,0,0,0,0,0,0,0,0,0,0];


elseif i!=0
  if wt(rem(s1+B(i,:),2))<=2
    u=[rem(s1+B(i,:),2),e];
   endif
endif
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%Los pasos para el segundo sindrome%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%Se calcula el segundo sindrome%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s2=rem(s1*B,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%Se se calcula la fila donde un error en el primer bloque.
i=buscar(s2,B);
e=ei(i,12);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if wt(s2)<=3
  u=[0,0,0,0,0,0,0,0,0,0,0,0,s2];


elseif i!=0
  if wt(rem(s2+B(i,:),2))<=2
    u=[e,rem(s2+B(i,:),2)];
  endif 
endif

%%%%%%%%%%%%%%%%%%%Conclusion del algoritmo%%%%%%%%%%%%%%%%%%%%%%%%%

if length(u)==0
  fprintf('Se necesita retransmision.') 
else 
  v=rem(w+u,2);
  mensaje(u)
endif