suppressMessages(library(ape))
suppressMessages(library(dplyr))

args = commandArgs(trailingOnly=TRUE)
if (length(args) < 2) {
  stop("Must supply at least an input tree and a species list as arguments", call.=FALSE)
} else if (length(args)==2) {
  # default output file
  args[3] = "out"
  
}
outfileprefix = args[3]
#Load the tree and the species list
#treefile = "bac120_r86.1.tree
treefile <- args[1]
tree <- read.tree(file = treefile)
speciesfile <- args[2]
speciesList <- read.csv2(file = speciesfile, sep = ",", stringsAsFactors = F)

#Keep the species that exist among the tree labels
speciesList <- speciesList %>% filter(accession %in% as.character(tree$tip.label))

#Prune the tree to include only the species list
pruned.tree_final<-drop.tip(tree, tree$tip.label[-match(speciesList$accession, tree$tip.label)])

#Extract tip labels and replace with species names
df <- data.frame(accession = pruned.tree_final$tip.label) %>%
  mutate(accession = as.character(accession))
df <- merge(df, speciesList)
df <- df %>% select(accession, SpeciesName)
#Reorder species names to match the list of tips
df <- df[match(pruned.tree_final$tip.label, df$accession),]
pruned.tree_final$tip.label <- df$SpeciesName
#Write the final tree
outtreefile = paste(outfileprefix,".tre",sep = "")
message(paste("Writing the tree file: ", outtreefile, sep = ""))
write.tree(pruned.tree_final, file = outtreefile)
#Calculate the distance matrix
pairwiseMat <- cophenetic.phylo(pruned.tree_final)
#Write the distance matrix
outdistancefile = paste(outfileprefix,"_distances.csv", sep = "")
message(paste("Writing the distance matrix file: ", outdistancefile), sep = "")
write.table(pairwiseMat, file = outdistancefile, col.names=NA, sep = "," )
