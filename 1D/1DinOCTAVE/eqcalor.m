figure(1, "visible", "off");
hold on

k = 1.0;
L = 5.0; 
tempo = 10.0;
N = 500;
Nt= 400;
num_curvas = 15;

h = L/N;
dt = tempo/Nt;

theta_0 = 35;
theta_a = 100;
theta_b = 150;

alpha = k*dt/(h**2);

A = zeros(N-1, N-1);
theta = zeros(N-1, 1);
x = linspace(0, L, N + 1);
t = linspace(0, tempo, Nt + 1);
index = uint16(linspace(1, Nt + 1,
        num_curvas-1)); 

for i = 1:N-1
   theta(i) = theta_0;
endfor

for i = 1:N-1
   A(i,i) = 1 + 2*alpha;
endfor

for i = 1:N-2
   A(i,i+1) = -alpha;
endfor

for i = 2:N-1
   A(i,i-1) = -alpha;
endfor

# perfil inicial 
y = [theta_a theta' theta_b];
plot(x, y, "linewidt", 3);

# laco temporal
id = 2;
for k = 2 : Nt+1 

F = zeros(N-1, 1);
for i = 1:N-1
   F(i, 1) = theta(i, 1);
endfor
F(1) += alpha * theta_a;
F(N-1) += alpha * theta_b;

theta = A\F;

y = [theta_a theta' theta_b]; 

if ( index(id)==k )
   plot(x, y, "linewidt", 3);
   id += 1;
endif

endfor

saveas(1, "result.png");



