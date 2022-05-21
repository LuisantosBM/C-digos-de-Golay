function j=buscar(s,B)

j=0; %Esto controla si cumple la condición de error en el primer bloque.

for i=1:12
  if wt(rem(s+B(i,:),2))<=2
     j=i;
     break
  endif 
endfor 
