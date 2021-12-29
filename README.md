[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-f059dc9a6f8d3a56e377f745f24479a46679e63a5d9fe6f495e02850cd0d8118.svg)](https://classroom.github.com/online_ide?assignment_repo_id=6446305&assignment_repo_type=AssignmentRepo)

# 题目：基于图像分割技术实现视频对象擦除

### 成员信息：张博轩 PB18061442
### 问题描述：
          在当今社会，有很多艺人都做过一些恶劣的事迹，因此就需要视频对象擦除技术，将很多已经成型的影片中某位艺人擦除而不影响影片的质量。  
### 原理分析：
          首先，我们在视频中，寻找出需要删除的物体，本次实验是以红色卡车为例。将红色卡车的图像保存到变量Car中，然后再逐帧搜索红色卡车的
      位置，搜索到目标后去除。然后再利用其他帧的图片将残缺部分补全。
          本实验搜索红色卡车的方法是将待处理图片上的每个位置，依次与已经提取出来的卡车进行对比，利用范数计算误差（本实验采用一范数），找
      到误差最小的位置，即为搜索到卡车的位置，然后将卡车删除。
### 代码实现：
    本实验是用matlab R2021a实现的，代码的核心是通过以下这个循环，搜索到红色卡车的位置删除，并进行缺口填充。
    
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
### 效果展示：
原动画

![image]( https://github.com/USTC-Computer-Vision-2021/project-cv_mrz/blob/main/原图.gif)

实验处理后的动画

![image]( https://github.com/USTC-Computer-Vision-2021/project-cv_mrz/blob/main/实验结果.gif)

由于时间问题，填充操作做的比较粗糙，所以就可以看到实验结果中，蓝车也被删除了一块，而没有得到较好的填充，后续会优化填充的算法，使实验结果更好。
并且该算法在物体平移上才有较好的效果，如果物体大小改变或者转向，效果就会不理想。
### 运行说明：
      文件说明：
          原图.gif是从网上获取到的待处理的动画
          实验结果.gif是实验处理后的结果
          picture文件夹是将原图.gif转换为若干帧图片后存储的位置
          result文件夹是将图片处理后存储的位置
          ex.m是实验代码，直接运行即可，ex.m和picture、result文件夹必须在同一目录下
