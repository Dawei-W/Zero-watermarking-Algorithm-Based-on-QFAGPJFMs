function [ G,theta1,theta2 ] = hua( I,m,n,V,U,G,theta1,theta2)
% ����ڲ�ֵ
%I = double(img);
% [m,n] = size(I);
% V=4;  %�ֳ��Ĵ��
% U=n/2;  %һ��u��
% uu=(n-1)*V;
% G = zeros(U,uu);
% theta1 = zeros(U,uu);
% theta2 = zeros(U,uu);
for u=1:U  %һ��u��
    ru=u/U;  %ÿһ��뾶
    ruuu=2/n;%��y�Ĵ�С
    nu=(2*u-1)*V;   %��u��Բ������Ϊnu����
    for v=1:nu
%         thuv=(v-1)*2*pi/nu;    %u�������صĽǶ�
        thuv=(v-0.5)*2*pi/nu;    %u�������صĽǶ�
        theta1(u,v)=(v-1)*2*pi/nu;
        theta2(u,v)=v*2*pi/nu;
        k = ru*sin(thuv)/ruuu;    %y �ѿ�������ϵλ�ã���������ԡ�y����ֻ�ǵ�λԲ�ڵ����λ�ã�
        l = ru*cos(thuv)/ruuu;    %x
%         K=ceil(k);    %���ؿ��ϱ���λ��
%         L=ceil(l);
%         r(u,v)=ru;
        if  (k>=0) && (l>0)   %%%��һ����(��ʱ��)
            kk=ceil(m/2-k+1);    %���ؿ�����λ��
            ll=ceil(n/2+l);
            G(u,v)=I(kk,ll);
        elseif (k>0) && (l<=0)  %%%�ڶ�����
            kk=ceil(m/2-k);    %���ؿ�����λ��
            ll=ceil(l+n/2+1);
            G(u,v)=I(kk,ll);
        elseif (k<=0) && (l<0)  %%%��������
            kk=ceil(m/2-k);    %���ؿ�����λ��
            ll=ceil(n/2+l);
            G(u,v)=I(kk,ll);
        elseif (k<0) && (l>=0)  %%%��������
            kk=ceil(m/2-k);    %���ؿ�����λ��
            ll=ceil(l+n/2);
            G(u,v)=I(kk,ll);
        end
    end
end


end

