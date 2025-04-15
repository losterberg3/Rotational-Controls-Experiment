%% step response for disk 1, holding disk 2

syms s

M1=m1(1,1);
D1=d1(1,1);
K2=k2(1,1);
U=0.75;

F1=1/s; %step function for input

X1=U*1/(M1*s^2+D1*s+K2)*F1; %output, transfer function times input

f1=ilaplace(X1);

f1num=matlabFunction(f1);

T1=linspace(0,2.5,250);

f11=f1num(T1);

figure
hold on
plot(T1, f11,'r')
plot(t_received(1,2225:4400)-2.5,cart1pos(1,2225:4400),'b')
legend('LTI model','Experiment')
xlabel('Time (s)')
ylabel('Position (rad)')
hold off

%% impulse response for disk 2, holding disk 1

M2=m2(1,2);
D2=d2(1,2);
K2=mean(k2);

Uest=0.032; %estimate for input force/torque

F2=1; %impulse function for input

X2=Uest*1/(M2*s^2+D2*s+K2)*F2; %output, transfer function times input

f2=ilaplace(X2);

f2num=matlabFunction(f2);

T2=linspace(0,10,1000);

f22=f2num(T2);

figure
hold on
plot(T2-0.1, f22)
plot(t_received(1,1:8000),(cart2pos(1,1:8000)-cart2pos(1,8000)))
legend('LTI model','Experiment')
xlabel('Time (s)')
ylabel('Position (rad)')
hold off