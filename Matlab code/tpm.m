% discretizes the scalar VAR(1) process:
%y_t = rho * y_t-1 + sigma_epsilon * epsilon_t, where epsilon_t follows a normal (0,1) distribution.  
%Output:
%ygrid is the grid  of y_t values
%pai  transition probability matrix, 
%(c) Martín Uribe, May 2014.

clear all

rho = 0.90;
sigma_epsilon = 0.03;
W = 4.2; %width of y_t grid  around its mean (0). The width is measured in terms of standard deviations 

N1 = 30; 
%N1 indicates the initial number of grid  points. This number may be reduced if some points are never visited. 

T = 1e7; %Length of the time series of simulated values of output  used for estimating the transition probability matrix

%set randomization seed
randn('state',0);

stdy= sigma_epsilon/sqrt(1-rho^2);%unconditional variance of y_t
mu = -0.5*sigma_epsilon^2;
sigma_eps = sigma_epsilon^2;
UB = W*stdy; %highest value of y_t grid
ygrid = -UB: 2*UB / (N1-1) : UB; %grid for y_t

PAI = zeros(N1,N1,10); %initialize of transition probability matrix

%Simulate time series for log(gdp_traded)

%initialize simulation
[~,i0] = min(abs(ygrid));
y0 = ygrid(i0);

%Drawing
for t=2:T
y1 = (1-rho)*mu + y0*rho + randn*sigma_epsilon;
[~,i1] = min(abs(y1-ygrid));

%assign draw to transition probability matrix
PAI(i0,i1) = PAI(i0,i1) + 1;
y0 = y1;
i0 = i1;
end

%eliminate all rows and columns with all elements equal to zero
pai = PAI(sum(PAI,2)~=0,sum(PAI,1)~=0);
pai = pai ./ repmat(sum(pai,2),[1,size(pai,2)]);
keep = find(sum(PAI,2)~=0);
ygrid = ygrid(keep);
ygrid = ygrid(:);
N = length(ygrid);

save tpm_rho90.mat  pai ygrid