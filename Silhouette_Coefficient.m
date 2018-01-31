

%% silhouette coefficient
% topic_all is to be clustered
 initcenters =20;% number of clusters
method=2;
[ centers, mincenter, mindist, q2, quality ] = kmeans_fast (topic_all, initcenters, method );
lk=0;
for i = 1:size(topic_all,1)
    [r,l]=find(mincenter(i)==mincenter(:));
    iDist = pdist2(topic_all(i, :),topic_all(r,:));
    sun0=sum(iDist)/size(r,1);
    sum0=[];
    for j=1:initcenters
        if mincenter(i)==j
            continue;
        else
        [r,l]=find(j==mincenter(:));
         iDist = pdist2(topic_all(i, :),topic_all(r,:));
         sun1=sum(iDist)/size(r,1);
         sum0=[sum0 sun1];
        end    
    end
    [score,lable]=min(sum0);
    lk0=(score-sun0)/max(score,sun0);%silhouette coefficient
    lk=lk+lk0;
end
avelk=lk/size(topic_all,1);
fprintf ( 1, '  %4d  %g\n', initcenters, avelk);




