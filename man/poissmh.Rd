\name{poissmh}
\alias{poissmh}
\alias{poissmh.default}
\alias{poissmh.formula}  
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function for Bayesian Estimation in Poisson Models
}
\description{
In this function the transition kernel proposed by Gamerman (1997) is implemented for a Metropolis Hastings algorithm, in order to sample the posterior distribution of the regression parameters given de data in a poisson regression. A normal Prior is assumed for the regression parameters. For now only the log link is implemented.
}
\usage{
\method{poissmh}{default}(y, X, b = rep(0, dim(X)[2]), 
B = diag(rep(10000, dim(X)[2])), N = 3000, flag = F,...)
\method{poissmh}{formula}(formula, data = list(), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{formula}{
an object of class formula: a symbolic description of the model to be fitted.
}
  \item{data}{
A data frame containing the variables in the model.
}
  \item{\dots}{When using poissmh.formula, the formula object encapsulates the arguments y and X of poissmh.default, thus ... represents all other arguments needed in poissmh.default to be poissmh to binommh.formula}
  \item{y}{
Response variable, a vector of counts.
}
  \item{X}{
Design matrix.
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
See Gamerman, 1997 for the details.
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
library(faraway)
data(gala)
g2<-glm(Species ~ .,family=poisson, gala)
#####use N > 8000 for more accurate results
bmen<-poissmh(Species ~ .,data=gala,N=1000)
#####compare Bayesian estimation vs classical
round(data.frame(R.coef=coef(g2),R.sd=sqrt(diag(summary(g2)$cov.unscaled)),
                 mh.mean=apply(bmen$chain,2,mean),mh.sd=apply(bmen$chain,2,sd)),4)

}
