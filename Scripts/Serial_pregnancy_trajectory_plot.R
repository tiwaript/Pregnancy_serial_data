require(ggplot2)
###### Mexican data ##############
png("PregnancyTrajectoryPlotIndUSMex_Eu&DALIcombined.png",height = 6,width=8,units = 'in',res=300)
ggplot(data = dat.plot, 
       aes(x =log(HOMAS_mean,base=10) ,  y =log(HOMAB_mean,base=10 ),
           shape=PregnancyVisits,col=PregnancyVisits))+
  
  geom_point( size = 6)+
  
  #geom_line(aes(group = cohort))+
  
  geom_path(aes(x =log(HOMAS_mean,base=10) ,  y =log(HOMAB_mean,base=10 ), group =cohort ), 
            arrow = arrow(length = unit(0.4, "cm")),col="black",linetype = "dashed",size=1)+
  
  theme(legend.position = c(0.88,0.82),
        legend.background = element_rect(fill = "white", color = "black"),
        legend.direction = "vertical",
        plot.title = element_text(color = "#65070c", size = 12, face = "bold",hjust=0.5),
        axis.title.y = element_text(colour="grey20",size=12,face="bold"),
        axis.text.x = element_text(colour="grey20",size=10,face="bold"),
        axis.text.y = element_text(colour="grey20",size=10,face="bold"),  
        axis.title.x = element_text(colour="grey20",size=12,face="bold"))+
  
  scale_shape_manual(values=c(10, 16, 17,18))+
  
  scale_color_manual(values=c('#873600',"#F8766D","#00BA38","#619CFF"))+
  
  ### Text annotation of the plot 
  ### Mexico
  geom_text(x=log(224,base=10),y=log(78,10),label="Mexico",fontface="bold",col="#65070c",size=5)+
  
  ### India
  geom_text(x=log(199.5,base=10),y=log(86,10),label="India",fontface="bold",col="#65070c",size=5)+
  
  ### USA
  geom_text(x=log(124.93,base=10),y=log(86,10),label="USA",fontface="bold",col="#65070c",size=5)+
  
  ### Europe (Ned, Denmark)
  #geom_text(x=log(99.43,base=10),y=log(114,10),label="Europe",fontface="bold",col="#65070c",size=5)+
  
  ### Dali
  #geom_text(x=log(80,base=10),y=log(150,10),label="DALI",fontface="bold",col="#65070c",size=5)+
  
  ### Ned , Denmark and DALI combine
  geom_text(x=log(87,base=10),y=log(135,10),label="Europe",fontface="bold",col="#65070c",size=5)+
  
  labs(title = "Trajectory of Insulin Sensitivity-Secretion with Gestation")+
  
  xlab(("log(HOMA-S) (Insulin Sensitivity)"))+ylab("log(HOMA-B) (Insulin Secretion)")
  
dev.off()