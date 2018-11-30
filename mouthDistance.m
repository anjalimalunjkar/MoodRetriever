function [dh,dv,A]= mouthDistance(face)

    [rows, columns, numberOfColorChannels] = size(face);
    bottom = imcrop(face, [1, ceil(rows/2), columns, floor(rows/2)]);
    [row, column, numberOfColorChannels] = size(bottom);
    top = imcrop(bottom, [1, 1, column, floor(row/2)]);
    bottomHalf = imcrop(bottom, [1, ceil(row/2)-10, column, floor(row/2)]);

    a1=histeq(bottomHalf);
    a1=imadjust(a1);
    [x,y]=size(a1);
    a1=imcrop(a1,[floor(y/4),1,2*ceil(y/4),2*ceil(y/4)]);
    maxValue = sum(a1(:))
    avg=maxValue/(x*y);
    [r,c]=size(a1);
    for i=1:r
        for j=1:c
            if a1(i,j)<(avg) & a1(i,j)>(avg-25)
                a1(i,j)=1;
            else a1(i,j)=255;
            end
       end
    end
    [r,c]=size(a1);
    I=imcrop(a1, [20,0, c-25, r]);
    [a,b]=size(I);
    [row,col] = find(I==1);
    indices = [row, col];
    [ro,co]=size(indices);
    dh=indices(ro,2)-indices(1,2);
    midp=floor(indices(1,2)+dh/2);
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
    m=[]; j=1;
    for i=1:b
        m(j)=count(3,i);
        j=j+1;
    end;
    dv=(max(m));
    d=dv;
    v1=[indices(1,1),indices(1,2)]-[indices(1,1),midp]; 
    v2=[indices(1,1),indices(1,2)]-[indices(1,1)+d,midp];
    a1 = mod(atan2( det([v1;v2;]) , dot(v1,v2) ), 2*pi );
    angleout = abs((a1>pi/2)*pi-a1)*1000
    A=floor(angleout);
end