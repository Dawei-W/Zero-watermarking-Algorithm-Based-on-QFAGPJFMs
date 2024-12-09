function [ G,theta1,theta2 ] = hua( I,m,n,V,U,G,theta1,theta2)
% 最近邻插值
%I = double(img);
% [m,n] = size(I);
% V=4;  %分成四大块
% U=n/2;  %一共u层
% uu=(n-1)*V;
% G = zeros(U,uu);
% theta1 = zeros(U,uu);
% theta2 = zeros(U,uu);
for u=1:U  %一共u层
    ru=u/U;  %每一层半径
    ruuu=2/n;%△y的大小
    nu=(2*u-1)*V;   %第u个圆环被分为nu个块
    for v=1:nu
%         thuv=(v-1)*2*pi/nu;    %u环中像素的角度
        thuv=(v-0.5)*2*pi/nu;    %u环中像素的角度
        theta1(u,v)=(v-1)*2*pi/nu;
        theta2(u,v)=v*2*pi/nu;
        k = ru*sin(thuv)/ruuu;    %y 笛卡尔坐标系位置（如果不除以△y，则只是单位圆内的相对位置）
        l = ru*cos(thuv)/ruuu;    %x
%         K=ceil(k);    %像素块上边沿位置
%         L=ceil(l);
%         r(u,v)=ru;
        if  (k>=0) && (l>0)   %%%第一象限(逆时针)
            kk=ceil(m/2-k+1);    %像素块坐标位置
            ll=ceil(n/2+l);
            G(u,v)=I(kk,ll);
        elseif (k>0) && (l<=0)  %%%第二象限
            kk=ceil(m/2-k);    %像素块坐标位置
            ll=ceil(l+n/2+1);
            G(u,v)=I(kk,ll);
        elseif (k<=0) && (l<0)  %%%第三象限
            kk=ceil(m/2-k);    %像素块坐标位置
            ll=ceil(n/2+l);
            G(u,v)=I(kk,ll);
        elseif (k<0) && (l>=0)  %%%第四象限
            kk=ceil(m/2-k);    %像素块坐标位置
            ll=ceil(l+n/2);
            G(u,v)=I(kk,ll);
        end
    end
end


end

