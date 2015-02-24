library(ggplot2)
library(grid)
theme_set(theme_bw())
library(extrafont)

plot_plot<-function(dat1,out_file,qseq_length,Query)
{
    #########################################################
    # Growth Rate
    #########################################################
    # Preprocess for annotation text
    
    #a <- unique(dat1$Scaf)
    
    #pos <- as.integer(as.integer(qseq_length)/2)
    
    ##########################################################
    #
    ##########################################################
    c2 <- ggplot(dat1,aes(x=QRange,y=Fish,colour=IDN_G,group=interaction(ID1,Fish)))
    c2 <- c2 + geom_line(size=3)  
    #c2 <- c2 + geom_text(aes(label=Scaf))
    
    txt <- paste("Salmon gene (",Query,") sequence (bps)",sep="")
    c2 <- c2 + xlab(txt) + ylab("Fish orthologous genes")
    c2 <- c2 + xlim(1,as.integer(qseq_length))
    
    #########################################################
    # Annotation text
    #########################################################
    #for (i in 1:length(a))
    #{
    #        print(a[i])
    #        N1 <- unique(dat1$ID2[dat1$Scaf==a[i]])
    #        N1 <- N1 + 0.3
    #    # c2 <- c2 + annotate("text", label = a[i] , x = pos, y = N1, size = 6, colour = "black")
    #}
    

    ##########################################################
    # Other Plotting options
    ##########################################################
    c2 <- c2 +  theme(axis.title.x = element_text(size=25,face = "bold")) 
    c2 <- c2 +  theme(axis.title.y = element_text(size=25,face = "bold",angle = 90))
    
    c2 <- c2 + theme(axis.text.x=element_text(size=25,face = "bold"))
    #c2 <- c2 + theme(axis.text.y=element_blank()) #element_text(size=25,face = "bold"))
    c2 <- c2 + theme(axis.text.y=element_text(size=25,face = "bold"))
    c2 <- c2 + scale_colour_discrete("Identity")
    
    c2 <- c2 + theme(legend.title=element_text(size=20,face = "bold"))
    c2 <- c2 + theme(legend.text = element_text(size = 16))
    c2 <- c2 + theme(legend.key.size = unit(0.8, "cm"))
    c2 <- c2 + theme(legend.text.align=0)
    #c2 <- c2 + opts(legend.position= c(0.05,0.80))
    
    png(out_file,width=900,height=700)
    print(c2)
    dev.off()

}


#######################################################################################
################################ MAIN PROGRAM #########################################
#######################################################################################
#args<-commandArgs(TRUE)

args <- commandArgs(trailingOnly = TRUE)

# Input File
input_file <- args[1]
dat1<-read.csv(file=input_file,sep='\t',header=FALSE)
colnames(dat1)<-c("Fish","QID","Scaf","IDN","QC","QRange","IDN_G","QLength","ID1","ID2")

print(input_file)

# Output File 
Query <- unique(dat1$QID)
out_file <- paste("/mnt/users/jeevka/Salmon_Orthologous_Genes/Make_Plots/",Query,".png",sep="")

qseq_length <- unique(dat1$QLength)

plot_plot(dat1,out_file,qseq_length,Query)
