%Eaton Gersovitz model with non-defaultable debt and renegotiation of debt
%after default. Code based on Uribe & Schmitt-Grohé (2017)
clear all
%%Create the grid for the Discrete State Space approach

%Exogenous Process for Endowment, created by tpm.m following the method 
%prescribed by Uribe & Schmitt-Grohé (2017).ygrid=endowment grid;
%pai=transition probability matrix
load tpm_rho90.mat ygrid pai  
%number of grid points for log of ouput
ny = numel(ygrid);
%level of output
y = exp(ygrid(:)); 

%Defaultable debt grid
dupper = 4.5;
dlower = 0.0001;
nd =200; % # of grid points for debt 
d = linspace(dlower,dupper,nd);
d = d(:); 

%non-defaultable debt grid
eupper = 0.40;%annualized 0.4 equals 10% of gdp.
elower = 0.00; 
ne = 20;
e = linspace(elower,eupper,ne);
e = e(:);
index_e = (1:ne);

%total number of states 
n = ny*nd*ne;

%%Standard calibration parameters
rstar = 0.01;  %quarterly risk-free interest rate. 
theta=0.282; %probability of reentyy. 
sigma = 2; %coefficient of relative risk aversion

%%Target calibration parameters
beta = 0.90;% quarterly discount factor
a1 = -0.25; %linear output loss
a2 =(1-a1)/2/max(y); %quadratic output loss
alpha = 1;%bargaining power of borrower
%set the standard haircut value and find the closest value to it on the debt grid
haircut = 1.6;
[~,s] = min(abs(d-haircut)); %index of standard haircut value

