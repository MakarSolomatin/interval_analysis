function [V]=LeqWeakR3(infA,supA,infb,supb,OrientPoints,transparency,varargin)
%
% Функция LeqWeakR3 рисует объединенное множество решений 
% (по другой терминологии, множество слабых решений)
% для интервальной системы линейных неравенств  A x <= b, где
%   A - интервальная матрица, у которой m строк и 3 столбца;
%   b - интервальный вектор длины m;
% а также вычисляет вершины пересечений этого множества решений с ортантами.
%
% Обязательные входные аргументы:
%   infA, supA - нижний и верхний концы матрицы A - вещественные матрицы,
%     имеющие размер матрицы A (m строк и 3 столбца);
%   infb, supb - нижний и верхний концы вектора b - вещественные векторы длины m;
%   OrientPoints - параметр для рисования точек-ориентиров, 
%     его значения: 0 - не рисуем, 1 - рисуем;
%   transparency - параметр прозрачности реальных граней, 
%     его значения: 0 - непрозрачные, 1 - прозрачные.
%
% Дополнительные входные аргументы:
%   varargin - брус принудительной обрезки, 
%     вводится как 6 чисел  xb,xe,yb,ye,zb,ze, где 
%     xb,yb,zb - нижний конец, а  xe,ye,ze - верхний конец бруса.
%
% Выходные аргументы: 
%   V - список точек-ориентиров 
%      (вершин пересечений множества решений с ортантами).

   % перейдем к интервальному включению [uC,oC] x \subseteq [ud,od]
   % в арифметике Каухера
   uC=supA;
   oC=infA;
   m=size(infb,1);
   ud=-ones(m,1)*Inf;
   od=supb;

   % нарисуем множество решений включения [uC,oC] x \subseteq [ud,od]
   var=(length(varargin)==6);
   if var % если пользователь задал брус как дополнительный аргумент, 
      [V]=CxindR3(uC,oC,ud,od,OrientPoints,transparency,varargin{1},varargin{2},varargin{3},varargin{4},varargin{5},varargin{6});
   else
      [V]=CxindR3(uC,oC,ud,od,OrientPoints,transparency);
   end

end
