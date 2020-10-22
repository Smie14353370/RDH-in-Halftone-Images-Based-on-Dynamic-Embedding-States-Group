function [ rate,dict,outputcode,outputcodesize ] = Huffman_em( x )
%p为概率分布，此函数功能是进行哈夫曼编码
%   此处显示详细说明
% h为各个元素的麻子
% e为输出的平均码长
size=length(x);
P = zeros(1,256);
x_now=1;
group=1;
seq=zeros(1,8);
sum=0;
if mod(size,8)~=0
    x(size+1:size+1+(8-mod(size,8)))=0;
    x((fix(size/8)+1)*8+1)=(8-mod(size,8));
else
    x(size+1)=0;
end
%  x
 size=length(x);
 I=zeros(1,fix(size/8)+1);
for i=1:8:fix(size/8)*8
    
    for j=1:1:8
        seq(j)=x(x_now);
        x_now=x_now+1;
    end
%     seq
    for k=0:length(seq)-1
        sum=sum+seq(k+1)*(2^(length(seq)-1-k));
    end
    I(group)=sum;
    sum=0;
    group=group+1;
end
sum=0;
% mod(size,8)
for j=1:1:mod(size,8)
    seq(j)=x(x_now);
    x_now=x_now+1;
 end
% seq(1:mod(size,8))
for k=0:mod(size,8)-1
        sum=sum+seq(k+1)*(2^(mod(size,8)-1-k));
end
I(group)=sum;
for i = 0:255
     P(i+1) = length(find(I == i))/(group);
end
P;

k = 0:255;
 dict = huffmandict(k,P); %生成字典
 outputcode = huffmanenco(I,dict); %编码
 outputcodesize=length(outputcode);
 rate=length(outputcode)/length(x);
 