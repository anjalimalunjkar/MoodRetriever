function d= eyebrowDistance(face)

    [rows, columns, numberOfColorChannels] = size(face);
    topHalf = imcrop(face, [1, 1, columns, floor(rows/2)]);
    [r,c]=size(topHalf);
    eyebrow=imcrop(topHalf,[50,50,c-100,r-25]);
    [r,c]=size(eyebrow);
    for i=1:r
        for j=1:c
            if eyebrow(i,j)<60
                eyebrow(i,j)=1;
            else eyebrow(i,j)=255;
            end
       end
    end
    I=imcrop(eyebrow, [floor(c/2)+10,0,floor(c/2)-40, r]);
    [a,b]=size(I);
    [row,col] = find(I==1);
    indices = [row, col];
    [ro,co]=size(indices);
    y=0; x=0; h=0; l=0;
    count=zeros(3,b);
    for i=1:ro
        x=indices(i,2);
        if x==y
            h=indices(i,1);
        elseif x>y
                if ~(x ==0 || y ==0 || h ==0 || l ==0)
                    count(1,y)=l;
                    count(2,y)=h;
                    count(3,y)=h-l;
                end
                h=indices(i,1);
                l=indices(i,1);
                y=x;
            end
    end
    m=[]; j=1;l
    for i=1:b
        m(j)=count(3,i);
        j=j+1;
    end;
    d=(max(m));
end