function [mode_new,mode] = cal_mode(img,mode,h,w)
for i=1:2^16
    mode(i).list=i-1;
    mode(i).num=0;
end
for i=1:4:h
    for j=1:4:w
        s=reshape(img(i:i+3,j:j+3),[1 16]);
        c=0;
        for k=1:16
            c=c+s(k)*2^(k-1);
        end
        mode(c+1).num=mode(c+1).num+1;  %pattern转化为10进制后，统计pattern数量
        mode(c+1).x=i;
        mode(c+1).y=j;
    end
end
[a,idx] = sort([mode.num],'descend');
mode_new1=mode(idx);
mode_new = mode_new1;