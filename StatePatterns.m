function [cal,len_0,len_1]=StatePatterns(img_str,mode_new)
cal= struct('list1',[],'pattern1',[],'list2',[],'pattern2',[],'cap',[],'dist',[],'x',[],'y',[]);
cal_now=0;
f=1/11.566*[0.1628 0.3215 0.4035 0.3215 0.1628;
    0.3215 0.6352 0.7970 0.6352 0.3215;
    0.4035 0.7970 1 0.7970 0.4035;
    0.3215 0.6352 0.7970 0.6352 0.3215;
    0.1628 0.3215 0.4035 0.3215 0.1628;];
B=[];
len_0=length(mode_new([mode_new.num]==0));%图中NAT=0的pattern种类数
len_1=length(mode_new([mode_new.num]==1));%图中NAT=1的pattern种类数
mode0=mode_new([mode_new.num]==0); %NAT=0的pattern设计为转移状态
for i_i=1:20
    %设置5个状态组
    if i_i<=4 &&i_i>=1
        i=1;
    elseif i_i<=8 &&i_i>4
        i=2;
    elseif i_i<=12 &&i_i>8
        i=3;
    elseif i_i<=16 &&i_i>12
        i=4;
    elseif i_i<=20 &&i_i>16
        i=5;
    end
    
    dis=10000;
    j_j=0;
    for j=1:len_0
        if ismember(mode0(j).list,B)==0  %B用于防止重复设置
            hf=conv2(double(mode_new(i).pattern),f);
            lf=conv2(double(mode0(j).pattern),f);
            A=(hf(:,:)-lf(:,:)).^2;
            if(dis>sum(A(:)))
                j_j=j;
                dis=sum(A(:));
            end
        end
    end
    cal_now=cal_now+1;
    cal(cal_now).dist=dis;
    cal(cal_now).list1=mode_new(i).list; %list1为NAT最大的状态
    cal(cal_now).pattern1=mode_new(i).pattern;
    cal(cal_now).list2=mode0(j_j).list; %list2为NAT=0的状态
    B=[B mode0(j_j).list];
    cal(cal_now).pattern2=mode0(j_j).pattern;
    cal(cal_now).cap=mode_new(i).num+mode0(j_j).num;
    cal(cal_now).x=mode0(j_j).x;
    cal(cal_now).y=mode0(j_j).y;
    
    str=['cal_',img_str,'.mat'];
    save(['cal\' str],'cal');
end
