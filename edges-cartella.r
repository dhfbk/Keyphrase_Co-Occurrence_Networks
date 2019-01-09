#R SCRIPT TO CONVERT THE OUTPUT OF KD TOOL TO A LIST OF UNDIRECTED EDGES THAT CAN BE IMPORTED IN GEPHI FOR FURTHER ANALYSIS AND VISUALIZATION
folder <- "PATH_INPUT" #ADD THE PATH TO THE FOLDER CONTAINING THE TSV FILES THAT ARE THE OUTPUT OF KD
file_list <- list.files(path=folder, pattern="*.tsv") 
combinededges <- c()
newcolumn <- c()


for (i in 1:length(file_list)){
  
        filePath <-paste(folder, file_list[i], sep="")
         
         MyData <- read.csv(file=filePath, header=FALSE, sep="\t")
         labels <- t(head(MyData,5)[1:1]) #change the number of "MyData,5" to select the number of keyphrases to be used
         edges <-combn(labels, 2)
         edges <-t(edges)
         combinededges = rbind(combinededges,edges)
         
}


und <- rep("undirected" , dim(combinededges)[1])
combinededges <- cbind(combinededges,und)
write.table(combinededges, file = "PATH_OUTPUT", sep=",", row.names=FALSE,col.names=c("source","target","type")) #ADD THE PATH AND THE NAME OF THE OUTPUT FILE (A CSV FILE)
