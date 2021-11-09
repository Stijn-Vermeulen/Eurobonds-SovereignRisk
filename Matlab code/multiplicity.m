%Generate Figure 3.6 & 3.7, choose the right .mat-files to generate the No Eurobond & Eurobond economy 
clear all
load egr_egrid20_alpha1s16_mutlbad.mat vc vb dpix epix q ny nd ne f DTIX
vb_bad = vb;
vc_bad = vc;
vc_bad(find(vc_bad==-inf)) = -10^8;
f_bad = f;
epix_bad = epix;
dpix_bad = dpix;
dtix_bad = DTIX;
q_bad = q;
clear vc vb tix

load egr_egrid20_alpha1s16.mat vc vb dpix q f DTIX
vb_good = vb;
vc_good = vc;
vc_good(find(vc_good==-inf)) = -10^8;
f_good = f;
epix_good = epix;
dpix_good = dpix;
dtix_good = DTIX;
q_good = q;

[X,Y] = meshgrid(1:nd,1:ny);

tiledlayout(2,2)
nexttile
dpix_dif = dpix_good(:,1:nd) - dpix_bad(:,1:nd);
surf(X,Y,dpix_dif)
colormap('bone')
shading interp
light
xlabel('Defaultable debt','Fontsize', 23,'FontWeight','bold')
xticks([50 100 150 200])
x = get(gca,'XTickLabel');
set(gca,'XTickLabel',x,'FontName','Times','fontsize',18)
ylabel('Output','Fontsize', 23,'FontWeight','bold')
y = get(gca,'YTickLabel');
set(gca,'YTickLabel',y,'FontName','Times','fontsize',18)
t = title('\textbf{Difference in outcome Policy Function $\hat{d}$}','Fontsize', 25,'FontWeight','bold')
set(t, 'Interpreter', 'Latex')

nexttile
dtix_dif = dtix_good(:,1:nd) - dtix_bad(:,1:nd);
surf(X,Y,dtix_dif)
colormap('bone')
shading interp
light
xlabel('Defaultable debt','Fontsize', 23,'FontWeight','bold')
xticks([50 100 150 200])
x = get(gca,'XTickLabel');
set(gca,'XTickLabel',x,'FontName','Times','fontsize',18)
ylabel('Output','Fontsize', 23,'FontWeight','bold')
y = get(gca,'YTickLabel');
set(gca,'YTickLabel',y,'FontName','Times','fontsize',18)
t = title('\textbf{Difference in renegotiation policy function $\hat{d}_B$}','Fontsize', 25,'FontWeight','bold')
set(t, 'Interpreter', 'Latex')

nexttile
f_dif = f_good(:,1:nd) - f_bad(:,1:nd);
surf(X,Y,f_dif)
colormap('bone')
shading interp
light
xlabel('Defaultable debt','Fontsize', 23,'FontWeight','bold')
xticks([50 100 150 200])
x = get(gca,'XTickLabel');
set(gca,'XTickLabel',x,'FontName','Times','fontsize',18)
ylabel('Output','Fontsize', 23,'FontWeight','bold')
y = get(gca,'YTickLabel');
set(gca,'YTickLabel',y,'FontName','Times','fontsize',18)
t = title('\textbf{Difference in Default decision $\hat{p}$}','Fontsize', 25,'FontWeight','bold')
set(t, 'Interpreter', 'Latex')


nexttile
q_dif = q_good(:,1:nd) - q_bad(:,1:nd);
surf(X,Y,q_dif)
colormap('summer')
shading interp
light
xlabel('Defaultable debt','Fontsize', 23,'FontWeight','bold')
xticks([50 100 150 200])
x = get(gca,'XTickLabel');
set(gca,'XTickLabel',x,'FontName','Times','fontsize',18)
ylabel('Output','Fontsize', 23,'FontWeight','bold')
y = get(gca,'YTickLabel');
set(gca,'YTickLabel',y,'FontName','Times','fontsize',18)
t = title('\textbf{Difference in Price function $q$}','Fontsize', 25,'FontWeight','bold')
set(t, 'Interpreter', 'Latex')

print -depsc FigureMult_YES.eps


