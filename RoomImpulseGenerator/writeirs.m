function writeirs(rirs,gain)

if ~exist('gain','var') || isempty(gain)
    gain=1.0;
end

for ii=1:size(rirs,3)
    
%     audiowrite(sprintf('ir%02d.wav',ii),gain*squeeze(rirs(:,:,ii)),16000);
    wavwrite(gain*squeeze(rirs(:,:,ii)),16000,sprintf('ir%02d.wav',ii));
end

    