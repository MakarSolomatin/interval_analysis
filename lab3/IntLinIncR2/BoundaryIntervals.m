function [S] = BoundaryIntervals(A,b)
%
% Функция  BoundaryIntervals  насчитывает матрицу граничных интервалов S
% для системы линейных неравенств  A*x >= b, где
% A - вещественная матрица без нулевых строк, имеющая m >= 1 строк и 2 столбца,
% x,b - вещественные векторы.
 
   m = size(A,1);
   S = zeros(0,5);

   for i=1:m
      si=true;     % предположим, что i-е неравенство опорное
      q=[-Inf Inf];  % заготовка под i-опору
      dotx= A(i,:)*b(i)/(A(i,:)*A(i,:)');  % dotx - точка привязки i-й прямой
                                           % (проекция нуля на эту прямую)
      p=[-A(i,2) A(i,1)]; % направление обхода границы i-й полуплоскости,
                          % при котором сама полуплоскость остается справа 
                          % (соответствует обходу множества решений 
                          %  по часовой стрелке)

      for k=1:m        %%% по-хорошему i-ое неравенство можно не считать,
                       %%% т.к. оно не влияет на i-опору, но тут считаем
         Akx=A(k,:)*dotx';  % скалярное произведение A_{k:} на вектор dotx
         c=A(k,:)*p';       % скалярное произведение A_{k:} на вектор p
         switch sign(c)
            case -1
               q(2)=min(q(2),(b(k)-Akx)/c);
            case 1
               q(1)=max(q(1),(b(k)-Akx)/c);
            %case 0
            otherwise
               if single(Akx)<single(b(k))
                  if single(A(k,:)*A(i,:)')>0
                     si=false; % i-е неравенство не опорное
                     break % выход из цикла for k
                  else % т.е. <0 и при этом нер-ва i и k несовместны
%                     disp('Есть пара противоречивых неравенств') 
                     return % выход из функции 
                  end
               end
         end
      end

      if single(q(1))>single(q(2))
         si=false;
      end 

      if si
      S=[ S ; dotx+p*q(1) , dotx+p*q(2) , i];
      end

   end
               
end