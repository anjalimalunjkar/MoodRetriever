face=faceDetect();
dEye=eyeDistance(face);
[dh,dv,A]=mouthDistance(face);
dEyebrow=eyebrowDistance(face);
[f,n]=wrinkles(face);
x=[];
x(1,1)=dEye;
x(2,1)=dEyebrow
x(3,1)=dh
x(4,1)=dv
x(5,1)=A
x(6,1)=f
x(7,1)=n
load ('E:\Project\Code\Matlab\trained_net_3lm.mat');
y=net(x)
dlmwrite('C:\xampp\htdocs\Test\test.txt', y);
