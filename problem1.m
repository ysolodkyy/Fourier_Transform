%%Project AMTH358
 
 close all;
 clear all;
 syms t f real
 template = (1-t^2)^4
 
 pulse = heaviside(t+1)-heaviside(t-1);
 
 x = template*pulse;
 
 figure(1)
 
 ezplot(x, [-2 2]);
 
 title('x(t)')
 
X = int(x*exp(i*2*pi*t*f), t, -1 , 1);
 figure(2) 
 ezplot(X,[-2 2])
 title('X(f)')

 
x=x*pulse 

syms F positive
syms k integer

x1=subs(x,t,-k/F)*exp(i*2*pi*(k/F)*f)/F;

x2=subs(x,t,k/F)*exp(-i*2*pi*(k/F)*f)/F;
S1 = symsum(x1, k, 1, 100);
S2 = symsum(x2, k, 1, 100);
X_F = limit(x1,k,0) +S1+S2;


Fsub =4 ;


figure(3)
ezplot(subs(X_F, F,Fsub),[-Fsub/2 Fsub/2])%ezplot(subs(X_F,F,4),[-2*3 2*3])
title('X_F(f)')

err = X-subs(X_F,F,Fsub); 

figure(4)
ezplot(err,[-Fsub/2 Fsub/2]) 
title("error")
%% Discrete approximation of 
%1
F=4;
%2
delta_f = 1/32;

N = F/delta_f;
%3
delta_t= 1/F;

T=delta_t*N;

ALIAS = 0;
%4 get samples xT(k*delta_t)
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

%5
X_FFT = fft(T*xTk)/N;

figure(5)

%% The value used T=32.
T


figure(6)
ezplot(x_T, [-40 40])
legend("x_T(t)")
hold on
ezplot(x, [-40 40])
legend("x(t)")
hold off
title("x_T(t) & x(t)")
figure(7)
stem(fftshift(xTk))
%stem(xTk)
title("fftshift( x_T(delta-t) )")
%m=-63:63;
figure(8)
stem(xTk)
hold on
ezplot(x_T, [-40 127])
%hold off

%hold on
ezplot(x, [-40 127])
%legend("x(t)")
hold off
title("x_T(t) & x(t) & x_T(delta-t) ")

clear F;
syms F; 

X_F = subs(X_F,F,4);
figure(9)
ezplot(X_F,[-2 2])
hold on
ezplot(X)
hold off

title('X_F(f) & X_FFT(f) & X(f)')
figure(10)
fshift=-64:63;
plot(fshift,fftshift(X_FFT))
title("X_FFT(f)");

