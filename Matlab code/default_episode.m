%Generate Figure 3.3. Code based on Uribe & Schmitt-Grohé (2017)

clear all
rows =2;
cols = 2;

tb = 24; %periods before default
ta = 12; %periods after default

load simu_egrid1_alpha1s16.mat Y YA Ytilde B D C Q F PM  T Tburn  ygrid pai rstar beta theta sigma dupper dlower nd 

x1 = find(F==1);
x1 = x1(x1>tb);
x=x1;

find(x>=tb+1);
x = x(ans);
find(x<=T-ta);
x = x(ans);

for i=1:length(x)
y(i,1:tb+ta+1) =  Y(x(i)-tb:x(i)+ta)';
yaut(i,1:tb+ta+1) =  YA(x(i)-tb:x(i)+ta)';
ytilde(i,1:tb+ta+1) =  Ytilde(x(i)-tb:x(i)+ta)';
b(i,1:tb+ta+1) =  B(x(i)-tb:x(i)+ta)';
d(i,1:tb+ta+1) =  D(x(i)-tb:x(i)+ta)';
c(i,1:tb+ta+1) =  C(x(i)-tb:x(i)+ta)';
q(i,1:tb+ta+1) =  Q(x(i)-tb:x(i)+ta)';
f(i,1:tb+ta+1) =  F(x(i)-tb:x(i)+ta)';
pm(i,1:tb+ta+1) =  PM(x(i)-tb:x(i)+ta)';
dy(i,1:tb+ta+1) = D(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
end
clear i  Y YA Ytilde B D C Q F TAU  PM  T Tburn  ygrid pai rstar betta theta sigg dupper dlower nd

load simu_egrid20_alpha1s16.mat Y YA Ytilde B D C E Q F  PM  T Tburn  ygrid pai rstar beta theta sigma dupper dlower nd 
x1 = find(F==1);
x1 = x1(x1>tb);
x=x1;

find(x>=tb+1);
x = x(ans);
find(x<=T-ta);
x = x(ans);

for i=1:length(x)
y2(i,1:tb+ta+1) =  Y(x(i)-tb:x(i)+ta)';
yaut2(i,1:tb+ta+1) =  YA(x(i)-tb:x(i)+ta)';
ytilde2(i,1:tb+ta+1) =  Ytilde(x(i)-tb:x(i)+ta)';
b2(i,1:tb+ta+1) =  B(x(i)-tb:x(i)+ta)';
d2(i,1:tb+ta+1) =  D(x(i)-tb:x(i)+ta)';
c2(i,1:tb+ta+1) =  C(x(i)-tb:x(i)+ta)';
q2(i,1:tb+ta+1) =  Q(x(i)-tb:x(i)+ta)';
f2(i,1:tb+ta+1) =  F(x(i)-tb:x(i)+ta)';
e2(i,1:tb+ta+1) =  E(x(i)-tb:x(i)+ta)';
pm2(i,1:tb+ta+1) =  PM(x(i)-tb:x(i)+ta)';
dy2(i,1:tb+ta+1) = D(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
ey2(i,1:tb+ta+1) = E(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
end

t = (-tb:ta);

f = @(x) mean(x);

clf

subplot(rows,cols,1)
x=(ytilde);plot(t,f(x),'-','linewidth',3) 
hold on 
x=(ytilde2);plot(t,f(x),'-','linewidth',3) 
hold on 
x=(y);plot(t,f(x),'--','linewidth',3)
hold on
x=(y2);plot(t,f(x),'--','linewidth',3)
hold off
h = legend('No Eurobonds (actual)','Eurobonds (actual)','No Eurobonds (counterfactual)','Eurobonds (counterfactual)','Location','southwest','fontsize',18)
set(h, 'Interpreter', 'Latex')
title('Output','Fontsize', 30,'FontWeight','bold')
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)
xlim([-tb ta])
ylim([0.7 1.02])

subplot(rows,cols,2)
x=(c);plot(t,f(x),'-','linewidth',3)
hold on 
x=(c2);plot(t,f(x),'-','linewidth',3) 
hold off
title('Consumption','Fontsize', 30,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)

subplot(rows,cols,3)
x=f((d/4)*100);
plot(t,x,'-','linewidth',3);
hold on 
x=f((d2/4)*100);
plot(t,x,'-','linewidth',3);
hold off
title('Debt (% of Output)','Fontsize', 30,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)

subplot(rows,cols,4)
x=f(pm);
plot(t,x,'-','linewidth',3)
hold on
x=f(pm2);
plot(t,x,'-','linewidth',3)
hold off
title('Risk premium','Fontsize', 30,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)

print -depsc typical_default_baseline.eps