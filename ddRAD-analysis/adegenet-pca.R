#title           :adegenet-pca.R
#description     :This script will run PCA
#author		 :Shyaman Jayasundara (jmshyaman@eng.pdn.ac.lk)
#date            :11/20/2021
#usage		 :Rscript adegenet-pca.R
#dependencies           : adegenet, factoextra
#==============================================================================

library(adegenet)
library(factoextra)

# PCA from all 24 samples
x = read.genepop('populations.haps.genepop.gen')
sum(is.na(x$tab))
X <- tab(x, freq = TRUE, NA.method = "mean")
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3)

eig.val <- get_eigenvalue(pca1)
eig.val
eigp <- fviz_eig(pca1, geom = "bar",choice="eigenvalue", barcolor = "black", barfill="black", ticks=FALSE,tickslab=FALSE,
                 addlabels = FALSE, ggtheme = theme_gray(base_size = 25)+theme(plot.title = element_text(hjust = 0.5)) , main = "Eigenvalues",xlab = "", ylab = "")
eigp
pcap <- fviz_pca_ind(pca1,
                     repel = TRUE,
                     title="") 

tiff("pca_all.tiff", height=1600,width = 1600, res = 300)
print(pcap)
dev.off()

tiff("eig_all.tiff", height=400,width = 400)
print(eigp)
dev.off()

# PCA from all 23 samples excluding B_MAD

x = read.genepop('populations.haps.genepop.ex.gen')

sum(is.na(x$tab))
X <- tab(x, freq = TRUE, NA.method = "mean")
pca1 <- dudi.pca(X, scale = FALSE, scannf = FALSE, nf = 3)
pcap <- fviz_pca_ind(pca1,repel = TRUE,title="")
tiff("pca_23.tiff", height=1600,width = 1600, res = 300)
print(pcap)
dev.off()
eigp <- fviz_eig(pca1, geom = "bar",choice="eigenvalue", barcolor = "black", barfill="black", ticks=FALSE,tickslab=FALSE,
                 addlabels = FALSE, ggtheme = theme_gray(base_size = 25)+theme(plot.title = element_text(hjust = 0.5)) , main = "Eigenvalues",xlab = "", ylab = "")
tiff("eig_23.tiff", height=400,width = 400)
print(eigp)
dev.off()