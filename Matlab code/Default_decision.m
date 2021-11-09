%%Generate Figure 3.1.

clear all
load egr_egrid20_alpha1s16.mat ny nd ne f
f1 = f;

clear f
load egr_egrid1_alpha1s16.mat ny nd f
f2 = f;

Figure2_1 = zeros(ny,nd);

for i = 1:ny
    for j = 1:nd
        if f1(i,j + (ne-1)*nd) == 1 && f1(i,j) == 0
        Figure2_1(i,j) = 2;
        else
            Figure2_1(i,j) = f1(i,j);
        end
    end
end

clear i j

Figure2_2 = zeros(ny,nd);
for i = 1:ny
    for j = 1:nd
        if f2(i,j) ~= f1(i,j)
        Figure2_2(i,j) = 2;
        else
            Figure2_2(i,j) = f1(i,j);
        end
    end
end

Figure2_3 = zeros(ny,nd);
for i = 1:ny
    for j = 1:nd
        if f1(i,j + (ne-1)*nd) ~= f2(i,j)
        Figure2_3(i,j) = 2;
        else
            Figure2_3(i,j) = f2(i,j);
        end
    end
end

tiledlayout(2,2)

nexttile
imagesc(flip(Figure2_2));
colormap(flipud(gray(256)));
xlabel('Defaultable debt (% of Output)','Fontsize', 23,'FontWeight','bold')
xticks([46 90 134 178])
xticklabels({'25%','50%','75%','100%'})
x = get(gca,'XTickLabel');
set(gca,'XTickLabel',x,'FontName','Times','fontsize',18)
ylabel('Output','Fontsize', 23,'FontWeight','bold')
yticks([5 15 25])
yticklabels({'1.21','0.99','0.81'})
y = get(gca,'YTickLabel');
set(gca,'YTickLabel',y,'FontName','Times','fontsize',18)
% title('Default decision (Different economies)','Fontsize', 25,'FontWeight','bold')
clear x y

nexttile
imagesc(flip(Figure2_3));
colormap(flipud(gray(256)));
xlabel('Defaultable debt (% of Output)','Fontsize', 23,'FontWeight','bold')
xticks([46 90 134 178])
xticklabels({'25%','50%','75%','100%'})
x = get(gca,'XTickLabel');
set(gca,'XTickLabel',x,'FontName','Times','fontsize',18)
ylabel('Output','Fontsize', 23,'FontWeight','bold')
yticks([5 15 25])
yticklabels({'1.21','0.99','0.81'})
y = get(gca,'YTickLabel');
set(gca,'YTickLabel',y,'FontName','Times','fontsize',18)
% title('Default decision (Different economies, both at limit e)','Fontsize', 25,'FontWeight','bold')
clear x y

print -depsc default_decision_alpha75.eps
