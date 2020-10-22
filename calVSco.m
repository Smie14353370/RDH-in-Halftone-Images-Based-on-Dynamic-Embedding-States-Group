function S = calVSco(img,wdimg)
%please make sure img and wdimg are in the same format
difference = find(img~=wdimg);
[m,n] = size(img);
N = zeros(5,1);
for i = 1:length(difference)
    neighbor_pix = 0;
    master_pix = wdimg(difference(i));
    [row col] = ind2sub([m,n],difference(i));
    
    
    if(row==1&&col~=1&&col~=n)
        neighbor_pix = neighbor_pix + xor(wdimg(row,col-1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row,col+1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row+1,col),wdimg(row,col));
        
        tmp_wdimg = [
            wdimg(row,col-1) wdimg(row,col) wdimg(row,col+1);
            wdimg(row+1,col-1) wdimg(row+1,col) wdimg(row+1,col+1);];
    elseif(row==m&&col~=1&&col~=n)
        neighbor_pix = neighbor_pix + xor(wdimg(row,col-1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row,col+1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row-1,col),wdimg(row,col));
        
        tmp_wdimg = [wdimg(row-1,col-1) wdimg(row-1,col) wdimg(row-1,col+1);
            wdimg(row,col-1) wdimg(row,col) wdimg(row,col+1);
            ];
    elseif(col ==1&&row~=1&&row~=m)
        neighbor_pix = neighbor_pix + xor(wdimg(row,col+1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row-1,col),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row+1,col),wdimg(row,col));
        
        tmp_wdimg = [ wdimg(row-1,col) wdimg(row-1,col+1);
            wdimg(row,col) wdimg(row,col+1);
            wdimg(row+1,col) wdimg(row+1,col+1);];
        
    elseif(col ==n&&row~=1&&row~=m)
        neighbor_pix = neighbor_pix + xor(wdimg(row,col-1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row-1,col),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row+1,col),wdimg(row,col));
        
        tmp_wdimg = [wdimg(row-1,col-1) wdimg(row-1,col) ;
            wdimg(row,col-1) wdimg(row,col) ;
            wdimg(row+1,col-1) wdimg(row+1,col) ;];
    elseif(row==1&&col==1)
        neighbor_pix = neighbor_pix + xor(wdimg(row,col+1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row+1,col),wdimg(row,col));
        
        tmp_wdimg = [
            wdimg(row,col) wdimg(row,col+1);
            wdimg(row+1,col) wdimg(row+1,col+1);];
    elseif((row==1&&col==n))
        neighbor_pix = neighbor_pix + xor(wdimg(row,col-1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row+1,col),wdimg(row,col));
        
        tmp_wdimg = [
            wdimg(row,col-1) wdimg(row,col) ;
            wdimg(row+1,col-1) wdimg(row+1,col) ;];
    elseif((row==n&&col==1))
        neighbor_pix = neighbor_pix + xor(wdimg(row,col+1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row-1,col),wdimg(row,col));
        
        tmp_wdimg = [ wdimg(row-1,col) wdimg(row-1,col+1);
            wdimg(row,col) wdimg(row,col+1);
            ];
    elseif((row==n&&col==n))
        neighbor_pix = neighbor_pix + xor(wdimg(row,col-1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row-1,col),wdimg(row,col));
        
        
        tmp_wdimg = [wdimg(row-1,col-1) wdimg(row-1,col) ;
            wdimg(row,col-1) wdimg(row,col) ;
            ];
    else
        neighbor_pix = neighbor_pix + xor(wdimg(row,col-1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row,col+1),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row-1,col),wdimg(row,col));
        neighbor_pix = neighbor_pix + xor(wdimg(row+1,col),wdimg(row,col));
        
        tmp_wdimg = [wdimg(row-1,col-1) wdimg(row-1,col) wdimg(row-1,col+1);
            wdimg(row,col-1) wdimg(row,col) wdimg(row,col+1);
            wdimg(row+1,col-1) wdimg(row+1,col) wdimg(row+1,col+1);];
    end
    class = xor(sum(sum(tmp_wdimg))/9>125,master_pix);
    if(class)
        switch(neighbor_pix)
            case 0
                N(1) = N(1)+1;
            case 1
                N(2) = N(2)+1;
            case 2
                N(3) = N(3)+1;
            case 3
                N(4) = N(4)+1;
            case 4
                N(5) = N(5)+1;
        end
    end
    
end
S1 = sum(N(:));
S2 =N(1)+ 2*N(2)+3*N(3)+4*N(4)+5*N(5);
if S1==0
    S3=0;
else
    S3 = S2/S1;
end
S4 = sum(N(3:5));
S5 = S2 - S1;
S = [S1 S2 S3 S4 S5];
end