# 说明
该软件基于Bruce T.Draine以及Piotr J.Flatau博士的ddscat 7.3.0，基本上只是代码的拷贝，仅仅在电场的数据导出方面做了一些修改。因此所有的权利都归他们。

#### windows编译说明

使用git-bash和mingw进行编译，如果mingw中没有带openmp，那么就`Makefile`文件中如下两项设置成空，如果包含，则设置成如下，参考UserGuide即可。

- mingw中未包含openmp（设置包含时的选项，编译会出错）
```
DOMP = 
OPENMP = 
```
- mingw中包含openmp
```
DOMP = -Dopenmp
OPENMP = -fopenmp
```

设置完成之后，使用`mingw32-make all`即可编译出ddscat, ddpostprocess, vtrconvert...等等软件。


#### 使用getpar生成ddpostprocess.par
- `getpar i` 生成如何计算的电场的尺寸以及如何使用的参数
- `getpar x/y/z` 使用默认offset=0和slice=200生成默认的不同平面的ddpostprocess.par
- `getpar x/y/z offset[real]` 使用自定义offset和默认slice=200生成默认的不同平面的ddpostprocess.par
- `getpar x/y/z offset[real] slice[int]` 使用自定义offset和slice生成默认的不同平面的ddpostprocess.par


#### 新的ddpostprocess(*.exe)对于ddpostprocess.par的编写

```
'w000r000k000.E1'            = name of file with E stored
'VTRoutput'                  = prefix for name of VTR output files
0   = IVTR (set to 1 to create VTR output)
1   = ILINE (set to 1 to evaluate E along a line)
-0.051 -0.051 0.0 0.056 0.056 0.0 200 200 1 = XMIN(-0.06749),YMIN(-0.06749),ZMIN(-0.06749),XMAX(0.06749),YMAX(0.06749),ZMAX(0.06749),NAA,NAB,NAC
```

#### ddpostprocess导出的数据可以使用如下的代码进行处理

```matlab
close all
clear all
d=0.5 % dipole spacing
n=300 % depends on your ddpostprocess.par

%% Get data
DELIMITER = ' ';
HEADERLINES = 17; % 24 is wrong and 23 is correct. But if it does not work for 23 just use 24. You can check whether the is no space between the numbers in the ddfield.E file.
field=importdata('ddpostprocess.out',DELIMITER, HEADERLINES);
data=field.data;
x=data(:,1);
y=data(:,2);
e=sqrt((abs(complex(data(:,4),data(:,5)))).^2+(abs(complex(data(:,6),data(:,7)))).^2+(abs(complex(data(:,8),data(:,9)))).^2);
xr=reshape(x,n,n);
xy=reshape(y,n,n);
xe=reshape(e,n,n);
pcolor(xr*d*1000,xy*d*1000,xe)
colorbar % 显示colorbar
colormap(jet) % 设置colormap的范围
set(gca, 'CLim', [0, 20]); %设置colorbar的值范围
shading interp
xlabel('x')
ylabel('y')
axis square
print(gcf, '-dpng','-r300', 'efield.png');
```