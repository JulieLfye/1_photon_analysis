% to understand cross-correlation

n = 0:15;
x = 0.84.^n;
y = circshift(x,5);
[c,lags] = xcorr(x,y);
figure
stem(lags,c)