figure(1, "visible", "off");
clf;
hold off;  

kapa = 0.001;
L = 1.0;
tempo = 50.0;
N = 100;
Nt= 500;

h = L/N;
dt = tempo/Nt;
num_map = 100;

theta_0 = 30;
theta_n = 60;
theta_s = 150;
theta_o = 100;
theta_l = 200;

alpha = kapa*dt/(2*h**2);

A = sparse(N-1, N-1); %matriz dos coeficientes
theta = ones(N+1, N+1)*theta_0;
x = linspace(0, L, N + 1);
t = linspace(0, tempo, Nt + 1);
index = floor(linspace(1, Nt + 1, num_map)); 

for i = 1:N-1
  A(i,i) = (1+2*alpha);
endfor

for i = 1:N-2
   A(i,i+1) = -alpha;
endfor

for i = 2:N-1
   A(i,i-1) = -alpha;
endfor

for i = 1:N+1
  theta(1, i) = theta_n;
  theta(i, 1) = theta_o;
  theta(N+1, i) = theta_s;
  theta(i, N+1) = theta_l;
endfor

inver = inv(A);

%laco temporal
id = 2;
F = zeros(N-1, 1);
for k = 2 : Nt
  printf("%.1f%%\n", (k-2)*100/Nt);
  for j = 2 : N 
    for  i = 2 : N
      c1 = alpha*theta(i, j-1);
      c2 = (1-2*alpha)*theta(i, j);
      c3 = alpha*theta(i, j+1);
      F(i-1) = c1 + c2 + c3;
    endfor
    F(1) += alpha*theta(1, j);
    F(N-1) += alpha*theta(N+1, j);
    r = inver*F;
    theta(2:N, j) = r;
  endfor

  for i = 2 : N
    for j = 2 : N
      c1 = alpha*theta(i-1, j);
      c2 = (1-2*alpha)*theta(i, j);
      c3 = alpha*theta(i+1, j);
      F(j-1) = c1 + c2 + c3;
    endfor
    F(1) += alpha*theta(i, 1);
    F(N-1) += alpha*theta(i, N+1);
    r = inver*F;
    theta(i, 2:N) = r;
  endfor
  
if (index(id) == k)
  colormap(hot(7));
  clf;
  z = pcolor(x, x, theta);  
  axis tight;
  id += 1;
  snome = sprintf("teste/%03d.dat", id-1);
  dlmwrite(snome, theta);
  #saveas(z, snome);
endif

endfor

