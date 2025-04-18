% Below is the parameter derivation for the 2 experiments

k2=zeros(1,5);
m1=zeros(1,5);
m2=zeros(1,5);
d1=zeros(1,5);
d2=zeros(1,5);
U=0.75;

% experiment 1, holding the top disk (disk 1)

for i=1:5
load(['tophold_075v_05hz/tophold' num2str(i) '.mat'])

t=t_received(1,1:4400);
y=cart1pos(1,1:4400);
[y0,t0]=max(y);
t0=t_received(1,t0);
yinf=y(1,4400);
[y2,t2]=max(y(1,3000:4400));
t2=t_received(1,(t2+3000));

%convert to radians
%y0=y0/1000*2*pi;
%y2=y2/1000*2*pi;
%yinf=yinf/1000*2*pi;

% using characteristics of plotted data to find natural and damped frequency of step response

n=2;
wd=2*pi*n/(t2-t0);
bwn=1/(t2-t0)*log((y0-yinf)/(y2-yinf));
wn=sqrt((wd^2)+(bwn^2));
b=bwn/wn;

% converting natural frequency to spring coefficient, moment of inertia, & damping coefficient

k2(1,i)=U/yinf;
m1(1,i)=k2(1,i)*(wn^-2);
d1(1,i)=k2(1,i)*2*b/wn;

end

% experiment 2, holding the bottom disk (disk 2)

for i=1:5

load(['bottomhold_075v_01hz/bottomhold' num2stri(i) '.mat'])

[pks,locs]=findpeaks((cart2pos(1,1:8000)-cart2pos(1,8000))*2*pi/1000,t_received(1,1:8000));
Td=mean(diff(locs(1,1:12)));
wd=2*pi/Td;

% finding natural frequency and other parameters from characteristics of impulse response graph

delta=zeros(1,10); 
for j=1:10
    u1=pks(j);
    u2=pks(j+1);
    delta(1,j)=log(u1/u2);
end
delta=mean(delta);
zeta=delta/sqrt(4*pi^2+delta^2);

wn2=wd/sqrt(1-zeta^2);

% finding moment of inertia and damping coefficient

m2(1,i)=mean(k2)*wn2^-2;
d2(1,i)=2*m2(1,i)*zeta*wn2;

end 

save('correctparameters2',"k2","d1","m1","d2","m2")
