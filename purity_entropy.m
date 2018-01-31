

%% entropy
% topic_all is to be clustered
initcenters =20;% number of clusters
method=2;
[ centers, mincenter, mindist, q2, quality ] = kmeans_fast (topic_all, initcenters, method );
m_i=[];
m_i_j=[];p_i_j=[];
e_i=[];p_i=[];
for i=1:initcenters
    [r,l]=find(mincenter(:)==i);
    m_i=[m_i size(r,1)];% number in cluster i
    m_i_j0=[];p_i_j0=[];
    for j=1:initcenters%number of groundtruth label cluster
        iDist = pdist2(groundtruth(i, :),topic_all(r,:));
        jDist = pdist2(groundtruth(j, :),topic_all(r,:));
        [loc,label]=find((iDist-jDist)>=0);% element in i belong to class j
        p_i_j0=[p_i_j0 size(loc,2)/size(r,1)];
        m_i_j0=[m_i_j0 size(loc,2)];
    end
    p_i_j=[p_i_j;p_i_j0];
    m_i_j=[m_i_j;m_i_j0];
    [c,l]=find(p_i_j0~=0);
    e_i0=0-sum(p_i_j0(l).*log2(p_i_j0(l)));
    e_i=[e_i e_i0];
    
    p_i0=max(p_i_j0);
    p_i=[p_i p_i0];
end 
e=sum(e_i.*m_i)/size(topic_all,1);
purity=sum(p_i.*m_i)/size(topic_all,1);

