#BIOL432 Assignment 5 Part 3

library(rentrez)#Activate the retrez lirbary 
COVIDiD<-c("NC_045512.2") #Supply a NCBI id inked to COVID
COVID<-entrez_fetch(db = "Nucleotide", id = COVIDiD, rettype = "fasta") #Fetch the SARAs-CoV-2 genome from nucleotide database
COVID #run to see if the the genome has been retrieved 

COVID2<-gsub("\\n","",COVID) #drop all the newline characters from our COVID data 
COVID3<-gsub(".*genome+","",paste(COVID2,collapse="")) #extract the actual nucleotide sequence by removing eveyrthing before "genome"
COVID3

#Extracting the S protein, which is between 21563 p and 25384 bp 
#Sorry, I've tried many ways using Regex but nothing pretty had turned out. and frankly i think the following method might be more efficient then using Regex 
substr(COVID3,21563,25384)


#Blast Search and comments: 
#link to the BLAST result:https://blast.ncbi.nlm.nih.gov/Blast.cgi#alnHdr_1973567854
#The gene is highly conserved, as it appears in all of our hit results with perfect matches. 
#The matches are also conserved across different strains of SARS-CoV-19
#These findings speculate that the S protein  is essential to all variance of the virus. 
#Moreove, the role in host infection of S protein ould also suggest that  S protein contribute to the transmissibility of the virus
