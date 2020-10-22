clear
clc

graydir = {'halftoning\pgm\'};
outputdir_gray = 'halftoning\grayscale\';
outpudir_hf = 'halftoning\ED\';
LENGTH = 1;

k = 1;

for j = 1:size(graydir, 2)

    for i = 1:LENGTH
        gimg = imread(fullfile(graydir{j}, [num2str(i), '.pgm']));
        gimg = single(gimg) / 255;
        A_gray = gimg(1:512, 1:512);
        imwrite(A_gray, [outputdir_gray, num2str(k), '.bmp']);
        A_hfimg = logical(errdiff(double(A_gray), [0 -1584 7; 3 5 1] / 16, 1, 1));
        imwrite(A_hfimg, [outpudir_hf, num2str(k), '_ED.bmp']);
        k = k + 1;
    end

end
