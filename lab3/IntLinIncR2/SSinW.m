% Процедура SSinW рисует множество решений по ортантам.

%   figure   % если хотим, чтобы сохранялись все полученные рисунки
%% или
   figure(1) % чтобы не плодить новых рисунков
   clf(1);   % чтобы не накладывались рисунки в окне

   hold on % начало рисунка

      axis([W(1,1),W(2,1),W(1,2),W(2,2)])  
   xlabel('x1');
   ylabel('x2');
       % белое окно = W, растянутое под PlotBoxAspectRatio
       % для ограниченных множеств можно взять равный масштаб по осям 
       % в белом окне стандартных пропорций, 
       %% сюрпризы в том, что окно отрисовки выбирает Matlab и его связь с W непонятна
      if bounded
         axis equal
      end

      % добавляем сетку
      % grid on

      % если участки осей попали в окно отрисовки, рисуем эти участки синим пунктиром
      %% ось абсцисс
      if (0>=W(1,2)) & (0<=W(2,2))
      plot(W(:,1),[0,0],':b','LineWidth',1)
      end
      %% ось ординат
      if (0>=W(1,1)) & (0<=W(2,1))
      plot([0,0],W(:,2),':b','LineWidth',1)
      end

      % рисуем множество решений по ортантам 
      % (внутренняя область - зеленая, граница - черная, вершины - кружочки)
      fill(P1(:,1),P1(:,2),'g') 
      plot(P1(:,1),P1(:,2),'o','MarkerFaceColor','k','MarkerSize',3)
      fill(P2(:,1),P2(:,2),'g') 
      plot(P2(:,1),P2(:,2),'o','MarkerFaceColor','k','MarkerSize',3)
      fill(P3(:,1),P3(:,2),'g') 
      plot(P3(:,1),P3(:,2),'o','MarkerFaceColor','k','MarkerSize',3)
      fill(P4(:,1),P4(:,2),'g') 
      plot(P4(:,1),P4(:,2),'o','MarkerFaceColor','k','MarkerSize',3)

   hold off % конец рисунка
                