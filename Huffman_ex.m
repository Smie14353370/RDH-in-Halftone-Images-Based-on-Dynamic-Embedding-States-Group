function [ deco ] = Huffman_ex( dict,enco)
%% ½âÂë
deco = huffmandeco(enco,dict); %½âÂë
ans_now=1;
de_ans=zeros(1,(length(deco)-1)*8);
ans_bin=zeros((length(deco)-1),8);
for i=1:length(deco)-1
    k=8;
    b=deco(i);
    while (b>0)
        ans_bin(i,k)=mod(b,2);
        b=fix(b/2);
        k=k-1;
    end
end
if deco(length(deco))==0
    ans_final=(reshape(ans_bin',1,((length(deco)-1)*8)));
else
    ans_bin=(reshape(ans_bin',1,((length(deco)-1)*8)));
    ans_final=ans_bin(1:(length(ans_bin)-deco(length(deco))));
end
deco=ans_final;
