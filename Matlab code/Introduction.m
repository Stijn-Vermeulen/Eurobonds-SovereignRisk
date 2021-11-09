%%Generate Figure 3.2. Code based on Uribe & Schmitt-Grohé (2017)
clear all
rows =2;
cols = 2;

tb2 = 30;
ta2 = 30;

tb = 4; %periods before default
ta = 24; %periods after default

load simu_intro_egrid20_alpha1s16.mat maxIter Y V YA Ytilde B D C E Intro Q F  PM  T Tburn  rstar theta  nd  

x1 = find(Intro==1);
x1 = x1(x1>tb);
x=x1;

find(x>=tb+1);
x = x(ans);
find(x<=((T*maxIter)-ta));
x = x(ans);

for i=1:length(x)
y_base(i,1:tb+ta+1) =  Y(x(i)-tb:x(i)+ta)';
yaut_base(i,1:tb+ta+1) =  YA(x(i)-tb:x(i)+ta)';
ytilde_base(i,1:tb+ta+1) =  Ytilde(x(i)-tb:x(i)+ta)';
b_base(i,1:tb+ta+1) =  B(x(i)-tb:x(i)+ta)';
d_base(i,1:tb+ta+1) =  D(x(i)-tb:x(i)+ta)';
c_base(i,1:tb+ta+1) =  C(x(i)-tb:x(i)+ta)';
q_base(i,1:tb+ta+1) =  Q(x(i)-tb:x(i)+ta)';
f_base(i,1:tb+ta+1) =  F(x(i)-tb:x(i)+ta)';
e_base(i,1:tb+ta+1) =  E(x(i)-tb:x(i)+ta)';
v_base(i,1:tb+ta+1) =  V(x(i)-tb:x(i)+ta)';
pm_base(i,1:tb+ta+1) =  PM(x(i)-tb:x(i)+ta)';
dy_base(i,1:tb+ta+1) = D(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
ey_base(i,1:tb+ta+1) = E(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
end

t = (-tb:ta);

f = @(x) mean(x);

%exclude default episodes
aux_base = cumsum(f_base,2);

c_base(find(aux_base(:,29)==1),:) = [];
d_base(find(aux_base(:,29)==1),:) = [];
e_base(find(aux_base(:,29)==1),:) = [];
pm_base(find(aux_base(:,29)==1),:) = [];

aux_base2 = cumsum(pm_base(:,1:4),2);
c_base(find(aux_base2(:,4)>=10),:) = [];
d_base(find(aux_base2(:,4)>=10),:) = [];
e_base(find(aux_base2(:,4)>=10),:) = [];
pm_base(find(aux_base2(:,4)>=10),:) = [];


subplot(rows,cols,1)
x=(c_base);plot(t,f(x),'-','linewidth',3)
hold on
x=(c_base);plot(t,f(x)-2*std(c_base,1),'--','linewidth',3,'Color','black')
hold on
x=(c_base);plot(t,f(x)+2*std(c_base,1),'--','linewidth',3,'Color','black')
hold off
title('Consumption','Fontsize', 25,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)

subplot(rows,cols,2)
x=f((d_base/4)*100); 
plot(t,x,'-','linewidth',3)
hold on
plot(t,x-2*std((d_base/4)*100,1),'--','linewidth',3,'Color','black')
hold on
plot(t,x+2*std((d_base/4)*100,1),'--','linewidth',3,'Color','black')
hold off
title('Debt (% of Output)','Fontsize', 25,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)

subplot(rows,cols,3)
x=f(pm_base);
plot(t,x,'-','linewidth',3)
hold on
plot(t,max(0,x-2*std(pm_base,1)),'--','linewidth',3,'Color','black')
hold on
plot(t,max(0,x+2*std(pm_base,0,1)),'--','linewidth',3,'Color','black')
hold off
title('Risk premium','Fontsize', 25,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)

subplot(rows,cols,4)
x=f((e_base/4)*100);
plot(t,x,'-','linewidth',3)
hold on
plot(t,max(0,x-2*std((e_base/4)*100,1)),'--','linewidth',3,'Color','black')
hold on
plot(t,min(10,x+2*std((e_base/4)*100,1)),'--','linewidth',3,'Color','black')
hold off
title('Non-Defaultable Debt (% of Output)','Fontsize', 25,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)


print -depsc Intro_baseline.eps