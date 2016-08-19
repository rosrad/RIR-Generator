
%[x,fs,nbits]=wavread('SA1.wav');
%x = [x;x;x;x;x;x];
for i=1:3
    if(1==i)
        beta=0.3;
    end
    if(2==i)
        beta=0.6;
    end
    if(3==i)
        beta=0.9;
    end
    fs = 16000;
    c = 340;                    % Sound velocity (m/s)
    % fs = 8000;                 % Sample frequency (samples/s)
    r1 = [1,1.95,2];              % Receiver position [x y z] (m)
    r2 = [1,2.00,2];              % Receiver position [x y z] (m)
    s = [2,2,1.7];          % Source position [x y z] (m)
    dis = norm(r1-s);
    L = [6 5 3];                % Room dimensions [x y z] (m)
    %beta = 0.6;                 % Reverberation time (s)，若在自由场中，则应写成 [0,0,0]
    n = (beta+0.1)*fs;                   % Number of samples
    mtype = 'omnidirectional';    % Type of microphone
    order = -1;                 % -1 equals maximum reflection order!
    dim = 3;                    % Room dimension
    orientation = pi/2;         % Microphone orientation (rad)
    hp_filter = 1;              % Disable high-pass filter
    
    h1 = rir_generator(c, fs, r1, s, L, beta, n, mtype,order,dim,orientation,hp_filter);
    h2 = rir_generator(c, fs, r2, s, L, beta, n, mtype,order,dim,orientation,hp_filter);

    wavwrite([h1',h2'],fs,sprintf('IR_%.1f_160722_5cm.wav',beta));
end