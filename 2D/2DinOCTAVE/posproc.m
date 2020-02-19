hold off;
foldin = "teste/*.dat";
dic = glob(foldin);
[rows cols] = size(dic);
num = 30;
index = floor(linspace(1, rows, num)); 
for i = 1 : num
  snome = dic{index(i)};
  theta = dlmread(snome);
  colormap(hot(7));
  z = pcolor(theta);
  foldout = sprintf("figures1/%03d.png", i);
  saveas(z, foldout);
endfor
