% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/connection.R
\name{connection.matrix}
\alias{connection.matrix}
\title{Construct connection matrix for network analysis}
\usage{
connection.matrix(mat, label, threshold = 0.15, closest = TRUE)
}
\arguments{
\item{mat}{n*n dissimilarity (1-correlation) matrix (e.g. obtained by QuantNorm).}

\item{label}{n-dimension vector for the labels of the n subjects. Replicates share the same label.}

\item{threshold}{A number between 0 to 1. Two groups will be regarded as connected if average 1-correlation < threshold.}

\item{closest}{True or False. Whether connect the closest group or not if the closest group cannot satisfy the threshold condition.}
}
\value{
Returns the connection matrix between unique labels.
}
\description{
For data with known labels, this function constructs a connection matrix between unique labels, such as unique cell types. The returned matrix can be used for subject-wise network construction.
}
\examples{

library(network); library(ggplot2); library(sna); library(GGally) #drawing network graph

data("ENCODE")

#Assigning the batches based on species
batches <- c(rep(1,13),rep(2,13))

#QuantNorm correction
corrected.distance.matrix <- QuantNorm(ENCODE,batches,method='row/column', cor_method='pearson',
                                       logdat=FALSE,standardize = TRUE, tol=1e-4)

#Constructing connection matrix

mat <- connection.matrix(mat=corrected.distance.matrix,label=colnames(corrected.distance.matrix))

#Creating network object and plot
ENCODE.net=network(mat, directed=FALSE)
ENCODE.net \%v\% "Species" <- c(rep('Human',13),rep('Mouse',13))
p0 <- ggnet2(ENCODE.net,label=TRUE,color = 'Species', palette = "Set2",
             size = 3, vjust = -0.6,mode = "kamadakawai",label.size = 3,
             color.legend = 'Species')+theme(legend.position = 'bottom')
plot(p0)
}
\references{
Fei et al (2018), Mitigating the adverse impact of batch effects in sample pattern detection, Bioinformatics, https://doi.org/10.1093/bioinformatics/bty117.
}
\author{
Teng Fei. Email: tfei@emory.edu
}
