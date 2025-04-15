k2=zeros(1,5);
m1=zeros(1,5);
m2=zeros(1,5);
d1=zeros(1,5);
d2=zeros(1,5);
U=0.75;
i=1;

%% 

plot(t_received(1,1:4400),cart1pos(1,1:4400))


%% 

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

n=2;
wd=2*pi*n/(t2-t0);
bwn=1/(t2-t0)*log((y0-yinf)/(y2-yinf));
wn=sqrt((wd^2)+(bwn^2));
b=bwn/wn;


k2(1,i)=U/yinf;
m1(1,i)=k2(1,i)*(wn^-2);
d1(1,i)=k2(1,i)*2*b/wn;

i=i+1;

%% 

i=1;

%% 

plot(t_received(1,1:8000),(cart2pos(1,1:8000)-cart2pos(1,8000)))

%% 
[pks,locs]=findpeaks((cart2pos(1,1:8000)-cart2pos(1,8000))*2*pi/1000,t_received(1,1:8000));
Td=mean(diff(locs(1,1:12)));
wd=2*pi/Td;

delta=zeros(1,10);
for j=1:10
    u1=pks(j);
    u2=pks(j+1);
    delta(1,j)=log(u1/u2);
end
delta=mean(delta);
zeta=delta/sqrt(4*pi^2+delta^2);

wn2=wd/sqrt(1-zeta^2);

m2(1,i)=mean(k2)*wn2^-2;
d2(1,i)=2*m2(1,i)*zeta*wn2;

i=i+1;
%% 

save('MAE171correctparameters2',"k2","d1","m1","d2","m2")
