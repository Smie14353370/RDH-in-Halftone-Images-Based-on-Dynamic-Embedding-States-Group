clear
clc
quality = struct('p',[],'ws',[],'q',[],'S1',[],'S2',[],'S3',[],'S4',[],'S5',[],'pure',[],'msg_all',[],'size_deco_overhead',[],'change_pattern',[],'flip',[],'rat_pure_flip',[],'rat_mark_all',[]);
m=5;% m��group
n=5;% ÿ��group��n��״̬
Ls=3;% �state sequence�ĳ���
pure=2000;
tic;
%% ��ȡͼƬ��Ϣ
hfdir = 'halftoning\DODM\';
img_str = ['1_DODM.bmp'];
img = imread([hfdir img_str]);
img=double(img);
b=find(img==255);
img(b)=1;  %��255תΪ1�������
[h,w]=size(img);

%% �������ģ��-- mode.mat��ģ������mode_new.mat����������������
load('mode.mat');
disp('calculating the number of all 65536 patterns...')
[mode_new,mode]=cal_mode(img,mode,h,w);
str=['mode_',img_str,'.mat'];
save(['mode\' str],'mode_new');

%% �����������õ�DESG,���õ�compressed overhead information����
[c_sum,cal,overhead,DESG,mark,dict]=capacity1(img_str,img,mode_new,h,w,Ls);

%% ��ϢǶ��
msg=[overhead rand(1,pure)>0.5];
m_len=length(msg);
if m_len>c_sum
    disp(['Embedding capacity is not enough, the maximal payload is ',num2str(c_sum)]);
else
    disp(['The maximal payload is ',num2str(c_sum)]);
    [img_emb,change_pattern,msg_now,quantity]=emb_fix(img,msg,h,w,cal,DESG,m_len);
    
    %% ��ȡ�ͻָ�����
    [img_ext,msg_ext,DESG_ext]=ext_fix(img_emb,n,m,Ls,m_len);
    if (msg_ext==msg)
        disp('extracting successfully')
        [img_rev]=re_mark(img_ext,msg_ext,dict);
        if (img_rev==img)
            disp('recovering successfully')
        end
    end
    %% ͼ������ָ��
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
    %% Ƕ�����Ƚ�
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