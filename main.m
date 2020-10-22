clear
clc
quality = struct('p',[],'ws',[],'q',[],'S1',[],'S2',[],'S3',[],'S4',[],'S5',[],'pure',[],'msg_all',[],'size_deco_overhead',[],'change_pattern',[],'flip',[],'rat_pure_flip',[],'rat_mark_all',[]);
m=5;% m个group
n=5;% 每个group有n个状态
Ls=3;% 最长state sequence的长度
pure=2000;
tic;
%% 读取图片信息
hfdir = 'halftoning\DODM\';
img_str = ['1_DODM.bmp'];
img = imread([hfdir img_str]);
img=double(img);
b=find(img==255);
img(b)=1;  %将255转为1方便操作
[h,w]=size(img);

%% 计算最大模块-- mode.mat按模块排序，mode_new.mat按块数量降序排序
load('mode.mat');
disp('calculating the number of all 65536 patterns...')
[mode_new,mode]=cal_mode(img,mode,h,w);
str=['mode_',img_str,'.mat'];
save(['mode\' str],'mode_new');

%% 计算容量，得到DESG,并得到compressed overhead information序列
[c_sum,cal,overhead,DESG,mark,dict]=capacity1(img_str,img,mode_new,h,w,Ls);

%% 信息嵌入
msg=[overhead rand(1,pure)>0.5];
m_len=length(msg);
if m_len>c_sum
    disp(['Embedding capacity is not enough, the maximal payload is ',num2str(c_sum)]);
else
    disp(['The maximal payload is ',num2str(c_sum)]);
    [img_emb,change_pattern,msg_now,quantity]=emb_fix(img,msg,h,w,cal,DESG,m_len);
    
    %% 提取和恢复测试
    [img_ext,msg_ext,DESG_ext]=ext_fix(img_emb,n,m,Ls,m_len);
    if (msg_ext==msg)
        disp('extracting successfully')
        [img_rev]=re_mark(img_ext,msg_ext,dict);
        if (img_rev==img)
            disp('recovering successfully')
        end
    end
    %% 图像质量指标
    quality.p=psnr(img,img_emb);
    quality.ws = wsnr(img,img_emb);
    [q, quality_map] = img_qi(img, img_emb);
    quality.q=q;
    S = calVSco(img, img_emb);
    quality.S1=S(1);
    quality.S2=S(2);
    quality.S3=S(3);
    quality.S4=S(4);
    quality.S5=S(5);
    %% 嵌入量比较
    quality.pure=pure;
    quality.msg_all=length(msg);
    quality.size_deco_overhead=length(overhead);
    quality.change_pattern=change_pattern;
    flip=length(find((img-img_emb)~=0));
    quality.flip=flip;
    quality.rat_pure_flip=pure/flip;
    quality.rat_mark_all=length(overhead)/length(msg);
    save(['result\',img_str,'.mat'],'quality');
end
toc;