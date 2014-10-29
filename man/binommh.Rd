\name{binommh}
\alias{binommh}
\alias{binommh.default}
\alias{binommh.formula}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function for Bayesian Estimation in Binomial Models
}
\description{
In this function the transition kernel proposed by Gamerman (1997) is implemented for a Metropolis Hastings algorithm, in order to sample the posterior distribution of the regression parameters given de data in a binomial distribution model. A normal Prior is assumed for the regression parameters. For now only the logit link is implemented.
}
\usage{
\method{binommh}{default}(y, m, X, b = rep(0, dim(X)[2]), 
B = diag(rep(10000, dim(X)[2])),N = 3000, flag = F,...)
\method{binommh}{formula}(formula, data = list(), weights, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{formula}{
an object of class formula: a symbolic description of the model to be fitted.
}
  \item{data}{
A data frame containing the variables in the model.
}
  \item{weights}{
Vector indicating the total number of experiments in each observation. Note: it is not searched in the data environment.
}
  \item{y}{
Response variable, a vector codding for counts of success in a given number of trials, where m is a vector indicating the total number of experiments in each observation.
}

  \item{m}{
Vector indicating the total number of experiments in each observation.
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
  \item{\dots}{When using binommh.formula, the formula object encapsulates the arguments y and X of binommh.default, thus ... represents all other arguments needed in binommh.default to be passed to binommh.formula}

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
library(faraway)
data(babyfood)
summary(babyfood)
g2<- glm(cbind(disease, nondisease) ~ sex+food,family=binomial,babyfood)
#####use N > 8000 for more accurate results
bmen<-binommh(disease~ sex+food,babyfood$disease+babyfood$nondisease,N=1000,
data=babyfood)
#####compare Bayesian estimation vs clasical
data.frame(R.coef=coef(g2),R.sd=sqrt(diag(summary(g2)$cov.unscaled)),
           mh.mean=apply(bmen$chain,2,mean),mh.sd=apply(bmen$chain,2,sd))
}
