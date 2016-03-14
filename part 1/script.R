library(verisr)
library(ggplot2)
library(dplyr)
pdf("plots.pdf") #create a pdf document
jsondir <- '~/Desktop/ch07/data/vcdb/'

vcdb_orginal <- json2veris(jsondir)

summary(vcdb_orginal)

newjsondir <- '~/Desktop/VCDB-master/data/json/'

vcdb_verizon <- json2veris(newjsondir)

summary(vcdb_verizon)

actors <- getenum(vcdb_orginal, "actor")

print(actors)

actors2 <- getenum(vcdb_verizon, "actor")

print(actors2)

verisplot <- function(vcdb_orginal, field) {
  # data frame with field freq
  localdf <- getenum(vcdb_orginal, field, add.freq=T)
  # data set pf first 5
  localdf <- localdf[c(1:15), ]
  # add a label to df
  localdf$lab <- paste(round(localdf$freq*100, 0), "%", sep="")
  # create ggplot
  gg <- ggplot(localdf, aes(x=enum, y=freq, label=lab))
  gg <- gg + geom_bar(stat="identity", fill="steelblue")
  # add in text, adjusted to the end of the bar
  gg <- gg + geom_text(hjust=-0.1, size=3)
  # flip the axes and add in a title
  gg <- gg + coord_flip() + ggtitle(field)
  # remove axes labels and add bw theme
  gg <- gg + xlab("") + ylab("") + theme_bw()
  # fix the y scale to remove padding and fit our label (add 7%)
  gg <- gg + scale_y_continuous(expand=c(0,0),
                                limits=c(0, max(localdf$freq)*1.1))
  # make it slightly prettier than the default
  gg <- gg + theme(panel.grid.major = element_blank(),
                   panel.border = element_blank(),
                   axis.text.x = element_blank(),
                   axis.ticks = element_blank())
}

print (verisplot(vcdb_orginal, "action"))

verisplot2 <- function(vcdb_verizon, field) {
  # get the data.frame for the field with frequency
  localdf2 <- getenum(vcdb_verizon, field, add.freq=T)
  # now let's take first 5 fields in the data frame.
  localdf2 <- localdf2[c(1:15), ]
  # add a label to the data.frame
  localdf2$lab <- paste(round(localdf2$freq*100, 0), "%", sep="")
  # create a ggplot
  gg2 <- ggplot(localdf2, aes(x=enum, y=freq, label=lab))
  gg2 <- gg2 + geom_bar(stat="identity", fill="steelblue")
  # add text at end of bar
  gg2 <- gg2 + geom_text(hjust=-0.1, size=3)
  #  yx axis and add in a title
  gg2 <- gg2 + coord_flip() + ggtitle(field)
  # remove axis labels
  gg2 <- gg2 + xlab("") + ylab("") + theme_bw()
  # add padding
  gg2 <- gg2 + scale_y_continuous(expand=c(0,0),
                                  limits=c(0, max(localdf2$freq)*1.1))
  # clean up panel
  gg2 <- gg2 + theme(panel.grid.major = element_blank(),
                     panel.border = element_blank(),
                     axis.text.x = element_blank(),
                     axis.ticks = element_blank())
}

#print info's
print (verisplot2(vcdb_verizon, "action"))

print(verisplot(vcdb_orginal, "actor.external.variety"))

print(verisplot2(vcdb_verizon, "actor.external.variety"))

print(verisplot(vcdb_orginal, "action.physical.variety"))

print(verisplot2(vcdb_verizon, "action.physical.variety"))

print(verisplot(vcdb_orginal, "action.hacking.vector"))

print(verisplot2(vcdb_verizon, "action.hacking.vector"))

print(verisplot(vcdb_orginal, "attribute.confidentiality.data.variety"))

print(verisplot2(vcdb_verizon, "attribute.confidentiality.data.variety"))

print(verisplot(vcdb_orginal, "asset.assets"))

print(verisplot2(vcdb_verizon, "asset.assets"))



a2 <- getenum(vcdb_orginal, enum="action", primary="asset.assets", add.freq=T)
a2
# trim useless data
a2 <- a2[which(a2$enum!="Environmental" & a2$enum!="Unknown"), ]
#make slim version
slim.a2 <- a2[which(a2$x!=0), ]
# plot df
gg <- ggplot(a2, aes(x=enum, y=enum1, fill=freq))
gg <- gg + geom_tile(fill="white", color="gray80")
gg <- gg + geom_tile(data=slim.a2, color="gray80")
gg <- gg + scale_fill_gradient(low = "#F0F6FF",
                               high = "#4682B4", guide=F)
gg <- gg + xlab("") + ylab("") + theme_bw()
gg <- gg + scale_x_discrete(expand=c(0,0))
gg <- gg + scale_y_discrete(expand=c(0,0))
gg <- gg + theme(axis.ticks = element_blank())
# display plot
print(gg)

a22 <- getenum(vcdb_verizon, enum="action", primary="asset.assets", add.freq=T)
# remove all unknow and enviromental in df
a22 <- a22[which(a22$enum!="Environmental" & a22$enum!="Unknown"), ]
# slim version
slim.a22 <- a22[which(a22$x!=0), ]
# could be sorting
# make plot
gg <- ggplot(a22, aes(x=enum, y=enum1, fill=freq))
gg <- gg + geom_tile(fill="white", color="gray80")
gg <- gg + geom_tile(data=slim.a22, color="gray80")
gg <- gg + scale_fill_gradient(low = "#F0F6FF",
                               high = "#4682B4", guide=F)
gg <- gg + xlab("") + ylab("") + theme_bw()
gg <- gg + scale_x_discrete(expand=c(0,0))
gg <- gg + scale_y_discrete(expand=c(0,0))
gg <- gg + theme(axis.ticks = element_blank())
# and view it
print(gg)
dev.off()
