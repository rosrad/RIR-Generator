function rirs=genrirs(Fs,beta,rt_type,rt_val,X_src,X_rcv,room,varargin)
%call this function like this:
%srcs=gensrcs([1 2.5 1.5],2,[-pi/2:pi/8:pi/2]);
%rirs=genrirs(16000,.9*ones(1,6),'T20',1.0,srcs,[[1 2.5-.04 1.5];[1 2.5+.04 1.5]],[7 6 2.5],'MaxDelay',.4) ;


VarList = {'SilentFlag'         0;       % set to 1 to disable on-screen messages
           'c'                  343;	 % sound propagation speed
           'Delta_dB'           50;      % attenuation limit
           'MaxDelay'           []};     % predefined RIR length, overrides value of 'Delta_dB'
eval(SetUserVars(VarList,varargin));

nrcv=size(X_rcv,1);

nsrc=size(X_src,1);

tic;
for isrc=1:nsrc
    for ircv=1:nrcv
        rirs(:,ircv,isrc)=ISM_RoomResp(Fs,beta,rt_type,rt_val,...
            X_src(isrc,:),X_rcv(ircv,:),room,varargin{:});
        fprintf('ircv=%4d  isrc=%4d  et=%6.2f\n',isrc,ircv,toc);
    end
end


        
