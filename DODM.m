graydir = {'halftoning\pgm\'};
outputdir_gray = 'halftoning\grayscale\';
outpudir_hf = 'halftoning\DODM\';
LENGTH = 1;

k = 0;
T = [2   130 34  162 10  138 42  170;
    194 66  226 98  202 74  234 106;
    50  178 18  146 58  186 26  154;
    242 114 210 82  250 122 218 90;
    14  142 46  174 6   134 38  166;
    206 78  238 110 198 70  230 102;
    62  190 30  158 54  182 22  150;
    254 126 222 94  246 118 214 86];
D = [0 32  8 40  2 34 10 42;
    48 16 56 24 50 18 58 26;
    12 44  4 36 14 46  6 38;
    60 28 52 20 62 30 54 22;
    3 35 11 43  1 33  9 41;
    51 19 59 27 49 17 57 25;
    15 47  7 39 13 45  5 37;
    63 31 55 23 61 29 53 21];
M = 8;
N = 8;

for j = 1:size(graydir, 2)
    for i = 1:LENGTH
        k = k + 1
        gimg = imread(fullfile(graydir{j}, [num2str(i), '.pgm']));
        A_gray = gimg(1:512, 1:512);
        imwrite(A_gray, [outputdir_gray, num2str(k), '.bmp']);
        [h,w]=size(A_gray);
        A_hfimg=zeros(h,w);
        tx=1;
        ty=1;
        for x=1:h
            for y=1:w
                                tx=uint8(mod(x,M))+1;
                                ty=uint8(mod(y,N))+1;

                if A_gray(x,y)>=T(tx,ty)
                    A_hfimg(x,y)=1;
                else
                    A_hfimg(x,y)=0;
                end
            end
        end
        
        imwrite(A_hfimg, [outpudir_hf, num2str(k), '_DODM.bmp']);
        
    end
end
