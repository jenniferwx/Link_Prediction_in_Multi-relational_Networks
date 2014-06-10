function [Dis Flow] = PathDistance(A,u,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the Path Distance and PropFlow score for unweighted networks is
% by BFS algorithm.
% INPUT:
% A: the unweighted/weighted adjacent matrix
% u: the starting node
% other parameters can be considered:
% l: the maximum flow/path steps considered
% target: the target node
% written by Xi Wang
% 02/07/2013
% Reference: Xi Wang and Gita Sukthankar, Link Prediction in Multi-relational 
%            Collaboration Networks, The 2013 IEEE/ACM International Conference on 
%            Advances in Social Networks Analysis and Mining(ASONAM), 2013. pp.1445-1447
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is mordified based on the BFS code written by David F. Gleich
% Stanford University, 2008-2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optionNames = {'target','wt','l'};
nArgs = length(varargin);
if round(nArgs/2)~=nArgs/2
    error('EXAMPLE needs propertyName/propertyValue pairs')
end
for pair = reshape(varargin,2,[]) %# pair is {propName;propValue}
    inpName = lower(pair{1}); %# make case insensitive
    if any(strmatch(inpName,'target'))
        target = pair{2};
    else
        target= 1:size(A,1);
    end
    if any(strmatch(inpName,'wt'))
        wt = pair{2};
    else
        wt = A;
    end
    if any(strmatch(inpName,'l'))
        l = pair{2};
    else
        l= 3;
    end
end

if isstruct(A), rp=A.rp; ci=A.ci;
else [rp ci]=sparse_to_csr(A);
end

n=length(rp)-1; % total number of nodes in the network
d=-1*ones(n,1); % BFS distance from node u
dt=-1*ones(n,1); pred=zeros(1,n);
sq=zeros(n,1); sqt=0; sqh=0; % search queue and search queue tail/head

% start bfs at u
sqt=sqt+1; sq(sqt)=u;
t=0;
d(u)=0; dt(u)=t; t=t+1; pred(u)=u;
flow = zeros(n,1); % the information flow start from node u
flow(u) = 1; %sum(A(u,:)); % the score for source node is 1 or degree(u);

Dis = (-1)*zeros(length(target),1);
Flow = (-1)*zeros(length(target),1);
level = zeros(l+2,1);
% store the number of nodes in each level (distance l),start from  level 0,
level(1,1) = 1;
L = 1; % the level index
while (sqt-sqh>0)
    sqh=sqh+1; v=sq(sqh); % pop v off the head of the queue
    level(L,:) = level(L,:)-1; % decrease the number of nodes in current level
    L = find(level>0,1);
    if(isempty(L)) % the first level
        L = 1;
    end
    if(L>l+1)
        break; % if exceed the maximum number of level
    end
    for ri=rp(v):rp(v+1)-1
        w=ci(ri);
        sourceInput = flow(v); % the score for source input; initiated as 1;
        if(sourceInput==0)
            sourceInput = 1;
        end
        totaloutput = sum(wt(v,:)); % sum up all the weight
        %  if d(w)<0 % not visited w
        if(d(w)<0) % not visited w
            sqt=sqt+1; sq(sqt)=w;
            d(w)=d(v)+ (1/wt(v,w)); dt(w)=t; t=t+1; pred(w)=v;
            level(L+1,1) = level(L+1,1)+1; % count the number of nodes in level L (exclude the nodes appears before)
        end
        flowN = full(sourceInput*(wt(v,w)/totaloutput));
        flow(w) = flow(w) + flowN;
        if (any(target==w)) % w==target
            id = find(target==w);
            Dis(id) = d(w);
            Flow(id) = flow(w);
        end
    end
end
%flow = flow/flow(1);
end
