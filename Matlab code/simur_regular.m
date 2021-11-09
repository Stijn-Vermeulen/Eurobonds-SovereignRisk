%% Simur_regular: simualte the model economy. Code based on Uribe & Schmitt-Grohé (2017)
%  and adjusted to account for non-defaultable debt

clear all, format compact

%load value functions and policy functions to simulate the model economy
load egr_egrid20_alpha1s16.mat 


cpai = cumsum(pai,2);

%Initial conditions
[~,i] = min(abs(y-1)); %average endowment (index)
j = floor(nd/2); %middle of debt grid (index)
k = (mod(j,nd)~= 0).* mod(j,nd) + (mod(j,nd)== 0)*nd;
l = ceil(j/nd);
b = 0; %b=1==>bad standing at the end of prevous period;   and  b=0==>good standing at the end of previous period

%Length of simulation and burning period
T = 1e6;
Tburn = 1e5;

Y = zeros(Tburn+T,1);
Ytilde = zeros(Tburn+T,1);
YA = zeros(Tburn+T,1);
B = zeros(Tburn+T,1);
D = zeros(Tburn+T,1);
E = zeros(Tburn+T,1);
C = zeros(Tburn+T,1);
Q = zeros(Tburn+T,1);
F = zeros(Tburn+T,1);
STATE = zeros(Tburn+T,1);
PM = zeros(Tburn+1,1);
V = zeros((Tburn+1),1);
rstar_annual = ((1+rstar)^4-1)*100; %world interest rae (annualized)

for t=1:T+Tburn

STATE(t,1) = sub2ind([ny nd*ne ],i,j);

rr = rand; %random number  determining reentry if applicable
F(t,1) = f(i,j); %F(t)=1 if default event in period t, 0 otherwise
D(t,1) = d(k); %defaultable debt
E(t,1) = e(l); %non-defaultable debt
Y(t,1) = y(i); %output in good standing
YA(t,1) = ya(i);  %output in autarky
V(t,1) = vg(i,j); %value function in good standing

%choose to continue 
if (b==0) & (F(t)==0) ; 
B(t,1) = 0; %B=0==>good standing at the beginning of current period, after receving reentry signal if applicable, but before making a  default decision. . B==1==>bad  standing at the beginning of current period, after receving reentry signal 
Ytilde(t,1) = y(i);
C(t,1) = cc(i,j);
Q(t,1) = q(i,tix(i,j));
jp  = tix(i,j); %update debt state
end 

%choose to default
if (b==0) & (F(t) ==1) 
B(t,1) = 0; 
Ytilde(t,1) = YA(t);
C(t,1) = cb(i,j);
Q(t,1) = qb(i,DTIX(i,j));
jp = DTIX(i,j); 
end
% aAutarky (bad standing and did not get to re-enter)
if (b==1) & (rr>theta) 
F(t,1) = 0;
B(t,1) = 1; 
Ytilde(t,1) = YA(t);
C(t,1) = cb(i,j);
Q(t,1) = qb(i,j);
jp = j; 
end 

%reentry after having been in bad standing, but decide to not to default
if (b==1) & (rr<=theta) & (F(t,1)==0)  
B(t,1) = 0; 
Ytilde(t,1) = Y(t);
C(t,1) = cc(i,j);
Q(t,1) = q(i,tix(i,j));
jp = tix(i,j);
end 

%reentry after having been in bad standing, and decide  to default 
if (b==1) & (rr<=theta) & (F(t,1)==1) 
B(t,1) = 0; 
Ytilde(t,1) = YA(t);
C(t,1) = cb(i,j);
Q(t,1) = qb(i,DTIX(i,j));
jp = DTIX(i,j);
end 

R(t,1) = ((1/Q(t,1))^4-1)*100; %country interest rate 
PM(t,1) = R(t,1)-rstar_annual;%country risk premium

%update output state
find(cpai(i,:)>rand); 
i = ans(1);

b = B(t) + F(t);

%update debt state
j=jp;
k = (mod(j,nd)~= 0).* mod(j,nd) + (mod(j,nd)== 0)*nd;
l = ceil(j/nd);

end %for t=1:T+Tburn

%eliminate burning period
STATE = STATE(Tburn+1:end);
Y = Y(Tburn+1:end);
YA = YA(Tburn+1:end);
Ytilde = Ytilde(Tburn+1:end);
B = B(Tburn+1:end);
D = D(Tburn+1:end);
E = E(Tburn+1:end);
C = C(Tburn+1:end);
Q = Q(Tburn+1:end);
F = F(Tburn+1:end);
PM = PM(Tburn+1:end);
R = R(Tburn+1:end);
V = V(Tburn+1:end);

for i=1:nd
lad(i,1) = mean(D==d(i));
end
for i=1:ne
lae(i,1) = mean(E==e(i));
end


figure
%plot Empirical distribution defaultable debt
subplot(2,1,1)
bar(d,lad,0.4)
xlabel('d')
ylabel('frequency')
title('Empirical distribution of defaultable debt levels')

%plot Empirical distribution non-defaultable debt
subplot(2,1,2)
bar(e,lae,0.4)
xlabel('e')
ylabel('frequency')
title('Empirical distribution of non-defaultable debt levels')
shg


save simu_egrid20_alpha1s16