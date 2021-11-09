%%Generate Figure 3.4. Code based on Uribe & Schmitt-Grohé (2017)


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

load simu_intro_egrid20_alpha45.mat maxIter Y V YA Ytilde B D C E Intro Q F  PM  T Tburn  rstar theta  nd  


x1 = find(Intro==1);
x1 = x1(x1>tb);
x=x1;

find(x>=tb+1);
x = x(ans);
find(x<=((T*maxIter)-ta));
x = x(ans);

for i=1:length(x)
y_alpha45(i,1:tb+ta+1) =  Y(x(i)-tb:x(i)+ta)';
yaut_alpha45(i,1:tb+ta+1) =  YA(x(i)-tb:x(i)+ta)';
ytilde_alpha45(i,1:tb+ta+1) =  Ytilde(x(i)-tb:x(i)+ta)';
b_alpha45(i,1:tb+ta+1) =  B(x(i)-tb:x(i)+ta)';
d_alpha45(i,1:tb+ta+1) =  D(x(i)-tb:x(i)+ta)';
c_alpha45(i,1:tb+ta+1) =  C(x(i)-tb:x(i)+ta)';
q_alpha45(i,1:tb+ta+1) =  Q(x(i)-tb:x(i)+ta)';
f_alpha45(i,1:tb+ta+1) =  F(x(i)-tb:x(i)+ta)';
e_alpha45(i,1:tb+ta+1) =  E(x(i)-tb:x(i)+ta)';
v_alpha45(i,1:tb+ta+1) =  V(x(i)-tb:x(i)+ta)';
pm_alpha45(i,1:tb+ta+1) =  PM(x(i)-tb:x(i)+ta)';
dy_alpha45(i,1:tb+ta+1) = D(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
ey_alpha45(i,1:tb+ta+1) = E(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
end

load simu_intro_egrid20_alpha55.mat maxIter Y V YA Ytilde B D C E Intro Q F  PM  T Tburn  rstar theta  nd  


x1 = find(Intro==1);
x1 = x1(x1>tb);
x=x1;

find(x>=tb+1);
x = x(ans);
find(x<=((T*maxIter)-ta));
x = x(ans);


for i=1:length(x)
y_alpha55(i,1:tb+ta+1) =  Y(x(i)-tb:x(i)+ta)';
yaut_alpha55(i,1:tb+ta+1) =  YA(x(i)-tb:x(i)+ta)';
ytilde_alpha55(i,1:tb+ta+1) =  Ytilde(x(i)-tb:x(i)+ta)';
b_alpha55(i,1:tb+ta+1) =  B(x(i)-tb:x(i)+ta)';
d_alpha55(i,1:tb+ta+1) =  D(x(i)-tb:x(i)+ta)';
c_alpha55(i,1:tb+ta+1) =  C(x(i)-tb:x(i)+ta)';
q_alpha55(i,1:tb+ta+1) =  Q(x(i)-tb:x(i)+ta)';
f_alpha55(i,1:tb+ta+1) =  F(x(i)-tb:x(i)+ta)';
e_alpha55(i,1:tb+ta+1) =  E(x(i)-tb:x(i)+ta)';
v_alpha55(i,1:tb+ta+1) =  V(x(i)-tb:x(i)+ta)';
pm_alpha55(i,1:tb+ta+1) =  PM(x(i)-tb:x(i)+ta)';
dy_alpha55(i,1:tb+ta+1) = D(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
ey_alpha55(i,1:tb+ta+1) = E(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
end

load simu_intro_egrid20_alpha65.mat maxIter Y V YA Ytilde B D C E Intro Q F  PM  T Tburn  rstar theta  nd  


x1 = find(Intro==1);
x1 = x1(x1>tb);
x=x1;

find(x>=tb+1);
x = x(ans);
find(x<=((T*maxIter)-ta));
x = x(ans);


for i=1:length(x)
y_alpha65(i,1:tb+ta+1) =  Y(x(i)-tb:x(i)+ta)';
yaut_alpha65(i,1:tb+ta+1) =  YA(x(i)-tb:x(i)+ta)';
ytilde_alpha65(i,1:tb+ta+1) =  Ytilde(x(i)-tb:x(i)+ta)';
b_alpha65(i,1:tb+ta+1) =  B(x(i)-tb:x(i)+ta)';
d_alpha65(i,1:tb+ta+1) =  D(x(i)-tb:x(i)+ta)';
c_alpha65(i,1:tb+ta+1) =  C(x(i)-tb:x(i)+ta)';
q_alpha65(i,1:tb+ta+1) =  Q(x(i)-tb:x(i)+ta)';
f_alpha65(i,1:tb+ta+1) =  F(x(i)-tb:x(i)+ta)';
e_alpha65(i,1:tb+ta+1) =  E(x(i)-tb:x(i)+ta)';
v_alpha65(i,1:tb+ta+1) =  V(x(i)-tb:x(i)+ta)';
pm_alpha65(i,1:tb+ta+1) =  PM(x(i)-tb:x(i)+ta)';
dy_alpha65(i,1:tb+ta+1) = D(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
ey_alpha65(i,1:tb+ta+1) = E(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
end

load simu_intro_egrid20_alpha75.mat maxIter Y V YA Ytilde B D C E Intro Q F  PM  T Tburn  rstar theta  nd  


x1 = find(Intro==1);
x1 = x1(x1>tb);
x=x1;

find(x>=tb+1);
x = x(ans);
find(x<=((T*maxIter)-ta));
x = x(ans);


for i=1:length(x)
y_alpha75(i,1:tb+ta+1) =  Y(x(i)-tb:x(i)+ta)';
yaut_alpha75(i,1:tb+ta+1) =  YA(x(i)-tb:x(i)+ta)';
ytilde_alpha75(i,1:tb+ta+1) =  Ytilde(x(i)-tb:x(i)+ta)';
b_alpha75(i,1:tb+ta+1) =  B(x(i)-tb:x(i)+ta)';
d_alpha75(i,1:tb+ta+1) =  D(x(i)-tb:x(i)+ta)';
c_alpha75(i,1:tb+ta+1) =  C(x(i)-tb:x(i)+ta)';
q_alpha75(i,1:tb+ta+1) =  Q(x(i)-tb:x(i)+ta)';
f_alpha75(i,1:tb+ta+1) =  F(x(i)-tb:x(i)+ta)';
e_alpha75(i,1:tb+ta+1) =  E(x(i)-tb:x(i)+ta)';
v_alpha75(i,1:tb+ta+1) =  V(x(i)-tb:x(i)+ta)';
pm_alpha75(i,1:tb+ta+1) =  PM(x(i)-tb:x(i)+ta)';
dy_alpha75(i,1:tb+ta+1) = D(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
ey_alpha75(i,1:tb+ta+1) = E(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
end

load simu_intro_egrid20_alpha1.mat maxIter Y V YA Ytilde B D C E Intro Q F  PM  T Tburn  rstar theta  nd  


x1 = find(Intro==1);
x1 = x1(x1>tb);
x=x1;

find(x>=tb+1);
x = x(ans);
find(x<=((T*maxIter)-ta));
x = x(ans);


for i=1:length(x)
y_alpha1(i,1:tb+ta+1) =  Y(x(i)-tb:x(i)+ta)';
yaut_alpha1(i,1:tb+ta+1) =  YA(x(i)-tb:x(i)+ta)';
ytilde_alpha1(i,1:tb+ta+1) =  Ytilde(x(i)-tb:x(i)+ta)';
b_alpha1(i,1:tb+ta+1) =  B(x(i)-tb:x(i)+ta)';
d_alpha1(i,1:tb+ta+1) =  D(x(i)-tb:x(i)+ta)';
c_alpha1(i,1:tb+ta+1) =  C(x(i)-tb:x(i)+ta)';
q_alpha1(i,1:tb+ta+1) =  Q(x(i)-tb:x(i)+ta)';
f_alpha1(i,1:tb+ta+1) =  F(x(i)-tb:x(i)+ta)';
e_alpha1(i,1:tb+ta+1) =  E(x(i)-tb:x(i)+ta)';
v_alpha1(i,1:tb+ta+1) =  V(x(i)-tb:x(i)+ta)';
pm_alpha1(i,1:tb+ta+1) =  PM(x(i)-tb:x(i)+ta)';
dy_alpha1(i,1:tb+ta+1) = D(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
ey_alpha1(i,1:tb+ta+1) = E(x(i)-tb:x(i)+ta)'./ (4*Ytilde(x(i)-tb:x(i)+ta))';
end

%exclude default episodes
aux_base = cumsum(f_base,2);
aux_alpha55 = cumsum(f_alpha55,2);
aux_alpha65 = cumsum(f_alpha65,2);
aux_alpha75 = cumsum(f_alpha75,2);
aux_alpha1 = cumsum(f_alpha1,2);

c_base(find(aux_base(:,29)==1),:) = [];
c_alpha55(find(aux_alpha55(:,29)==1),:) = [];
c_alpha65(find(aux_alpha65(:,29)==1),:) = [];
c_alpha75(find(aux_alpha75(:,29)==1),:) = [];
c_alpha1(find(aux_alpha1(:,29)==1),:) = [];

d_base(find(aux_base(:,29)==1),:) = [];
d_alpha55(find(aux_alpha55(:,29)==1),:) = [];
d_alpha65(find(aux_alpha65(:,29)==1),:) = [];
d_alpha75(find(aux_alpha75(:,29)==1),:) = [];
d_alpha1(find(aux_alpha1(:,29)==1),:) = [];

e_base(find(aux_base(:,29)==1),:) = [];
e_alpha55(find(aux_alpha55(:,29)==1),:) = [];
e_alpha65(find(aux_alpha65(:,29)==1),:) = [];
e_alpha75(find(aux_alpha75(:,29)==1),:) = [];
e_alpha1(find(aux_alpha1(:,29)==1),:) = [];

pm_base(find(aux_base(:,29)==1),:) = [];
pm_alpha55(find(aux_alpha55(:,29)==1),:) = [];
pm_alpha65(find(aux_alpha65(:,29)==1),:) = [];
pm_alpha75(find(aux_alpha75(:,29)==1),:) = [];
pm_alpha1(find(aux_alpha1(:,29)==1),:) = [];

aux_base2 = cumsum(pm_base(:,1:4),2);
aux2_alpha55 = cumsum(pm_alpha55(:,1:4),2);
aux2_alpha65 = cumsum(pm_alpha65(:,1:4),2);
aux2_alpha75 = cumsum(pm_alpha75(:,1:4),2);
aux2_alpha1 = cumsum(pm_alpha1(:,1:4),2);

c_base(find(aux_base2(:,4)>=10),:)= [];
c_alpha55(find(aux2_alpha55(:,4)>=10),:) = [];
c_alpha65(find(aux2_alpha65(:,4)>=10),:) = [];
c_alpha75(find(aux2_alpha75(:,4)>=10),:) = [];
c_alpha1(find(aux2_alpha1(:,4)>=10),:)= [];

d_base(find(aux_base2(:,4)>=10),:) = [];
d_alpha55(find(aux2_alpha55(:,4)>=10),:) = [];
d_alpha65(find(aux2_alpha65(:,4)>=10),:) = [];
d_alpha75(find(aux2_alpha75(:,4)>=10),:) = [];
d_alpha1(find(aux2_alpha1(:,4)>=10),:) = [];

e_base(find(aux_base2(:,4)>=10),:)= [];
e_alpha55(find(aux2_alpha55(:,4)>=10),:) = [];
e_alpha65(find(aux2_alpha65(:,4)>=10),:) = [];
e_alpha75(find(aux2_alpha75(:,4)>=10),:) = [];
e_alpha1(find(aux2_alpha1(:,4)>=10),:) = [];

pm_base(find(aux_base2(:,4)>=10),:) = [];
pm_alpha55(find(aux2_alpha55(:,4)>=10),:) = [];
pm_alpha65(find(aux2_alpha65(:,4)>=10),:) = [];
pm_alpha75(find(aux2_alpha75(:,4)>=10),:) = [];
pm_alpha1(find(aux2_alpha1(:,4)>=10),:) = [];

t = (-tb:ta);

f = @(x) mean(x);


subplot(rows,cols,1)
x=(c_base);plot(t,f(x),'-','linewidth',3,'color','[0.3467    0.5360    0.6907]')
hold on
x=(c_alpha55);plot(t,f(x),'--','linewidth',3,'color','[0.9153    0.2816    0.2878]')
hold on
x=(c_alpha65);plot(t,f(x),'-.','linewidth',3,'color','[0.4416    0.7490    0.4322]')
hold on
x=(c_alpha75);plot(t,f(x),':','linewidth',3,'color','[    1.0000    0.5984    0.2000]')
hold on
x=(c_alpha1);plot(t,f(x),'-','linewidth',3,'color','[0.6769    0.4447    0.7114]')
hold off
title('Consumption','Fontsize', 25,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)

subplot(rows,cols,2)
x=f((d_base/4)*100); 
plot(t,x,'-','linewidth',3,'color','[0.3467    0.5360    0.6907]')
hold on
x=f((d_alpha55/4)*100); 
plot(t,x,'--','linewidth',3,'color','[0.9153    0.2816    0.2878]')
hold on
x=f((d_alpha65/4)*100); 
plot(t,x,'-.','linewidth',3,'color','[0.4416    0.7490    0.4322]')
hold on
x=f((d_alpha75/4)*100); 
plot(t,x,':','linewidth',3,'color','[    1.0000    0.5984    0.2000]')
hold on
x=f((d_alpha1/4)*100); 
plot(t,x,'-','linewidth',3,'color','[0.6769    0.4447    0.7114]')
hold off
title('Debt (% of Output)','Fontsize', 25,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)

subplot(rows,cols,3)
x=f(pm_base);
plot(t,x,'-','linewidth',3,'color','[0.3467    0.5360    0.6907]')
hold on
x=f(pm_alpha55);
plot(t,x,'--','linewidth',3,'color','[0.9153    0.2816    0.2878]')
hold on
x=f(pm_alpha65);
plot(t,x,'-.','linewidth',3,'color','[0.4416    0.7490    0.4322]')
hold on
x=f(pm_alpha75);
plot(t,x,':','linewidth',3,'color','[    1.0000    0.5984    0.2000]')
hold on
x=f(pm_alpha1);
plot(t,x,'-','linewidth',3,'color','[0.6769    0.4447    0.7114]')
hold off
title('Risk premium','Fontsize', 25,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)

subplot(rows,cols,4)
x=f((e_base/4)*100);
plot(t,x,'-','linewidth',3,'color','[0.3467    0.5360    0.6907]')
hold on
x=f((e_alpha55/4)*100);
plot(t,x,'--','linewidth',3,'color','[0.9153    0.2816    0.2878]')
hold on
x=f((e_alpha65/4)*100);
plot(t,x,'-.','linewidth',3,'color','[0.4416    0.7490    0.4322]')
hold on
x=f((e_alpha75/4)*100);
plot(t,x,':','linewidth',3,'color','[    1.0000    0.5984    0.2000]')
hold on
x=f((e_alpha1/4)*100);
plot(t,x,'-','linewidth',3,'color','[0.6769    0.4447    0.7114]')
hold off
title('Non-Defaultable Debt (% of Output)','Fontsize', 25,'FontWeight','bold')
xlim([-tb ta])
set(gca,'xtick', [-tb:4:ta],'FontName','Times','fontsize',18)
h= legend('$baseline$','$\alpha = 0.55$','$\alpha = 0.65$','$\alpha = 0.75$','$\alpha = 1$','Location','southeast', 'fontsize', 20)
set(h, 'Interpreter', 'Latex')


print -depsc Intro_comp.eps