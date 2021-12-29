imgPath='picture/';
imgDir=dir(fullfile(imgPath,'*.jpg'));%遍历所有jpg格式文件
PictureSize=length(imgDir);
for i=1:PictureSize-1
    img{i}=double(imread([imgPath imgDir(i).name]));
end

Car = img{11}(20:60,60:130,:);

Car_R=Car(:,:,1);
Car_G=Car(:,:,2);
Car_B=Car(:,:,3);

figure;
imshow(uint8(Car));

[im_len im_wid]=size(img{1}(:,:,1));
[C_len C_wid]=size(Car_R); 

for k=1:PictureSize-1
    for i=0:im_len-C_len
        for j=0:im_wid-C_wid
            sum=0;
            for m=1:C_len
                for n=1:C_wid
                    sum=sum+abs(img{k}(i+m,j+n,1)-Car_R(m,n))+abs(img{k}(i+m,j+n,2)-Car_G(m,n))+abs(img{k}(i+m,j+n,3)-Car_B(m,n));
                end
            end
            if i==0 && j==0
                tabel_i=i;
                tabel_j=j;
                tabel_sum=sum;
            elseif sum<tabel_sum
                tabel_i=i;
                tabel_j=j;
                tabel_sum=sum; 
            end
        end
    end
    for m=-5:C_len+30
        for n=-20:C_wid+20
            img{k}(tabel_i+m,tabel_j+n,1)=img{PictureSize}(tabel_i+m,tabel_j+n,1);
            img{k}(tabel_i+m,tabel_j+n,2)=img{PictureSize}(tabel_i+m,tabel_j+n,2);
            img{k}(tabel_i+m,tabel_j+n,3)=img{PictureSize}(tabel_i+m,tabel_j+n,3);
        end
    end
end
for k=1:PictureSize-1
    imwrite(uint8(img{k}),sprintf('result/%d.jpg', k));
end