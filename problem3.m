clear all;
close all;
clc;

T=2*pi;
f_o=1/T;
syms t f

S_N = 0;

for m=1:40
    S_N = S_N+1/m*cos(m*t);
end

figure(1)
ezplot(S_N, [0 T]) 
title("S_N(t)")

%{
for m=1:40
    S_N = S_N+1/m*cos(m*t);
end

figure(2)
ezplot(S_N, [0 T]) %looks reversed -- need to fix that. it has to be somewhere with calculating coefficients
title
%}

Sigma_N = 0;

for m=1:40
    Sigma_N = Sigma_N+(40-abs(m))/40*(1/m)*cos(m*t);
end

figure(2)
ezplot(Sigma_N, [0 T])
title("Sigma_N(t)")


%% estimate the function 

figure(3)
box = heaviside(t)-heaviside(t-T);
x = box/sin(t/2)-2.7;
ezplot(x, [0 T])
title("x(t)")

%%
% periodize x(t)
x_T = x + subs(x,t, t-T) + subs(x,t,t+T) + subs(x,t, t-2*T) + subs(x,t,t+2*T);

%% calculate x_hat of the function
syms l
A = 2/T*int(x_T*cos(2*pi*l*t/T), t, -T/2 , T/2);

B = 2/T*int(x_T*sin(2*pi*l*t/T), t, -T/2 , T/2);


% show they are the same as series coefficients which I already got for N =
% 40

