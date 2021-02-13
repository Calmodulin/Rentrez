#BIOL432 Assignment 5 Part 1
install.packages("rentrez")#install Rentrez package
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") #Supply what ncbi id we need to be looking at 
library(rentrez)  # activate Rentrez package
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")
Bburg
#Explain what each line does 
#library: activate the Rentrez package 
#entrez_fetch: download data from NCBI databases. DB: character, name of the databse to use. 
#db: tells us which database the information is form 
#id: tells us which ncbi id to match with 
#rettype:tells the file type that we would like to extract 
#Bburg: to output the fetched data 

Sequences<-strsplit(Bburg,split="\n\n")#use the strisplit()function to split Bburg sequence based on \n\n, which are 2 newline characters indicating the start of a new strain 
print(Sequences)

Sequences<-unlist(Sequences)#Use unlist to convert the sequence list into a dataframe 

#Use regular expressions to extract sequences from the headers
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

library(dplyr)
Sequences2<-transmute(Sequences,Name,Sequence=gsub("\n","",Sequences$Sequence))
Sequences2
write.csv(Sequences2,"Sequences.csv")

#Markdown script: 
read.csv("Sequences.csv")
Sequences3<-read.csv("Sequences.csv")

#Print out each sequence:
SeqSub<-gsub("","",Sequences3$Sequences_)

#Number of ATGC
library(stringr)
A<-str_count(SeqSub,"A")
G<-str_count(SeqSub,"G")
C<-str_count(SeqSub,"C")
T<-str_count(SeqSub,"T")

#Number of each nucleotide as a table for the 3 sequences 
SeqTable<-matrix(c(A,G,C,T),ncol=3,byrow=TRUE)
colnames(SeqTable)<-c(ncbi_ids)
rownames(SeqTable)<-c("A","G","C","T")
SeqTable
#Include an image of a bacteria from the internet, and a link to the Wikipedia page about Borrelia burgdorferi


#Calculate GC content, create a table: 
library(scales)

GCCount<-(G+C)/(A+G+C+T)*
GCCount
GCCountP <-scales::percent(GCCount)

GCTable<-matrix(c(GCCountP),nrow=3,byrow=FALSE)
colnames(GCTable)<-c("GC Content")
rownames(GCTable)<-c(ncbi_ids)
GCTable



