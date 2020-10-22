function [c_sum,cal,overhead,DESG,mark,dict]=capacity1(img_str,img,mode_new,h,w,Ls)
%% State patterns design
disp('designing state patterns...')
[cal]=StatePatterns(img_str,mode_new);
c_sum=(cal(1).cap)+(cal(5).cap)+(cal(9).cap)+(cal(13).cap)+(cal(17).cap); %Ƕ������=����group��NAT��󣬼�St_1������

%% DESG
disp('recording DESG...')
DESG=[];
StatePat_mode=[0 1 2 3 5]; %% 5��Ƕ������[0]��[1]��[1 0]��[1 1]��[1 0 1]���ֱ���
%��ʽ(17)
for k=1:5
    DESG=[DESG fliplr(dec2bin(StatePat_mode(k),Ls)-'0') ]; %���ȼ�¼nLs
end
DESG=[DESG fliplr(dec2bin(cal(1).list1,16)-'0') fliplr(dec2bin(cal(5).list1,16)-'0') fliplr(dec2bin(cal(9).list1,16)-'0') fliplr(dec2bin(cal(13).list1,16)-'0') fliplr(dec2bin(cal(17).list1,16)-'0')];%16mn
for k=1:20
    DESG=[DESG fliplr(dec2bin(cal(k).list2,16)-'0')];
end

%% ��¼Ƕ��DESGʱ�����ǵĲ���Ϊrecording overhead information
mark=[]; %DESGǶ��ײ����ǵĲ���
DESG_now=1;
for i=h-2:2:h
    for j=1:2:w
        if DESG_now<=length(DESG)
            mark(DESG_now)=img(i,j);
            DESG_now=DESG_now+1;
        end
    end
end

%% ѹ��I_over
[ rate,dict,IO_deco_overhead,IO_size_deco_overhead] = Huffman_em( mark );

permark=log2(h*w); %��¼pixel��������λ�������ڼ�¼L_I_over�ĳ���
overhead=[fliplr(dec2bin(IO_size_deco_overhead,permark)-'0') IO_deco_overhead];
end
