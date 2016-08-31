%Script for generating RIR files
function rir_gen()

B = (3:6)*0.1;
for i = 1:length(B)
    circle_rir(B(i))
end
end

function circle_rir(beta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out_dir='../rir/';
%beta =0.3;
fs = 16000;
rir_dir = [out_dir,'/t60_',num2str(beta)];
mkdir(rir_dir);
grid = 0:5:359;
[mic, spk]= mic_spk(grid, 3);
for i = 1:length(spk)
    h = rir(mic, spk(i,:), beta,fs);
    out_f = [rir_dir,'/degree_',num2str(grid(i)),'.wav'];
    wavwrite(h, fs, out_f);
end
end 

%%
function h = rir (mic, source, beta,fs)
    c =340;
    L = [7 6 3];
    mtype = 'omnidirectional';    % Type of microphone
    order = -1;                               % -1 equals maximum reflection order!
    dim = 3;                                   % Room dimension
    orientation = [pi/2, 0];                    % Microphone orientation (rad)
    hp_filter = 0;                             % Disable high-pass filter
    nsample = 0.25*fs;                  % Number of samples
    %t = (1:nsample)/fs;
    nmic = size(mic, 1);
    h = zeros(nsample, nmic);
    for i = 1: nmic
        h(:,i)= rir_generator(c, fs, mic(i,:), source, L, beta, nsample, mtype,order,dim,orientation,hp_filter);
    end
end

%%
function [mic, spk]=mic_spk(grid, r)
origin = [3,3,1.5];                     % origin point 
d = 0.035;                                       % 3.5 centimeter            
mic = [1,0;  0,1; -1,0; 0,-1] * d;      %microphone relative pos
nmic = size(mic, 1);
mic = [mic, zeros(nmic,1)];
mic = mic + repmat(origin, nmic,1);

ndirect= length(grid);
[x,y] = pol2cart(grid/180*pi,r);
spk = [x(:),y(:), ones(ndirect,1)*0.2];
spk = spk + repmat(origin, ndirect,1);
end
