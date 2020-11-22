library(dplyr)
library(stats)
library(utils)
library(here)

#import data
raw <- read.csv(here("wisconsincancer.csv"))

#eksplorasi data
str(raw)
#cek null dan na
sum(is.na(raw))
sum(is.null(raw))
#jadiin id row names
row.names(raw)<-raw$id

data<-select(raw,-c(id,diagnosis,X))
#bikin vector numeris untuk hasil diagnosis
diagnosis <- as.numeric(ifelse(raw$diagnosis=="M",1,0))
table(diagnosis)

#melakukan PCA 

##cek means dan sd tiap kolom
colMeans(data)
apply(data,2,sd)

##karena means != 1, dan sdev != 0
data_pc <- prcomp(data,scale=TRUE)
summary(data_pc)

##biplot hasil pca
biplot(data_pc)
plot(data_pc$x[, c(1, 4)], col = (diagnosis+1), 
     xlab = "PC1", ylab = "PC4")

##scree plot hasil pca
pc.var <- data_pc$sdev^2 #dapatkan variability
pve <- pc.var/sum(pc.var) # dapatkan kontribusi var tiap pc

plot(pve, xlab = "Principal Component", 
     ylab = "Proportion of Variance Explained", 
     ylim = c(0, 1), type = "b")

plot(cumsum(pve), xlab = "Principal Component", 
     ylab = "Cumulative Proportion of Variance Explained", 
     ylim = c(0, 1), type = "b")


#melakukan  hclustering

##scaling data
data_scale <- scale(data)

##bikin hclust metode average
hclust_data <- hclust(dist(data_scale),method="complete")
plot(hclust_data)

#potong jumlah clusrer
hclust_cut <- cutree(hclust_data,k=2)

#bandingkan dengan diagnosis
table(diagnosis,hclust_cut)

#melakukan kmeans clustering
kmeans_data <- kmeans(data_scale,center=2,nstart=20)

#bandingkan dgn diagnosis 
table(diagnosis,kmeans_data$cluster)

#bandingkan dgn hclust
table(hclust_cut,kmeans_data$cluster)

#hclust dengan data pca
hclust_pca<- hclust(dist(data_pc$x[,1:7]),method="complete")
h_clust_pca_cut <- cutree(hclust_pca,k=2)

#bandingkan dengan tanpa pca
table(hclust_cut,h_clust_pca_cut)

#bandingkan dengan diagnosis
table(diagnosis,h_clust_pca_cut)

#kmeans dengan data pca
kmeans_pca <- kmeans(data_pc$x[,1:7],center=2,nstart=20)

#bandingkan dengan diagnosis
table(diagnosis,kmeans_pca$cluster)

#bandingkan dengan tanpa pca
table(kmeans_data$cluster,kmeans_pca$cluster)
