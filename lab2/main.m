pkg load interval;

% rosenbrok
X = infsup([infsup(-30, 30), infsup(-30, 30)]);

[z_r, WorkList_r, diams_r] = globopt0(@rosenbrok, X);
display(z_r)
iter = 1:1:length(diams_r);

figure;
plt = plot(iter, diams_r);
xlim([0, length(diams_r)]);
xlabel('Номер итерации');
ylabel('Диаметр бруса');
title('График сужения бруса');
saveas(plt, 'rosenbrok_contr', 'png'); 

% minimizing sequence
truesol = 0;
minim_seq = zeros(1, length(WorkList_r));
for i = 1 : length(WorkList_r)
    minim_seq(i) = WorkList_r(i).Estim;
end

dist = zeros(1, length(minim_seq));
for i = 1 : length(minim_seq)
    dist(i) = abs(minim_seq(i) - truesol);
end

figure;
iter = 1:1:length(dist);
plt2 = semilogy(iter, dist);
xlim([0, length(dist)]);
xlabel('Номер итерации');
ylabel('Расстояние до истинного решения');
title('График сходимости метода');
saveas(plt2, 'rosenbrok_conv_log', 'png'); 

centers_x = [];
centers_y = [];
for i = 1 : length(WorkList_r)
    centers_x(i) = WorkList_r(i).Box(1).mid;
    centers_y(i) = WorkList_r(i).Box(2).mid;
end

figure;
plt3 = plot(centers_x, centers_y);
xlabel('x');
ylabel('y');
title('Траэктория центра брусов');
saveas(plt3, 'rosenbrok_traj', 'png'); 

% simple 
X = infsup([infsup(-30, 30), infsup(-30, 30)]);

[Z_r, WorkList_r, diams_r] = globopt0(@simple, X);
display(Z_r)
iter = 1:1:length(diams_r);

figure;
plt = plot(iter, diams_r);
xlim([0, length(diams_r)]);
xlabel('Номер итерации');
ylabel('Диаметр бруса');
title('График сужения бруса');
saveas(plt, 'simple_contr', 'png'); 

% minimizing sequence
truesol = 0;
minim_seq = zeros(1, length(WorkList_r));
for i = 1 : length(WorkList_r)
    minim_seq(i) = WorkList_r(i).Estim;
end

dist = zeros(1, length(minim_seq));
for i = 1 : length(minim_seq)
    dist(i) = abs(minim_seq(i) - truesol);
end

figure;
iter = 1:1:length(dist);
plt2 = semilogy(iter, dist);
xlim([0, length(dist)]);
xlabel('Номер итерации');
ylabel('Расстояние до истинного решения');
title('График сходимости метода');
saveas(plt2, 'simple_conf_log', 'png'); 

centers_x = [];
centers_y = [];
for i = 1 : length(WorkList_r)
    centers_x(i) = WorkList_r(i).Box(1).mid;
    centers_y(i) = WorkList_r(i).Box(2).mid;
end

figure;
plt3 = plot(centers_x, centers_y);
xlabel('x');
ylabel('y');
title('Траэктория центра брусов');
saveas(plt3, 'simple_traj', 'png'); 
