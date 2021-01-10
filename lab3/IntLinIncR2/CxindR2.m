function [V,P1,P2,P3,P4]=CxindR2(uC,oC,ud,od)
%
% Функция CxindR2 рисует множество решений интервального включения 
% [uC,oC] x \subseteq [ud,od] в арифметике Каухера, 
% в этом включении:
% uC, oC - вещественные матрицы, у которых m строк и 2 столбца
%          (соответственно нижний и верхний концы 
%          интервальной матрицы C),
% ud, od - векторы длины m, элементы которых могут быть не только
%          вещественными числами, но и -Inf или +Inf
%          (соответственно нижний и верхний концы интервального 
%          вектора d),
% x - неизвестный вещественный вектор длины 2.
%
% Выходные параметры:
% V - точки-ориентиры (вершины пересечений мн-ва решений с ортантами);
% Pk - если множество решений в ортанте k ограничено, Pk дает
%      замкнутый обход по часовой стрелке множества решений в ортанте k,
%      а если неограничено, то аналогичный обход, но для пересечения 
%      множества решений в ортанте k с брусом обрезки B
%      (брус обрезки B программа выбирает сама).
%
% автор: Шарая Ирина Александровна (Институт вычислительных технологий, Новосибирск)
% дата:  07/03/2012

   P1=zeros(0,2);
   P2=zeros(0,2);
   P3=zeros(0,2);
   P4=zeros(0,2);

   % множество решений в ортанте k описывается 
   % системой неравенств Ak(:,:)x>=bk при следующем выборе Ak и bk
   A1(:,:)=[uC; -oC; 1 0; 0 1]; 
   A2(:,:)=[oC(:,1) uC(:,2); -uC(:,1) -oC(:,2); -1 0; 0 1];
   A3(:,:)=[oC; -uC; -1 0; 0 -1];
   A4(:,:)=[uC(:,1) oC(:,2); -oC(:,1) -uC(:,2); 1 0; 0 -1];
   b1=[ud; -od; 0; 0];
   b2=b1;
   b3=b1;
   b4=b1;


   % для каждого ортанта k
   % удалим из систем строки, которые заведомо имеют пустое множество решений,
   % и строки, решение которых есть все пространство R^2,
   % и вычислим Sk - матрицу граничных интервалов множества решений в ортанте k

   [A1,b1,cnmty]=ClearRows(A1,b1);
   if cnmty
      [S1]=BoundaryIntervals(A1,b1);
   else
      [S1]=zeros(0,5);
   end

   [A2,b2,cnmty]=ClearRows(A2,b2);
   if cnmty
      [S2]=BoundaryIntervals(A2,b2);
   else
      [S2]=zeros(0,5);
   end

   [A3,b3,cnmty]=ClearRows(A3,b3);
   if cnmty
      [S3]=BoundaryIntervals(A3,b3);
   else
      [S3]=zeros(0,5);
   end

   [A4,b4,cnmty]=ClearRows(A4,b4);
   if cnmty
      [S4]=BoundaryIntervals(A4,b4);
   else
      [S4]=zeros(0,5);
   end

   % составим матрицу S из всех матриц Sk,
   S=[S1; S2; S3; S4];

   if size(S,1)==0
      disp('Множество решений пусто (нет граничных интервалов)') 
      V=[];
      return;
   end

   % Cбор ориентиров (=ориентационных точек) в матрицу V.
   V=OrientationPoints(S);

   % выбор бруса отрисовки W   
   [W]=DrawingBox(V);

   % Если множество решений неограничено
   % (= в матрице S есть бесконечные элементы)
   % надо 
   % 1) увеличить брус отрисовки W (для яркости восприятия бесконечности)
   % 2) выбрать брус обрезки B и пересчитать матрицы Sk с бесконечными элементами

   bounded=1;
   if ~all(all(isfinite(S)))
   bounded=0;

      % увеличение бруса отрисовки W и выбор бруса B обрезки решения
      [W,B]=CutBox(W);

      % пересчитаем матрицы Sk, в которых есть бесконечные элементы,
      % добавив в систему Ak*x>=b два неравенства из бруса обрезки B

      if ~all(all(isfinite(S1)))
          A1=[A1;    -1 0;    0 -1];
          b1= [b1;  -B(2,1); -B(2,2)];
          [S1]=BoundaryIntervals(A1,b1);
      end

      if ~all(all(isfinite(S2)))
          A2=[A2;    1 0;    0 -1];
          b2= [b2;  B(1,1); -B(2,2)];
          [S2]=BoundaryIntervals(A2,b2);
      end

      if ~all(all(isfinite(S3)))
          A3=[A3;    1 0;    0 1];
          b3= [b3;  B(1,1); B(1,2)];
          [S3]=BoundaryIntervals(A3,b3);
      end

      if ~all(all(isfinite(S4)))
          A4=[A4;   -1 0;    0 1];
          b4= [b4; -B(2,1); B(1,2)];
          [S4]=BoundaryIntervals(A4,b4);
      end
      
    end
      
    % Построение замкнутого обхода Pk для (усеченного, если надо) 
    % множества решений в ортанте k по матрице участков Sk, k=1,2,3,4.
    % В матрице Pk строки соответствуют вершинам выпуклого многогранника,
    % а порядок строк - обходу границы многогранника по часовой стрелке.
    if size(S1,1)>0
       [P1] = Intervals2Path(S1);
    end
    if size(S2,1)>0
       [P2] = Intervals2Path(S2);
    end
    if size(S3,1)>0
       [P3] = Intervals2Path(S3);
    end
    if size(S4,1)>0
       [P4] = Intervals2Path(S4);
    end

    % отрисовка множества решений
    SSinW

    % подготовка матрицы ориентиров для печати
    V=V';        
    fprintf('Число ориентиров = %d\n\n',size(V,2)) 

end                
