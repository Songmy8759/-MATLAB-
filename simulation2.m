%圆形镜共焦腔激光模式仿真
clear;
clc;

% 设置模拟区域的大小（单位：米）
xRange = [-0.005 0.005];
yRange = [-0.005 0.005];

% 设置采样点数
Nx = 200;
Ny = 200;

% 生成坐标网格
[x, y] = meshgrid(linspace(xRange(1), xRange(2), Nx), linspace(yRange(1), yRange(2), Ny));

% 定义拉盖尔-高斯函数的参数
p0 = 0; % 径向模式数
l0 = 0; % 方位角模式数
p1 = 1;
l1 = 1;
p2 = 2;
l2 = 2;
w0 = 0.001; % 束腰半径（单位：米）
k = 2 * pi / 632.8e-9; % 波数，这里假设波长为632.8nm

% 计算拉盖尔-高斯函数的强度分布
r = sqrt(x.^2 + y.^2);
theta = atan2(y, x);

% 拉盖尔多项式部分
LaguerrePoly00 = laguerreL(p0, abs(l0), 2 * r.^2 / w0^2);
LaguerrePoly01 = laguerreL(p0, abs(l1), 2 * r.^2 / w0^2);
LaguerrePoly11 = laguerreL(p1, abs(l1), 2 * r.^2 / w0^2);
LaguerrePoly22 = laguerreL(p2, abs(l2), 2 * r.^2 / w0^2);
% 指数部分
ExponentialPart = exp(-r.^2 / w0^2);

% 整体的拉盖尔-高斯函数的幅度部分
AmplitudeLG00 = sqrt(2 * factorial(p0) / (pi * factorial(p0 + abs(l0))))...
   .* (sqrt(2) * r / w0).^abs(l0).* LaguerrePoly00.* ExponentialPart;
AmplitudeLG01 = sqrt(2 * factorial(p0) / (pi * factorial(p0 + abs(l1))))...
   .* (sqrt(2) * r / w0).^abs(l1).* LaguerrePoly01.* ExponentialPart;
AmplitudeLG11 = sqrt(2 * factorial(p1) / (pi * factorial(p1 + abs(l1))))...
   .* (sqrt(2) * r / w0).^abs(l1).* LaguerrePoly11.* ExponentialPart;
AmplitudeLG22 = sqrt(2 * factorial(p2) / (pi * factorial(p2 + abs(l2))))...
   .* (sqrt(2) * r / w0).^abs(l2).* LaguerrePoly22.* ExponentialPart;
% 相位部分
PhaseLG00 = l0 * theta;
PhaseLG01 = l1 * theta;
PhaseLG11 = l1 * theta;
PhaseLG22 = l2 * theta;


% 合成复振幅
ComplexAmplitudeLG00 = AmplitudeLG00.* exp(1i * PhaseLG00);
ComplexAmplitudeLG01 = AmplitudeLG01.* exp(1i * PhaseLG01);
ComplexAmplitudeLG11 = AmplitudeLG11.* exp(1i * PhaseLG11);
ComplexAmplitudeLG22 = AmplitudeLG22.* exp(1i * PhaseLG22);

% 计算光强分布（光强是复振幅的模平方）
IntensityLG00 = abs(ComplexAmplitudeLG00).^2;
IntensityLG01 = abs(ComplexAmplitudeLG01).^2;
IntensityLG11 = abs(ComplexAmplitudeLG11).^2;
IntensityLG22 = abs(ComplexAmplitudeLG22).^2;

% 绘制光强分布图
figure;
subplot(4,2,1)
imagesc(xRange, yRange, IntensityLG00);
axis equal;
axis xy;
colormap('hot');
colorbar;
title(['圆形镜共焦腔横模 (p=', num2str(p0), ', l=', num2str(l0), ')']);
xlabel('x (m)');
ylabel('y (m)');
subplot(4,2,2)
surf(x, y, IntensityLG00);
colormap('hot');
title(['圆形镜共焦腔光强分布三维模型 (p=', num2str(p0), ', l=', num2str(l0), ') ']);
xlabel('x (m)');
ylabel('y (m)');
zlabel('Intensity');

subplot(4,2,3)
imagesc(xRange, yRange, IntensityLG01);
axis equal;
axis xy;
colormap('hot');
colorbar;
title(['圆形镜共焦腔横模 (p=', num2str(p0), ', l=', num2str(l1), ')']);
xlabel('x (m)');
ylabel('y (m)');
subplot(4,2,4)
surf(x, y, IntensityLG01);
colormap('hot');
title(['圆形镜共焦腔光强分布三维模型 (p=', num2str(p0), ', l=', num2str(l1), ') ']);
xlabel('x (m)');
ylabel('y (m)');
zlabel('Intensity');

subplot(4,2,5)
imagesc(xRange, yRange, IntensityLG11);
axis equal;
axis xy;
colormap('hot');
colorbar;
title(['圆形镜共焦腔横模 (p=', num2str(p1), ', l=', num2str(l1), ')']);
xlabel('x (m)');
ylabel('y (m)');
subplot(4,2,6)
surf(x, y, IntensityLG11);
colormap('hot');
title(['圆形镜共焦腔光强分布三维模型 (p=', num2str(p1), ', l=', num2str(l1), ') ']);
xlabel('x (m)');
ylabel('y (m)');
zlabel('Intensity');

subplot(4,2,7)
imagesc(xRange, yRange, IntensityLG22);
axis equal;
axis xy;
colormap('hot');
colorbar;
title(['圆形镜共焦腔横模 (p=', num2str(p2), ', l=', num2str(l2), ')']);
xlabel('x (m)');
ylabel('y (m)');
subplot(4,2,8)
surf(x, y, IntensityLG22);
colormap('hot');
title(['圆形镜共焦腔光强分布三维模型 (p=', num2str(p2), ', l=', num2str(l2), ') ']);
xlabel('x (m)');
ylabel('y (m)');
zlabel('Intensity');

