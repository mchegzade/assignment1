
df <- read.csv("~/Desktop/phase2", header = FALSE)
head(df)
summary(df)
d <- table(df$V7)
frame2<-as.data.frame(d)
print(frame2)
plot(d,  xlab='number per protocol')




plot(d, main="Scatterplot for protocols",
     xlab="used ", ylab="Protocol name", pch=19) 


qplot(frame2$Var1, frame2$Freq, data = frame2)

install.packages("Sleuth2")

library("Sleuth2")
library("ggplot2")
ggplot(frame2, aes(frame2$Var1, frame2$Freq)) +
  geom_point(aes(size=frame2$Freq)) + 
  theme_bw() +
  labs(size="Reqeust size:" ) +
  scale_size_area() + 
  xlab("IP ADDRESS") +
  ylab("Number of Requests") +
  coord_flip() +
  ggtitle("Number of request of each IP source for phase 3")

