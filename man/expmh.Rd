\name{expmh}
\alias{expmh}
\alias{expmh.default}
\alias{expmh.formula}
\title{
Function for Bayesian Estimation in Exponential Distribution Models
}
\description{
In this function the transition kernel proposed by Gamerman (1997) is implemented for a Metropolis Hastings algorithm, in order to sample the posterior distribution of the regression parameters given de data in a exponential distribution model. A normal Prior is assumed for the regression parameters. For now only the log link is implemented.
}
\usage{
\method{expmh}{default}(y, X, b = rep(0, dim(X)[2]), 
B = diag(rep(100, dim(X)[2])), N = 3000, flag = F,...)
\method{expmh}{formula}(formula, data = list(), ...)
}

\arguments{
  \item{formula}{
an object of class formula: a symbolic description of the model to be fitted.
}
  \item{data}{
A data frame containing the variables in the model.
}
  \item{\dots}{
When using expmh.formula, the formula object encapsulates the arguments y and X of expmh.default, thus ... represents all other arguments needed in expmh.default to be passed to expmh.formula
}
  \item{y}{
Response variable, vector of positive numbers.
}
  \item{X}{
Design matrix
}
  \item{b}{
Mean of the normal prior distribution of the regression parameters.
}
  \item{B}{
Covariance matrix of the normal prior distribution of the regression parameters.
}
  \item{N}{
Number mcmc simulations of the posterior distributions of the regression parameters given de data.
}
  \item{flag}{
Logical, if TRUE iterations and acceptance ratio of the samples is printed to monitor the mcmc progress.
}
}
\details{
See Gamerman (1997) for the details.
}
\value{
A list with the following objects:
\item{chain }{A matrix where mcmc simulations of the posterior distributions of the regression parameters given the data is stored. Rows correspond to mcmc simulation and columns correspond to the regression parameters.}
\item{Deviance}{a vector with -2*l(y,chain[i,]), where l(.,.) is the log-likelihood of the model.}
\item{Accepted_samples}{An integer with the number of samples accepted by the M-H algorithm.}
}
\references{
Gamerman, D. 1997. Sampling from the posterior distribution in generalized linear mixed models. Statistics and Computing, 7, 57-68.
}
\author{
Nicolas Molano-Gonzalez, Edilberto Cepeda-Cuervo
}
\examples{
################
### Simulated data
################
library(coda)
library(car)
n<-500
(beta<-runif(2,-10,10))
###limits of mu
ld<-c(10,70)
###generate X according to ld
xlm<-c((log(ld[1])-beta[1])/beta[2],(log(ld[2])-beta[1])/beta[2])
####design matrix
X<-as.matrix(data.frame(x0=rep(1,n),x1=runif(n,sort(xlm)[1],sort(xlm)[2])))
mu<-sapply(1:dim(X)[1],function(i){exp(X[i,]\%*\%beta)})
######generate the data according to the model
y<-rexp(n,1/mu)
###fit the model
bres<-expmh(y~X[,2],N=3000)
###compare with true beta
round(data.frame(true.beta=beta,
                 mh.mean=apply(bres$chain,2,mean),
                 mh.sd=apply(bres$chain,2,sd)),5)
#####examine MCMC chains.                 
dev.new(width=9,height=6)
par(mfrow=c(2,3))
plot(as.ts(bres$chain[,1]),cex.main=0.9,main=expression(beta[0]),
     ylab="",xlab="iterations" )
plot(density(bres$chain[,1]),cex.main=0.9, col="red", lwd=2, 
     main=expression(beta[1]) )
autocorr.plot(mcmc(bres$chain[,1]),cex.main=0.9, col="red", lwd=2, 
              main=expression(beta[0]),auto.layout=FALSE ,lag.max=100)
plot(as.ts(bres$chain[,2]),cex.main=0.9,main=expression(beta[1]),
     ylab="",xlab="iterations" )
plot(density(bres$chain[,2]),cex.main=0.9, col="red", lwd=2, 
     main=expression(beta[0]) )
autocorr.plot(mcmc(bres$chain[,2]),cex.main=0.9, col="red", lwd=2,
              main=expression(beta[1]),auto.layout=FALSE ,lag.max=100)
}