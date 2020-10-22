function [img_emb,change_pattern,msg_now,quantity]=emb_fix(img,msg,h,w,cal,DESG,m_len)
img_emb=img;
%% 嵌入msg，包括compressed overhead information和秘密信息
msg_now=0;
change_pattern=0;
quantity=struct('remain',[],'change',[]);
list=struct('l',[]);
list(1).l=[1 0 1];%St5
list(2).l=[1 1];%St4
list(3).l=[1 0];%St3
list(4).l=[1];%St2
list(5).l=[0];%St1

for k=1:20
    quantity(k).remain=0;
    quantity(k).change=0;
end
for i=1:4:h-1
    for j=1:4:w
        if(msg_now)>m_len %|| (msg_now+1)>m_len || (msg_now+2)>m_len || (msg_now+3)>m_len
            break
        end
        if img(i:i+3,j:j+3)==cal(1).pattern1  %在第1个Group嵌入
            if  (msg_now+length(list(1).l))<=m_len & msg(msg_now+1:msg_now+length(list(1).l))==list(1).l  %St1转移到St5
                img_emb(i:i+3,j:j+3)=cal(2).pattern2;
                msg_now=msg_now+length(list(1).l);
                change_pattern=change_pattern+1;
                quantity(1).change=quantity(1).change+1;
            elseif (msg_now+length(list(2).l))<=m_len & msg(msg_now+1:msg_now+length(list(2).l))==list(2).l %St1转移到St4
                img_emb(i:i+3,j:j+3)=cal(1).pattern2;
                msg_now=msg_now+length(list(2).l);
                change_pattern=change_pattern+1;
                quantity(2).change=quantity(2).change+1;
            elseif (msg_now+length(list(3).l))<=m_len & msg(msg_now+1:msg_now+length(list(3).l))==list(3).l %St1转移到St3
                img_emb(i:i+3,j:j+3)=cal(3).pattern2;
                msg_now=msg_now+length(list(3).l);
                change_pattern=change_pattern+1;
                quantity(3).change=quantity(3).change+1;
            elseif (msg_now+length(list(4).l))<=m_len & msg(msg_now+1:msg_now+length(list(4).l))==list(4).l %St1转移到St2
                img_emb(i:i+3,j:j+3)=cal(4).pattern2;
                msg_now=msg_now+length(list(4).l);
                change_pattern=change_pattern+1;
                quantity(4).change=quantity(4).change+1;
            elseif (msg_now+length(list(5).l))<=m_len & msg(msg_now+1:msg_now+length(list(5).l))==list(5).l %St1转移到St1，只有信息为[0]时，pattern不变
                msg_now=msg_now+length(list(5).l);
                quantity(1).remain=quantity(1).remain+1;
            end
        elseif img(i:i+3,j:j+3)==cal(5).pattern1 %在第2个Group嵌入
            if  (msg_now+length(list(1).l))<=m_len & msg(msg_now+1:msg_now+length(list(1).l))==list(1).l %St1转移到St5
                img_emb(i:i+3,j:j+3)=cal(6).pattern2;
                msg_now=msg_now+length(list(1).l);
                change_pattern=change_pattern+1;
                quantity(5).change=quantity(5).change+1;
            elseif (msg_now+length(list(2).l))<=m_len & msg(msg_now+1:msg_now+length(list(2).l))==list(2).l %St1转移到St4
                img_emb(i:i+3,j:j+3)=cal(5).pattern2;
                msg_now=msg_now+length(list(2).l);
                change_pattern=change_pattern+1;
                quantity(6).change=quantity(6).change+1;
            elseif (msg_now+length(list(3).l))<=m_len & msg(msg_now+1:msg_now+length(list(3).l))==list(3).l %St1转移到St3
                img_emb(i:i+3,j:j+3)=cal(7).pattern2;
                msg_now=msg_now+length(list(3).l);
                change_pattern=change_pattern+1;
                quantity(7).change=quantity(7).change+1;
            elseif (msg_now+length(list(4).l))<=m_len & msg(msg_now+1:msg_now+length(list(4).l))==list(4).l %St1转移到St2
                img_emb(i:i+3,j:j+3)=cal(8).pattern2;
                msg_now=msg_now+length(list(4).l);
                change_pattern=change_pattern+1;
                quantity(8).change=quantity(8).change+1;
            elseif (msg_now+length(list(5).l))<=m_len & msg(msg_now+1:msg_now+length(list(5).l))==list(5).l %St1转移到St1，只有信息为[0]时，pattern不变
                msg_now=msg_now+length(list(5).l);
                quantity(5).remain=quantity(5).remain+1;
            end
        elseif img(i:i+3,j:j+3)==cal(9).pattern1 %在第3个Group嵌入
            if  (msg_now+length(list(1).l))<=m_len & msg(msg_now+1:msg_now+length(list(1).l))==list(1).l  %St1转移到St5
                img_emb(i:i+3,j:j+3)=cal(10).pattern2;
                msg_now=msg_now+length(list(1).l);
                change_pattern=change_pattern+1;
                quantity(9).change=quantity(9).change+1;
            elseif (msg_now+length(list(2).l))<=m_len & msg(msg_now+1:msg_now+length(list(2).l))==list(2).l %St1转移到St4
                img_emb(i:i+3,j:j+3)=cal(9).pattern2;
                msg_now=msg_now+length(list(2).l);
                change_pattern=change_pattern+1;
                quantity(10).change=quantity(10).change+1;
            elseif (msg_now+length(list(3).l))<=m_len & msg(msg_now+1:msg_now+length(list(3).l))==list(3).l %St1转移到St3
                img_emb(i:i+3,j:j+3)=cal(11).pattern2;
                msg_now=msg_now+length(list(3).l);
                change_pattern=change_pattern+1;
                quantity(11).change=quantity(11).change+1;
            elseif (msg_now+length(list(4).l))<=m_len & msg(msg_now+1:msg_now+length(list(4).l))==list(4).l %St1转移到St2
                img_emb(i:i+3,j:j+3)=cal(12).pattern2;
                msg_now=msg_now+length(list(4).l);
                change_pattern=change_pattern+1;
                quantity(12).change=quantity(12).change+1;
            elseif (msg_now+length(list(5).l))<=m_len & msg(msg_now+1:msg_now+length(list(5).l))==list(5).l %St1转移到St1，只有信息为[0]时，pattern不变
                msg_now=msg_now+length(list(5).l);
                quantity(9).remain=quantity(9).remain+1;
            end
        elseif img(i:i+3,j:j+3)==cal(13).pattern1 %在第4个Group嵌入
            if  (msg_now+length(list(1).l))<=m_len & msg(msg_now+1:msg_now+length(list(1).l))==list(1).l %St1转移到St5
                img_emb(i:i+3,j:j+3)=cal(14).pattern2;
                msg_now=msg_now+length(list(1).l);
                change_pattern=change_pattern+1;
                quantity(13).change=quantity(13).change+1;
            elseif (msg_now+length(list(2).l))<=m_len & msg(msg_now+1:msg_now+length(list(2).l))==list(2).l %St1转移到St4
                img_emb(i:i+3,j:j+3)=cal(13).pattern2;
                msg_now=msg_now+length(list(2).l);
                change_pattern=change_pattern+1;
                quantity(14).change=quantity(14).change+1;
            elseif (msg_now+length(list(3).l))<=m_len & msg(msg_now+1:msg_now+length(list(3).l))==list(3).l %St1转移到St3
                img_emb(i:i+3,j:j+3)=cal(15).pattern2;
                msg_now=msg_now+length(list(3).l);
                change_pattern=change_pattern+1;
                quantity(15).change=quantity(15).change+1;
            elseif (msg_now+length(list(4).l))<=m_len & msg(msg_now+1:msg_now+length(list(4).l))==list(4).l %St1转移到St2
                img_emb(i:i+3,j:j+3)=cal(16).pattern2;
                msg_now=msg_now+length(list(4).l);
                change_pattern=change_pattern+1;
                quantity(16).change=quantity(16).change+1;
            elseif (msg_now+length(list(5).l))<=m_len & msg(msg_now+1:msg_now+length(list(5).l))==list(5).l %St1转移到St1，只有信息为[0]时，pattern不变
                msg_now=msg_now+length(list(5).l);
                quantity(13).remain=quantity(13).remain+1;
            end
        elseif img(i:i+3,j:j+3)==cal(17).pattern1 %在第5个Group嵌入
            if  (msg_now+length(list(1).l))<=m_len & msg(msg_now+1:msg_now+length(list(1).l))==list(1).l %St1转移到St5
                img_emb(i:i+3,j:j+3)=cal(18).pattern2;
                msg_now=msg_now+length(list(1).l);
                change_pattern=change_pattern+1;
                quantity(17).change=quantity(17).change+1;
            elseif (msg_now+length(list(2).l))<=m_len & msg(msg_now+1:msg_now+length(list(2).l))==list(2).l %St1转移到St4
                img_emb(i:i+3,j:j+3)=cal(17).pattern2;
                msg_now=msg_now+length(list(2).l);
                change_pattern=change_pattern+1;
                quantity(18).change=quantity(18).change+1;
            elseif (msg_now+length(list(3).l))<=m_len & msg(msg_now+1:msg_now+length(list(3).l))==list(3).l %St1转移到St3
                img_emb(i:i+3,j:j+3)=cal(19).pattern2;
                msg_now=msg_now+length(list(3).l);
                change_pattern=change_pattern+1;
                quantity(19).change=quantity(19).change+1;
            elseif (msg_now+length(list(4).l))<=m_len & msg(msg_now+1:msg_now+length(list(4).l))==list(4).l %St1转移到St2
                img_emb(i:i+3,j:j+3)=cal(20).pattern2;
                msg_now=msg_now+length(list(4).l);
                change_pattern=change_pattern+1;
                quantity(20).change=quantity(20).change+1;
            elseif (msg_now+length(list(5).l))<=m_len & msg(msg_now+1:msg_now+length(list(5).l))==list(5).l %St1转移到St1，只有信息为[0]时，pattern不变
                msg_now=msg_now+length(list(5).l);
                quantity(17).remain=quantity(17).remain+1;
            end
        end
    end
end
disp('Finishing embedding the embedding sequence')
%% 底部嵌入DESG
DESG_now=1;
for i=h-2:2:h
    for j=1:2:w
        if DESG_now<=length(DESG)
            if DESG(DESG_now)==1
                img_emb(i,j)=1;
            else
                img_emb(i,j)=0;
            end
            DESG_now=DESG_now+1;
        end
    end
end
disp('Finishing embedding the DESG')
end

