function [img_ext,msg_ext,DESG_ext]=ext_fix(img_emb,n,m,Ls,m_len,rate,dict)
    img_ext=img_emb;
    msg_ext=[];
%% 提取DESG
DESG_ext=[];
len_DESG=16*n*m+n*Ls;
DESG_now=1;
[h,w]=size(img_emb);
for i=h-2:2:h
    for j=1:2:w
        if DESG_now<=len_DESG
            DESG_ext(DESG_now) = img_emb(i,j);
            DESG_now=DESG_now+1;
        end
    end
end

%% 重构DESG
reDESG=struct('pattern1',[],'pattern2',[]);
Sq=struct('l',[]);
k_k=1;
for k=5:-1:1
    strBin=[num2str(DESG_ext(3*k_k-2)) num2str(DESG_ext(3*k_k-1)) num2str(DESG_ext(3*k_k))];
    dec=bin2dec(strBin);
    Sq(k).l=fliplr(dec2bin(dec)-'0');
    k_k=k_k+1;
end
patt1=DESG_ext(Ls*n+1:(Ls*n)+m*16);
k_k=1;
for k=1:16:length(patt1)
    reDESG(k_k).pattern1=reshape(fliplr(patt1(k:k+15)),4,4);
    k_k=k_k+4;
end
patt2=DESG_ext((Ls*n)+m*16+1:length(DESG_ext));
k_k=1;
for k=1:16:length(patt2)
    reDESG(k_k).pattern2=reshape(fliplr(patt2(k:k+15)),4,4);
    k_k=k_k+1;
end
%% 提取msg和恢复上部
msg_now=0;
for i=1:4:h-1
    for j=1:4:w
        if(length(msg_ext))>m_len %|| (msg_now+1)>m_len || (msg_now+2)>m_len || (msg_now+3)>m_len
            break
        end
        if img_emb(i:i+3,j:j+3)==reDESG(1).pattern1  & (length([msg_ext Sq(5).l]))<=m_len
            msg_ext=[msg_ext Sq(5).l];
        elseif img_emb(i:i+3,j:j+3)==reDESG(5).pattern1 & (length([msg_ext Sq(5).l]))<=m_len
            msg_ext=[msg_ext Sq(5).l];
            elseif img_emb(i:i+3,j:j+3)==reDESG(9).pattern1 & (length([msg_ext Sq(5).l]))<=m_len
            msg_ext=[msg_ext Sq(5).l];
            elseif img_emb(i:i+3,j:j+3)==reDESG(13).pattern1 & (length([msg_ext Sq(5).l]))<=m_len
            msg_ext=[msg_ext Sq(5).l];
            elseif img_emb(i:i+3,j:j+3)==reDESG(17).pattern1 & (length([msg_ext Sq(5).l]))<=m_len
            msg_ext=[msg_ext Sq(5).l];
            
         elseif img_emb(i:i+3,j:j+3)==reDESG(1).pattern2 & (length([msg_ext Sq(2).l]))<=m_len
            msg_ext=[msg_ext Sq(2).l];
            img_ext(i:i+3,j:j+3)=reDESG(1).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(5).pattern2  & (length([msg_ext Sq(2).l]))<=m_len
            msg_ext=[msg_ext Sq(2).l];
            img_ext(i:i+3,j:j+3)=reDESG(5).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(9).pattern2  &(length([msg_ext Sq(2).l]))<=m_len
            msg_ext=[msg_ext Sq(2).l];
            img_ext(i:i+3,j:j+3)=reDESG(9).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(13).pattern2  &(length([msg_ext Sq(2).l]))<=m_len
            msg_ext=[msg_ext Sq(2).l];   
            img_ext(i:i+3,j:j+3)=reDESG(13).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(17).pattern2  &(length([msg_ext Sq(2).l]))<=m_len
            msg_ext=[msg_ext Sq(2).l];   
            img_ext(i:i+3,j:j+3)=reDESG(17).pattern1 ;
            
         elseif img_emb(i:i+3,j:j+3)==reDESG(2).pattern2  &(length([msg_ext Sq(1).l]))<=m_len
            msg_ext=[msg_ext Sq(1).l];
            img_ext(i:i+3,j:j+3)=reDESG(1).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(6).pattern2 &(length([msg_ext Sq(1).l]))<=m_len
            msg_ext=[msg_ext Sq(1).l];
            img_ext(i:i+3,j:j+3)=reDESG(5).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(10).pattern2 &(length([msg_ext Sq(1).l]))<=m_len
            msg_ext=[msg_ext Sq(1).l];
            img_ext(i:i+3,j:j+3)=reDESG(9).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(14).pattern2 &(length([msg_ext Sq(1).l]))<=m_len
            msg_ext=[msg_ext Sq(1).l];   
            img_ext(i:i+3,j:j+3)=reDESG(13).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(18).pattern2 &(length([msg_ext Sq(1).l]))<=m_len
            msg_ext=[msg_ext Sq(1).l];   
            img_ext(i:i+3,j:j+3)=reDESG(17).pattern1 ;
            
         elseif img_emb(i:i+3,j:j+3)==reDESG(3).pattern2 &(length([msg_ext Sq(3).l]))<=m_len
            msg_ext=[msg_ext Sq(3).l];
            img_ext(i:i+3,j:j+3)=reDESG(1).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(7).pattern2 &(length([msg_ext Sq(3).l]))<=m_len
            msg_ext=[msg_ext Sq(3).l];
            img_ext(i:i+3,j:j+3)=reDESG(5).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(11).pattern2 &(length([msg_ext Sq(3).l]))<=m_len
            msg_ext=[msg_ext Sq(3).l];
            img_ext(i:i+3,j:j+3)=reDESG(9).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(15).pattern2 &(length([msg_ext Sq(3).l]))<=m_len
            msg_ext=[msg_ext Sq(3).l];   
            img_ext(i:i+3,j:j+3)=reDESG(13).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(19).pattern2 &(length([msg_ext Sq(3).l]))<=m_len
            msg_ext=[msg_ext Sq(3).l];   
            img_ext(i:i+3,j:j+3)=reDESG(17).pattern1 ;
            
         elseif img_emb(i:i+3,j:j+3)==reDESG(4).pattern2 &(length([msg_ext Sq(4).l]))<=m_len
            msg_ext=[msg_ext Sq(4).l];
            img_ext(i:i+3,j:j+3)=reDESG(1).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(8).pattern2 &(length([msg_ext Sq(4).l]))<=m_len
            msg_ext=[msg_ext Sq(4).l];
            img_ext(i:i+3,j:j+3)=reDESG(5).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(12).pattern2 &(length([msg_ext Sq(4).l]))<=m_len
            msg_ext=[msg_ext Sq(4).l];
            img_ext(i:i+3,j:j+3)=reDESG(9).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(16).pattern2 &(length([msg_ext Sq(4).l]))<=m_len
            msg_ext=[msg_ext Sq(4).l];   
            img_ext(i:i+3,j:j+3)=reDESG(13).pattern1 ;
            elseif img_emb(i:i+3,j:j+3)==reDESG(20).pattern2 &(length([msg_ext Sq(4).l]))<=m_len
            msg_ext=[msg_ext Sq(4).l];   
            img_ext(i:i+3,j:j+3)=reDESG(17).pattern1 ;
        end
    end
end


end
