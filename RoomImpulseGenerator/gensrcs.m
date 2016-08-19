function srcs=gensrcs(X_rcv,dists,angles)

    if length(dists)==1
        dists=repmat(dists,1,length(angles));
    end

    srcs=zeros(length(angles),3);
    for ii=1:length(angles)
        srcs(ii,:)=X_rcv;
        srcs(ii,1)=srcs(ii,1)+dists(ii)*cos(angles(ii));
        srcs(ii,2)=srcs(ii,2)+dists(ii)*sin(angles(ii));
    end

end