%方形镜共焦腔激光模式仿真
clear all
close all

x=(-5:0.1:5).*1e-3;            % 坐标范围
lambda=632.8e-9;               % 波长
L=10;                          % 腔长
X=x.*sqrt(2*pi./(lambda.*L));  	
[X1,Y1]=meshgrid(X,X);         % X和Y的坐标矩阵

%% 厄米特函数
% H0-H3
H0X=1;
H0Y=1;
H1X=2.*X1;
H1Y=2.*Y1;
H2X=4.*X1.^2-2;
H2Y=4.*Y1.^2-2;
H3X=-8.*X1.^3+12.*X1;
H3Y=-8.*Y1.^3+12.*Y1;

%% 厄米特——高斯函数
% F0-F3
FX0=H0X.*exp(-X1.^2-2);
FY0=H0Y.*exp(-Y1.^2-2);
FX1=H1X.*exp(-X1.^2-2);
FY1=H1Y.*exp(-Y1.^2-2);
FX2=H2X.*exp(-X1.^2-2);
FY2=H2Y.*exp(-Y1.^2-2);
FX3=H3X.*exp(-X1.^2-2);
FY3=H3Y.*exp(-Y1.^2-2);

%% 振幅分布

u00=FX0.*FY0;         % TEM00
I0=FX0.^2.*FY0.^2;
subplot(4,2,1)
imagesc(abs(u00)) 
title('方形镜共焦腔横模 (m=0 , l=0)');
xlabel('x (m)');
ylabel('y (m)');
subplot(4,2,2)
surf(X1,Y1,I0)
title('方形镜共焦腔光强分布三维模型 (m=0 , l=0) ');
xlabel('x (m)');
ylabel('y (m)');
zlabel('Intensity');

u01=FX0.*FY1;         % TEM01
I1=FX0.^2.*FY1.^2;
subplot(4,2,3)
imagesc(abs(u01))  
title('方形镜共焦腔横模 (m=0 , l=1)');
xlabel('x (m)');
ylabel('y (m)');
subplot(4,2,4)
surf(X1,Y1,I1)
title('方形镜共焦腔光强分布三维模型 (m=0 , l=1) ');
xlabel('x (m)');
ylabel('y (m)');
zlabel('Intensity');

u11=FX1.*FY1;         % TEM11
I2=FX1.^2.*FY1.^2;
subplot(4,2,5)
imagesc(abs(u11))  
title('方形镜共焦腔横模 (m=1 , l=1)');
xlabel('x (m)');
ylabel('y (m)');
subplot(4,2,6)
surf(X1,Y1,I2)
title('方形镜共焦腔光强分布三维模型 (m=1 , l=1) ');
xlabel('x (m)');
ylabel('y (m)');
zlabel('Intensity');

u22=FX2.*FY2;         % TEM22
I3=FX2.^2.*FY2.^2;
subplot(4,2,7)
imagesc(abs(u22)) 
title('方形镜共焦腔横模 (m=2 , l=2)');
xlabel('x (m)');
ylabel('y (m)');
subplot(4,2,8)
surf(X1,Y1,I3)
title('方形镜共焦腔光强分布三维模型 (m=2 , l=2) ');
xlabel('x (m)');
ylabel('y (m)');
zlabel('Intensity');
