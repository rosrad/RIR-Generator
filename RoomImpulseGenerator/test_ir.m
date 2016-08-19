clear all
file = dir('.\2mic_ir_20150917\*.wav');
[x,fs] = wavread('out1.wav');
for i = 1:length(file)
    h = wavread(['D:\Unisound\2mic_ir_20150917\',file(i).name]);
    y = conv(x,h(:,1));
    ps(i) = sqrt(var(y));
    y = conv(x,h(:,1)*ps(1)/ps(i));
%     wavwrite(h*ps(1)/ps(i)*4,16000,['D:\Unisound\2mic_ir_20150917\',file(i).name]);
    wavwrite(y,16000,['D:\Unisound\2mic_ir_20150917\nomorlize\',file(i).name]);
end