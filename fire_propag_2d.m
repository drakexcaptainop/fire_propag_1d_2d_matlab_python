nx = 100;
ny = 100;
nt = 100;
t0 = 0; tf = 24; 
x0 = 0;
xf = 10;
y0 = 0;
yf = 10;
dt = ( tf - t0 )/nt;
dx = ( xf - x0 )/nx;
dy = ( yf - y0 )/ny;
D = .01;
K = 1;

U = zeros( nt, nx, ny );
os = 5;
cnt = int16(nx * .5);
U(1, cnt-os:cnt+os, cnt-os:cnt+os) = .1;
R=@(x)exp(-.1/x);
for i=1:(nt - 1)
    for j = 2:(nx-1)
        for k = 2:(ny - 1)
            U(i+1, j, k) = D * dt/(dx*dx) * ( U(i, j-1, k) - 2*U(i,j,k) + U(i, j+1, k) ) + D*dt/(dy*dy) * (U(i, j, k-1) - 2*U(i,j,k) + U(i, j, k+1)) + K *R(U(i,j,k)) * dt + U(i, j, k);
        end
    end
end


ax = axes;

for i=1:nt
imagesc(reshape(U(i, :, :), nx, ny),"Parent",ax)
colormap hot
colorbar
pause(30/1000)
end
