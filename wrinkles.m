function [f,n]= wrinkles(face)

    [r,c]=size(face)
    forehead=imcrop(face, [c/4,30,c/2,50])
    options = struct('FrangiScaleRange', [1 3], 'FrangiScaleRatio', 1, 'FrangiBetaOne', 0.5,...
               'FrangiBetaTwo',7.0, 'verbose',true,'BlackWhite',true);
    [outIm,whatScale,Direction] = FrangiFilter2D(double(forehead), options);
    fw=(uint8(outIm/max(outIm(:))*256))
    cn=0;
    [p,q]=size(fw)
    for i=1:p
        for j=1:q
            if fw(i,j)>0
                cn=cn+1;
            end
        end
    end
    if cn<2500
        f=0
    else f=1
    end

    nose=imcrop(face,[c/2-10,100,25,75]);
    options = struct('FrangiScaleRange', [1 3], 'FrangiScaleRatio', 1, 'FrangiBetaOne', 0.5,...
               'FrangiBetaTwo',7.0, 'verbose',true,'BlackWhite',true);
    [outIm,whatScale,Direction] = FrangiFilter2D(double(nose), options);
    nw=(uint8(outIm/max(outIm(:))*256))
    cn=0;
    [p,q]=size(nw)
    for i=1:p
        for j=1:q
            if nw(i,j)>0
                cn=cn+1;
            end
        end
    end
    if cn<200
        n=0
    else n=1
    end
end