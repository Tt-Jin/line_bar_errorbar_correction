一、折线图 p0 细节备注：

1、geon_rect()函数添加灰色背景色块，放在第一个即最底下的图层；‘grey90’：灰色grey后面加上0—100的数值表示灰色程度，数字越大灰色越浅；

2、geom_vline()函数加上y轴平行的辅助线，同样，加x轴平行的分割线用geom_hline()函数；

3、涉及到统计处理的绘图时一般用stat_summary()函数并在里面接参数geom=’line’等，而不是用geom_point、geom_line等函数。这里三个stat_summary()函数分别绘制了折线、误差棒和点。



二、折线图 linechart 细节备注：

1、scale_color_manual()函数设置折线颜色，根据treat变量以不同颜色展示；

2、scale_fill_manual()函数设置点的颜色，前面点图用的形状pch=21是空心圆圈，所以设置填充颜色；

3、scale_x_continuous()函数设置坐标轴范围及刻度，breaks控制范围及刻度，expand控制坐标轴过原点

4、theme()函数内修改坐标轴、图例等的细节；

5、显著性标记用annotate()函数添加线段和自定义文本。（这样做的前提是你已经算好自己数据的显著性水平）

6、coord_cartesian(clip=‘off’,ylim=c(0,60),xlim=c(0,40))函数不可缺少，它能使我们在绘图区域外围添加需要的文本，同时这里定义x、y轴的范围，因为之后上面要留空叠加柱状图，这里y轴范围设高一点；

7、theme(plot.margin = margin(1,0.5,0.5,0.5,‘cm’))函数用来设置绘图区域外上、左、下、右的空白区域宽度。



三、左边柱状图 leftchart 细节备注

1、factor() 函数固定4个处理的顺序

2、同样用到stat_summary()函数绘制柱状图、误差棒；

2、geom_jitter()添加抖动点图层；

3、coord_flip()函数使得x、y轴转换，使图“倒下”。



四、右边柱状图 rightchart 细节备注

右边柱状图绘制方法和左边的基本一样，但要注意是是右边图片叠加区域是灰色背景，这里需要加两个theme()函数内的参数处理：plot.background、panel.background，都设置为透明“transparent”。

### 最重要的是：

码代码不易，如果你觉得我的教程对你有帮助，请关注：

个人小红书 **Ms.Tt (号Ttian6688)**

个人公众号 **MsTt笔记**
