%% Simur_regular: simualte the introduction of Eurobonds. Code based on Uribe & Schmitt-Grohé (2017)
%  and adjusted to account for non-defaultable debt. 


clear all, format compact

load egr_egrid1_alpha1s16.mat rstar ny ne nd y

clear t j i k l I
%Length of simulation and burning period + set # of iterations
T = 250;
T_intro = 100;
Tburn = 1000;
maxIter= 1000;

Y = zeros(maxIter*(Tburn+T),1);
Ytilde = zeros(maxIter*(Tburn+T),1);
YA = zeros(maxIter*(Tburn+T),1);
B = zeros(maxIter*(Tburn+T),1);
D = zeros(maxIter*(Tburn+T),1);
E = zeros(maxIter*(Tburn+T),1);
C = zeros(maxIter*(Tburn+T),1);
Q = zeros(maxIter*(Tburn+T),1);
F = zeros(maxIter*(Tburn+T),1);
STATE = zeros(maxIter*(Tburn+T),1);
R = zeros(maxIter*(Tburn+T),1);
PM = zeros(maxIter*(Tburn+T),1);
V = zeros(maxIter*(Tburn+T),1);
K = zeros(maxIter*(Tburn+T),1);
L = zeros(maxIter*(Tburn+T),1);
VG = zeros(maxIter*(Tburn+T),1);
Intro = zeros(maxIter*(Tburn+T),1);
Burn = zeros(maxIter*(Tburn+T),1);
rstar_annual = ((1+rstar)^4-1)*100; %world interest rae (annualized)

for iter2=1:maxIter
load egr_egrid1_alpha1s16.mat tix f e d y vg vb q DTIX cb ny ne ca qb cc nd y pai ya theta
%Initial conditions
[~,i] = min(abs(y-1)); %average endowment (index)
j = floor(nd/2); %middle of debt grid (index)
k = (mod(j,nd)~= 0).* mod(j,nd) + (mod(j,nd)== 0)*nd;
l = ceil(j/nd);
b = 0; %b=1==>bad standing at the end of prevous period;   and  b=1==>good standing at the end of previous period
cpai = cumsum(pai,2);

for t = 1 + ((T+Tburn)*(iter2-1)):(T+Tburn)*iter2
%Mark the burn period, so that these moments can be removed later
if t <= Tburn + (iter2-1)*(T + Tburn)
    Burn(t,1) = 1;
end
%Ensure non-defaultable debt is 0 when not yet introduced.
if t >=1+(Tburn + T_intro)+((iter2-1)*(T + Tburn)) 
    E(t,1) = e(l);
else
    E(t,1) = 0;
end
%After T_intro periods, introduce Eurobonds
if t == (Tburn + T_intro)+((iter2-1)*(T + Tburn))
    Intro(t,1) = 1;
    if find(d==D(t-1,1)) > 2
        k = 100;
    end
    load egr_egrid20_alpha1s16.mat tix nd ny ne f e d y ya vg vb q DTIX cb ca qb cc pai
       
end


K(t,1) = k;
L(t,1) = l;
j = k+ nd*(l-1);
I(t,1) = i;

rr = rand; %random number  determining reentry if applicable
F(t,1) = f(i,j); %F(t)=1 if default event in period t, 0 otherwise
D(t,1) = d(k); 
Y(t,1) = y(i);
YA(t,1) = ya(i);  %output in autarky
V(t,1) = vg(i,j);

if (b==0) & (F(t)==0) ; %choose to continue 
B(t,1) = 0; %B=0==>good standing at the beginning of current period, after receving reentry signal if applicable, but before making a  default decision. . B==1==>bad  standing at the beginning of current period, after receving reentry signal 
Ytilde(t,1) = y(i);
C(t,1) = cc(i,j);
Q(t,1) = q(i,tix(i,j));
jp  = tix(i,j); %update debt state
end 

if (b==0) & (F(t) ==1) %choose to default
B(t,1) = 0; 
Ytilde(t,1) = YA(t);
C(t,1) = cb(i,j);
Q(t,1) = qb(i,DTIX(i,j));
jp = DTIX(i,j); 
end
if (b==1) & (rr>theta)  %==> autarky (bad standing and did not get to re-enter)
F(t,1) = 0;
B(t,1) = 1; 
Ytilde(t,1) = YA(t);
C(t,1) = cb(i,j);
Q(t,1) = qb(i,j);
jp = j; 
end 

if (b==1) & (rr<=theta) & (F(t,1)==0)  %reentry after having been in bad standing, but decide to not to default
B(t,1) = 0; 
Ytilde(t,1) = Y(t);
C(t,1) = cc(i,j);
Q(t,1) = q(i,tix(i,j));
jp = tix(i,j);
end 

if (b==1) & (rr<=theta) & (F(t,1)==1)  %reentry after having been in bad standing, and decide  to default 
B(t,1) = 0; 
Ytilde(t,1) = YA(t);
C(t,1) = cb(i,j);
Q(t,1) = qb(i,DTIX(i,j));
jp = DTIX(i,j);
end 

R(t,1) = ((1/Q(t,1))^4-1)*100; %country interest rate 
PM(t,1) = R(t,1)-rstar_annual;%country risk premium

if PM(t)>1000 & B(t)==0 & F(t)==0

end


%update output state
find(cpai(i,:)>rand); 
i = ans(1);

b = B(t) + F(t);

%update debt state
j=jp;
k = (mod(j,nd)~= 0).* mod(j,nd) + (mod(j,nd)== 0)*nd;
l = ceil(j/nd);

end %for t=1:T+Tburn
clear t


end %iteration

%eliminate burning period
Set = find(Burn ~= 1);
STATE = STATE(Set);
Y = Y(Set);
YA = YA(Set);
Ytilde = Ytilde(Set);
B = B(Set);
D = D(Set);
E = E(Set);
C = C(Set);
Q = Q(Set);
F = F(Set);
PM = PM(Set);
R = R(Set);
V = V(Set);
K = K(Set);
L = L(Set);
I = I(Set);
Intro = Intro(Set);

save simu_intro_egrid20_alpha1s16