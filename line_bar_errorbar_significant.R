library(tidyverse) #ggplot2包，tidyr包等
library(reshape2)  #长宽数据转换(melt函数)

#读入绘制折线图的数据
data <- read.csv('WeightChange_Smoking.csv',header = T)

#准备绘制折线图
#根据treat、Day合并数值列：
data1 <- melt(data, id=c('treat','Day'))

#设置绘制误差棒errorbar时用到的函数：
topbar <- function(x){      
  return(mean(x)+sd(x)/sqrt(length(x))) #误差采用了mean+-sem
}
bottombar <- function(x){
  return(mean(x)-sd(x)/sqrt(length(x)))
}

#折线图基础绘图
#绘图赋值为p0
p0 <- ggplot(data1,aes(Day,value,color=treat))+
  geom_rect(aes(xmin=21,xmax=40,ymin=(-Inf),ymax=Inf),
            fill='grey90',color='grey90')+
  geom_vline(xintercept =21,linetype=2,cex=1.2)+
  stat_summary(geom = 'line',fun='mean',cex=3.5)+
  stat_summary(geom = 'errorbar',
               fun.min = bottombar,fun.max = topbar,
               width=1,cex=1,aes(fill=treat),color = 'black')+
  stat_summary(geom = 'point',fun='mean',aes(fill=treat),
               size=6,pch=21,color='black',
               key_glyph = 'polygon')+
  theme_classic(base_size = 15)

#自定义颜色，mycol1用于折线图，mycol2用于柱状图
mycol1 = c('#1A0841','#4F9DA6','#FF5959','#FFAD5A')
mycol2 = c('#FFAD5A','#4F9DA6','#FF5959','#1A0841')

#折线图细节添加
linechart <- p0+
  scale_color_manual(values = mycol1)+
  scale_fill_manual(values = mycol1)+
  scale_y_continuous(breaks = seq(0,60,20),expand = c(0,0))+
  scale_x_continuous(breaks = seq(0,40,10),expand = c(0,0))+
  labs(y='Weight change(%)')+
  theme(axis.title = element_text(color = 'black',size = 22),
        axis.line = element_line(size = 1),
        axis.text = element_text(color = 'black',size = 20),
        axis.ticks = element_line(size = 1,color='black'),
        legend.position = 'top',
        legend.title = element_blank(),
        legend.key.size = unit(20, "pt"),
        legend.text = element_text(size = 13))+
  annotate(geom = 'segment',x=36.2,xend=36.2,y=18,yend=26,cex=1.2)+
  annotate(geom = 'text',label='***',x=37.2,y=22,size=7,angle=90)+
  annotate(geom = 'segment',x=38,xend = 38,y=18,yend = 40,cex=1.2)+
  annotate(geom = 'text',label='****',x=39,y=29,size=7,angle=90)+
  coord_cartesian(clip = 'off',ylim = c(0,60),xlim = c(0,40))+
  theme(plot.margin = margin(1,0.5,0.5,0.5,'cm'))


#绘制柱状图
#读入绘制柱状图（左）的数据
data_exposure <- read.csv('iAUC_exposure.csv',header = T)

#读入绘制柱状图（右）的数据
data_cessation <- read.csv('iAUC_cessation.csv',header = T)

#数据处理
data2 <- gather(data_exposure,key = treat)
data3 <- gather(data_cessation,key = treat)

#左边柱状图：
leftchart <- ggplot(data2,aes(factor(treat,levels = c('SMK.abx','Non_SMK.abx','SMK','Non_SMK')),
                               value))+
    stat_summary(geom = 'bar',fun = 'mean',
                 fill='white',color='black',
                 width=0.7,cex=1)+
    stat_summary(geom = 'errorbar',
                 fun.min = bottombar,fun.max = topbar,
                 width=0.3,cex=0.8,color='black')+
    geom_jitter(aes(color=factor(treat,levels = c('SMK.abx','Non_SMK.abx','SMK','Non_SMK'))),
                width = 0.1,size=1.5)+
    scale_color_manual(values = mycol2)+
    labs(x=NULL,y=NULL)+
    scale_y_continuous(limits = c(-200,800),breaks = c(-200,300,800),expand = c(0,0))+
    geom_hline(yintercept =0,cex=1)+
    theme_classic(base_size = 15)+
    theme(axis.ticks.y = element_blank(),
          axis.text.y= element_blank(),
          legend.position = 'none',
          axis.line = element_line(size = 1),
          axis.text = element_text(color = 'black',size = 16),
          axis.ticks = element_line(size = 1,color='black'))+
    coord_flip()+
    annotate(geom = 'segment',x=1,xend=2,y=700,yend=700,cex=1.2)+
    annotate(geom = 'text',label='****',x=1.5,y=740,size=6,angle=90)+
    annotate(geom = 'segment',x=3,xend =4,y=550,yend =550,cex=1.2)+
    annotate(geom = 'text',label='****',x=3.5,y=590,size=6,angle=90)

#右边柱状图：
rightchart <- ggplot(data3,aes(factor(treat,levels = c('SMK.abx','Non_SMK.abx','SMK','Non_SMK')),
                               value))+
  stat_summary(geom = 'bar',fun = 'mean',fill='white',color='black',width=0.7,cex=1)+
  stat_summary(geom = 'errorbar',
               fun.min = bottombar,fun.max = topbar,
               width=0.3,cex=0.8,color='black')+
  geom_jitter(aes(color=factor(treat,levels = c('SMK.abx','Non_SMK.abx','SMK','Non_SMK'))),
              width = 0.1,size=1.5)+
  scale_color_manual(values = mycol2)+
  labs(x=NULL,y=NULL)+
  scale_y_continuous(limits = c(0,400),breaks = c(0,200,400),expand = c(0,0))+
  geom_hline(yintercept =0,cex=1)+
  theme_classic(base_size = 15)+
  theme(axis.ticks.y = element_blank(),
        axis.text.y= element_blank(),
        legend.position = 'none',
        axis.line = element_line(size = 1),
        axis.text = element_text(color = 'black',size = 16),
        axis.ticks = element_line(size = 1,color='black'),
        plot.background = element_rect(fill = "transparent",colour = NA),
        panel.background = element_rect(fill = "transparent",colour = NA))+
  coord_flip()+
  annotate(geom = 'segment',x=1,xend=3,y=340,yend=340,cex=1.2)+
  annotate(geom = 'text',label='****',x=2,y=360,size=6,angle=90)+
  annotate(geom = 'segment',x=3,xend =4,y=300,yend =300,cex=1.2)+
  annotate(geom = 'text',label='****',x=3.5,y=320,size=6,angle=90)

#最终图片叠加，完成绘图
#要叠加的图片先用ggplotGrob()函数处理：
leftchart <- ggplotGrob(leftchart)
rightchart <- ggplotGrob(rightchart)

#叠加绘图：
linechart+
  annotation_custom(leftchart,xmin=0,xmax=20.5,ymin=40,ymax=57)+
  annotation_custom(rightchart,xmin=21,xmax=39.5,ymin=40,ymax=57)+
  annotate('text',label='iAUC: Exposure',x=10.5,y=58.5,size=6)+
  annotate('text',label='iAUC: Cessation',x=31,y=58.5,size=6)

#输出图片：
ggsave("line_bar_errorbar_significant.png", width = 6, height = 7, dpi = 600)
ggsave("line_bar_errorbar_significant.pdf", width = 6, height = 7)


