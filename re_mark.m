function [img_rev]=re_mark(img_ext,msg_ext,dict)
img_rev=img_ext;
[h,w]=size(img_ext);
mark_now=1;
len_mark=0;
%% 获取mark长度
for i = 1:log2(h*w)
    len_mark=len_mark+msg_ext(18-i+1)*2^(i-1);
end
comp_mark=msg_ext(log2(h*w)+1:log2(h*w)+len_mark);
[ re_mark ] = Huffman_ex( dict,comp_mark);%解压缩
%% 恢复
for i=h-2:2:h
    for j=1:2:w
        if mark_now<=length(re_mark)
            if re_mark(mark_now)==1
                img_rev(i,j)=1;
            else
                img_rev(i,j)=0;
            end
            mark_now=mark_now+1;
        end
    end
end

