function [V,P1,P2,P3,P4]=MixWeakR2(infA,supA,infb,supb,relations)
%
% Функция MixWeakR2 рисует объединенное множество решений 
% (по другой терминологии, множество слабых решений)
% для интервальной системы линейных отношений  A x relations b, где
%   A - интервальная матрица, у которой m строк и 2 столбца;
%   b - интервальный вектор длины m.
%
% Входные аргументы:
% infA, supA - нижний и верхний концы матрицы A - вещественные матрицы;
%   размер матриц infA и supA такой же как размер матрицы A (m строк и 2 столбца);
% infb, supb - нижний и верхний концы вектора b - вещественные векторы длины m;
% relations - вектор длины m из символов '=', '>', '<', условно выражающих 
%   отношения "равно", "больше или равно" и "меньше или равно" соответственно.
%
% Выходные аргументы:
% V - ориентиры (вершины пересечений множества решений с ортантами);
% Pk - если множество решений в ортанте k ограничено, Pk дает
%   замкнутый обход по часовой стрелке множества решений в ортанте k,
%   а если неограничено, то аналогичный обход, но для пересечения 
%   множества решений в ортанте k с брусом обрезки.


    % перейдем к интервальному включению [uC,oC] x \subseteq [ud,od]
    % в арифметике Каухера
    uC=supA;
    oC=infA;
    ud=infb;
    od=supb;
    m=size(infb,1);
    relLE=[relations==ones(m,1)*'<'];
    ud(relLE)=-Inf;
    relGE=[relations==ones(m,1)*'>'];
    od(relGE)=Inf;

    % нарисуем множество решений включения [uC,oC] x \subseteq [ud,od]
    % и, если надо, напечатаем V и Pk (k=1,2,3,4)
    if nargout < 1
        CxindR2(uC,oC,ud,od);
    end
    if nargout == 1
        [V]=CxindR2(uC,oC,ud,od);
    end
    if nargout > 1
        [V,P1,P2,P3,P4]=CxindR2(uC,oC,ud,od);
    end
end