%%Create auxiliary matrices of indices for d, e and y.
%matrix for  indices of output given the current state (size ny-by-nd*ne)
yix = repmat((1:ny)',1,nd*ne);
%matrix for  indices of debt given the current state (size ny-by-nd*ne)
dix = repmat(1:nd,ny,ne);
%matrix for indeces of non-defaultable debt given the current
%state (size ny-by-nd*ne)
eix = repmat(index_e,ny,nd);
eix = sort(eix,2,'ascend');

%Output loss when defaulting
ya =  y - max(0,a1*y + a2*y.^2); 
yatry = repmat(ya,ne*nd,nd*ne);

%%Find value function under Autarky V_A
%Consumption under autarky
ca = repmat(ya, [1 nd*ne]); %consumption of under autarky
ua = ( ca.^(1-sigma)-1)  / (1-sigma);  %period utility under autarky
%value of autarky
va = zeros(ny,nd*ne);
dist = 1;
while dist>1e-21
vanew = ua + beta * pai * va;
dist = max(abs(vanew(:)-va(:)))
va = vanew;
end


%%Form matrices with rows representing every possible starting location and
%%columns the choice of both non-defaultable and defaultable debt next
%%period. For the first NY*ND rows non-defaultable debt will be set equal
%%to the first point in the grid (here: e=0). The next NY*ND is the second
%%point of the grid, etc.

%Current debt d_t: lists for every possible starting position the current
%debt level. (e.g. first nd rows debt is 0, next nd rows debt is dix=2,
%etc.)
dtry = repmat(d',[ny 1 ne nd ne]);
dtry = reshape(dtry,n,nd*ne);
%debt next period d_t+1: same logic as d_t, but now columns will stay fixed
%(e.g. first column debt is 0, second column dix2, etc.)
dptryix = repmat(1:nd,n,ne);
dptry = d(dptryix);
%output current period y_t
ytryix = repmat(yix,nd*ne,1);
ytry = y(ytryix);
%Current non-defaultable debt e_t
etry = repmat(e,[ny*nd nd*ne]);
etry = sort(etry);
save('auxiliary1.mat', 'dtry', 'dptry', 'ytry','-v7.3')
clear ytryyix ytry dtry dptry
%non-defaultable debt next period e_t+1
eptryix = repmat(eix,nd*ne,1);
eptry = e(eptryix);
save('auxiliary3.mat','eptry','-v7.3')
clear eptryix
%non-defaultable debt next period when in bad standing, you cannot issue
%more non-defaultable debt than you already had last period.
ebptry = eptry;
for k = 1:ne
    for j = 1:ne
        if j>k
        ebptry(1+ny*nd*(k-1):nd*ny*k,1+(j-1)*nd:nd*j)=ebptry(1+ny*nd*(k-1):nd*ny*k,1+(k-1)*nd:nd*k);
        end
    end
end

%%BAD STANDING
%Consumption under bad standing (only non-defaultable debt available)
cbtry = yatry - etry + (ebptry/(1+rstar));
clear yatry ebptry
%Utility under bad standing
ubtry_aux = (cbtry.^(1-sigma) -1)  / (1-sigma);
ubtry_aux(cbtry<=0) = -inf;
ubtry= zeros(ny*nd*ne,ne);
for j=1:ne
    ubtry(:,j) = ubtry_aux(:,1+(j-1)*nd);
end
save('auxiliary2.mat','ubtry','-v7.3');

%%Initialize the Value functions
vc = zeros(ny,nd*ne);  %continue repaying
vg = zeros(ny,nd*ne); %good standing
vb = zeros(ny,nd*ne); %bad standing
vd = zeros(ny,nd*ne); %bad standing 
tix = zeros(ny,nd*ne); %debt policy function (expressed in indices)
btix = zeros(ny,nd*ne); %debt policy function when in bad standing (only non-defaultable debt is a choice variable)
dtix = round(mean(1:nd))*ones(ny,nd*ne); %renegotiation policy function
I = zeros(ny,nd*ne); %empty index function for later use
aux1 = zeros(ny,nd*ne);%empty auxiliary function for later use

%%Starting point values chosen for the test for multiplicity
f = zeros(ny,nd*ne); %default indicator 1 if default, 0 otherwise
q = ones(ny,nd*ne)/(1+rstar); %initial price of debt
qb =ones(ny,nd*ne)/(1+rstar); %initial price of debt in bad state


%Initiate new value and policy functions:
vcnew = vc;
vbnew = vb;
vdnew= vd;
tixnew = tix;
btixnew = btix;
dtixnew = dtix;

%Create a special renegotiated debt function if alfa = 1, this to simulate
%a similar scenario as in Hatchondo et al. (dB = min(d,dS))
if alpha == 1
    dtix2 = ones(ny,nd*ne);
    TIX = dix + (eix-1)*nd;
    dtix2 = min(s ,dix);
    dtixnew2=dtix2;
end

clear ubtry_aux *tryix
load auxiliary1.mat ytry dtry
B = ytry - dtry - etry + eptry;
clear *try 


load auxiliary1.mat dptry
load auxiliary2.mat ubtry
load auxiliary3.mat eptry

dist = 1;
iter = 0;
while dist>1e-8

qtry = repmat(q,[nd*ne 1]);
ctry = B + dptry .* qtry;
utry = (ctry.^(1-sigma) -1)  / (1-sigma);
utry(ctry<=0) = -inf;

%Value function for continuation
evgptry = pai *  vg;
Evgptry = repmat(evgptry,nd*ne,1);
[vcnew(:), tixnew(:)] = max(utry+beta*Evgptry,[],2);

%Value function bad standing: only non-defaultable debt is a choice
%variable
vg_b = reshape(pai*vg,[ny*nd*ne,1]);
vb_b = reshape(pai*vb,[ny*nd*ne,1]);
vg_b = repmat(vg_b,1,ne);
vb_b = repmat(vb_b,1,ne);
[vbnew(:),btixnew(:)] = max(ubtry + beta*(theta*vg_b + (1-theta) * vb_b),[],2);

%default indicator 1 if default, 0 otherwise
f = vcnew<vdnew; 

%Create a distinction between alfa = 1 and other scenarios. Under Alfa = 1
%the government has all power and full control over the value of
%renegotiated debt. Alfa < 1 the power is divided between the government
%and investors.
if alpha == 1
    (mod(dtix2(:),nd)~= 0).* mod(dtix2(:),nd) + (mod(dtix2(:),nd)== 0)*nd;
    dt = d(ans);
    dt = reshape(dt, [ny nd*ne]);
    aux_dtix2 = reshape(dtix2,n,1);
    aux_y = repmat((1:ny)',nd*ne,1);
    I(:) = sub2ind([ny nd*ne],aux_y,aux_dtix2);
    aux1 = qb(I);
    aux2 = dt./ dptry(1:ny,:);
else
    (mod(dtix(:),nd)~= 0).* mod(dtix(:),nd) + (mod(dtix(:),nd)== 0)*nd;
    dt = d(ans);
    dt = reshape(dt, [ny nd*ne]);
    aux_dtix = reshape(dtix,n,1);
    aux_y = repmat((1:ny)',nd*ne,1);
    I(:) = sub2ind([ny nd*ne],aux_y,aux_dtix);
    aux1 = qb(I);
    aux2 = dt./ dptry(1:ny,:);
end

%price functions for q and qb
qbnew = (1-theta) * pai * qb / (1+rstar) + theta * (1-pai*f) / (1+rstar) + theta *  pai * (aux2.*f.*aux1) / (1+rstar);
qnew = (1- pai*f)/(1+rstar) + pai *  (aux2.*f.*aux1) / (1+rstar);

clear aux1 aux2

%Renegotiation process
surplus_debtor =  max(0,vb-va) ./ (ca.^(-sigma));
surplus_creditor = qb.*dptry(1:ny,:) + e(eix)./(1+rstar);
bargain = (surplus_debtor).^alpha .* (surplus_creditor).^(1-alpha);
[~,aux_dtixnew] = max(bargain,[],2);

%Formation of true value of defaulting V_D
if alpha == 1
    dtixnew2 = ((btixnew-1)*nd) + dtix2;
    sub2ind([ny nd*ne],aux_y,reshape(dtixnew2,[n 1]));
    vdnew(:) = vb(ans); 
else
    aux_dtixnew = (mod(aux_dtixnew(:),nd)~= 0).* mod(aux_dtixnew(:),nd) + (mod(aux_dtixnew(:),nd)== 0)*nd;
    dtixnew = ((btixnew-1)*nd) + aux_dtixnew;
    sub2ind([ny nd*ne],aux_y,reshape(dtixnew,[n 1]));
    vdnew(:) = vb(ans); 
end
    
dist = max(abs(qnew(:)-q(:))) +  max(abs(qbnew(:)-qb(:))) +max(abs(vcnew(:)-vc(:))) + max(abs(vbnew(:)-vb(:))) + max(abs(vdnew(:)-vd(:))) + max(abs(dtixnew(:)-dtix(:))) + max(abs(tixnew(:)-tix(:))) + max(abs(btixnew(:)-btix(:)))

q = qnew;
qb = qbnew;
vc = vcnew;
vb = vbnew;
vd = vdnew;
vg = max(vc,vd);
tix = tixnew;
btix = btixnew;
dtix = dtixnew;
iter = iter + 1;
disp(['Iteration :  ' num2str(iter)])
end %while dist>...


disp(['# of iterations :  ' num2str(iter)])

DTIX = zeros(ny,nd*ne);
if alpha == 1
    DTIX = dtixnew2;
else
    DTIX = dtix;
end
clear B *try

%Policy functions under continuation;
%convert the chosen index tixnew to the choice for defaultable and
%non-defaultable debt respectivily.
dpix = zeros(ny,nd*ne);
epix = dpix;
dpix(:) = (mod(tix(:),nd)~= 0).* mod(tix(:),nd) + (mod(tix(:),nd)== 0)*nd;
epix(:) = ceil(tix(:)/nd);
%debt choice under continuation
dpc = d(dpix);
epc = e(epix);
epb = e(btix);
%consumption of tradables  under continuation
I = sub2ind([ny nd*ne],yix,tix);
cc = q(I).*dpc+y(yix)-e(eix)+(epc/(1+rstar))- d(dix); 
cb = y(yix)-e(eix)+(epb/(1+rstar));
clear *try *new *tryix I aux*

figure
spy(f)
xlabel('Choice of debt (low to high)')
ylabel('output (high to low)')
title('Default decision')

save egr_egrid20_alpha1s16