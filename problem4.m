% problem 4
close all;
clear all;
clc;

syms t f
pulse = heaviside(t+1)-heaviside(t-1);
x = exp(t)*pulse
T=3; 

% periodize x(t)
x_T = x + subs(x,t, t-T) + subs(x,t,t+T) + subs(x,t, t-2*T) + subs(x,t,t+2*T);

figure(1) 
ezplot(x_T, [-6 6])
title("x_T(t)")

%% calculate the FFT (DFT)

X = int(x*exp(2*pi*t*f*i),t, -1,1)

% plot for xT(k) for -32 =< n<= 32 ==> 65 samples. 

DC = 1/T*limit(X,f,0);

%{
for k=1:32
    x_hat_pos(k) =1/T*subs(X,f,k/T);
end
%}

for k=1:32
    x_hat_pos(k) =1/T*subs(X,f,-k/T);
end


for k=1:32
    x_hat_neg(k) =1/T*subs(X,f,k/T); % changed from -k to k
end


x_hat = zeros(1,65);

for m = 0:31
    x_hat(m+1) = x_hat_neg(32-m);
end

x_hat(33)=DC; 

for m= 1:32
    x_hat(33+m) = x_hat_pos(m);
end

x_hat


%% calculate & plot partial sums and Cesaro sums
% partial sums
S_N = 0;

for m=1:65
    S_N = S_N+x_hat(m)*exp(2*pi*i*(-33+m)*t/T);
end

figure(2)
ezplot(S_N, [-6 6]) %looks reversed -- need to fix that. it has to be somewhere with calculating coefficients
title("S_N(t)");

% Cesaro Sums

Sigma_N = 0;

for m=1:65
    Sigma_N = Sigma_N+((32-abs(m-33))/32)*x_hat(m)*exp(2*pi*i*(m-33)*t/T);
end

figure(3)
ezplot(Sigma_N, [-6 6])
title("Sigma_N(t)");



