% problem 2
close all;
clear all;
syms t f

F = 4; 
N = 64; 

%declare x(t)

x = exp(-abs(t))/(1+abs(t))


delta_f = F/N;

delta_t = 1/F;

T = N*delta_t;

% periodize x(t)

ALIAS = 0;

for n =1:N

ALIAS = ALIAS + subs(x,t,t+n*T)+subs(x,t,t-n*T);

end


x_T = x + ALIAS;

%t_k = 0:N-1;

for k =0:N-1

xT(k+1) = subs(x_T,t,k*delta_t);

end


% Calculate X_F
xTk = zeros(1,N);

for n=1:N
    xTk(n)= double(xT(n));    
end


X_F = fft(T*xTk);

figure(1)
plot(fftshift(abs(X_F))); % need to tweak frequencies a little
title("X_F(f), F= 4 & N =64");


clear all;


syms t f

F = 8; 
N = 256; 

%declare x(t)

x = exp(-abs(t))/(1+abs(t))


delta_f = F/N;

delta_t = 1/F;

T = N*delta_t;

% periodize x(t)

ALIAS = 0;

for n =1:N

ALIAS = ALIAS + subs(x,t,t+n*T)+subs(x,t,t-n*T);

end


x_T = x + ALIAS;

%t_k = 0:N-1;

for k =0:N-1

xT(k+1) = subs(x_T,t,k*delta_t);

end


% Calculate X_F
xTk = zeros(1,N);

for n=1:N
    xTk(n)= double(xT(n));    
end


X_F = fft(T*xTk);

figure(2)
plot(fftshift(abs(X_F))); % need to tweak frequencies a little
title("X_F(f), F= 8 & N =256");