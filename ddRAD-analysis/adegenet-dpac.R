#title           :adegenet-dpac.R
#description     :This script will run DAPC
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :Rscript adegenet-dpac.R
#dependencies           : adegenet, factoextra, ggplot2, reshape2
#==============================================================================

library(adegenet)
library(factoextra)
library(ggplot2)
library(reshape2)

x = read.genepop('populations.haps.genepop.ex.gen')

set.seed(4)
grp1 <- find.clusters(x, max.n.clust=10, n.pca = 40)
dapc1 <- dapc(x, scale = FALSE, pop=grp1$grp, n.pca = 20)
scatter(dapc1, col=funky(6))
scatter(dapc1, cell=0, cstar=0, scree.da=FALSE, clab=0, cex=3,
        solid=.4, bg="white", leg=TRUE, posi.leg="topleft")

my_df <- as.data.frame(dapc1$ind.coord)
my_pal <- RColorBrewer::brewer.pal(n=8, name = "Dark2")
Cluster <- grp1$grp
p2 <- ggplot(my_df, aes(x = LD1, y = LD2, color = Cluster, fill = Cluster))
p2 <- p2 + geom_point(size = 4, shape = 21)
p2 <- p2 + theme_bw()
p2 <- p2 + scale_color_manual(values=c(my_pal))
p2 <- p2 + scale_fill_manual(values=c(paste(my_pal, "66", sep = "")))
p2
ggsave("dapc.tiff",dpi = 300, height=1600,width = 1600, units = "px")
dev.off()
