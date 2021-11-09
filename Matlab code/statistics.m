%%Generate the long-run statistics. Based on Code Uribe & Schmitt-Grohé
%%(2017)


clear all
%load correct simulation.mat file
load simu_egrid20_alpha1s16.mat V Y YA Ytilde B D C Q F E  PM  T Tburn  ygrid pai rstar beta theta sigma dupper dlower nd 

%Find all values for which the government is in good standing and has not
%defaulted in the current period.
x = find(B==0&F==0& PM~=inf);
x = x(x~=1);
x_1 = x -1;


gdp = Ytilde(x); 
tby = TBY(x);
pm = PM(x);
dy = D(x)./(4*Ytilde(x))*100;
debt_service = (D(x)-D(x_1))./(4*Ytilde(x))*100;
ey = E(x)./(4*Ytilde(x))*100;
v = V(x);

corr([pm log(gdp)]);
corr_pm_gdp = ans(2,1);
corr([pm tby]);
corr_pm_tby = ans(2,1);

default_frequency = mean(F)*4*100;

default_frequency_good_standing = mean(F(B==0))*4*100;

kk=find(F==1);
haircut = (1-D(kk+1)./D(kk))*100;


%Produce a vector L: the length of L indicates the number of exclusion events, 
%and L(i) is the length in quarters of  exclusion event i. 
%An exclusion event is a period. 
%An exclusion event is a period of time  in which the country is in bad standing and that is preceeded and followed by a quater in which the country 
%is in good financial standing and chooses not to default. 
%Make sure the first observation is good standing (B(1)=0), and no default
%F(1) =0 
find(B==0&F==0);
t0=ans(1); 

B=B(t0:end);F=F(t0:end);
D=D(t0:end);

i = 0; %index of exclusion episode
T=length(B);

for t=2:T-1

if F(t)==1 & B(t-1)==0 & F(t-1)==0
i = i+1; %index of exclusion period (a change in i indicates the beginning of a new exclusion period)
L(i,1) = 0; %length of exclusion period
NF(i,1) = 0; %number of defaults in exclusion period
D0(i,1) = D(t); %Debt at the beginning of the exclusion period (before haircut)
end

if B(t)+F(t)>0
L(i,1) = L(i,1)+1;
NF(i,1) = NF(i)+F(t);
DF(i,1) = D(t+1); %debt at the end of the exclusion period
end
end

H = 1-DF./D0; %haircut


stat_model1 = [ default_frequency mean(dy) mean(ey) mean(pm) std(pm) corr_pm_gdp corr_pm_tby ]
if D0 ~= 0
corr([L H]);
end
stat_model2 = [min(haircut) max(haircut) mean(haircut)  std(haircut) ans(2,1)]

name = 'egrid20_alpha1s16';
eval(['save stat_model_' name])
