function d= eyeDistance(face)

    [rows, columns, numberOfColorChannels] = size(face);
    topHalf = imcrop(face, [1, 1, columns, floor(rows/2)]);

    EyeDetect = vision.CascadeObjectDetector('EyePairBig');
    BB1=step(EyeDetect,topHalf);
    a=imcrop(topHalf,[60,100,76,45]);
    a1 = imcrop(a, [1, 10, floor(columns/2)-55, rows]);
    a1=imadjust(a1);
    a1=histeq(a1);
    [r,c]=size(a1);
    for i=1:r
        for j=1:c
            if a1(i,j)<70
                a1(i,j)=1;
            else a1(i,j)=255;
            end
        end
    end
    [r,c]=size(a1);
    I=imcrop(a1, [floor(c/4),0, ceil(c/2), r]);
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
        %disp(count);
    m=[]; j=1;l
    for i=1:b
        m(j)=count(3,i);
        j=j+1;
    end;
    d=(max(m));
end