\name{bglm-package}
\alias{bglm-package}
\alias{bglm}
\docType{package}
\title{
Bayesian estimation in glm is implemented via Metropolis Hastings algorithm following the proposal kernel defined by Gamerman (1997).
}
\description{
The package provides functions which perform Bayesian estimation via Metropolis-Hastings algorithm in generalized linear models. 
}
\details{
\tabular{ll}{
Package: \tab bglm\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2014-10-29\cr
License: \tab GPL-2\cr
Depends: \tab mvtnorm\cr
}

}
\author{
Nicolas Molano-Gonzalez, Edilberto Cepeda-Cuervo

Maintainer: Nicolas Molano-Gonzalez <nmolanog@unal.edu.co>
}
\references{
Gamerman, D. 1997. Sampling from the posterior distribution in generalized linear mixed models. Statistics and Computing, 7, 57-68.
}

\keyword{ package }
\examples{
library(faraway)
data(babyfood)
summary(babyfood)
g2<- glm(cbind(disease, nondisease) ~ sex+food,family=binomial,babyfood)
#####use N > 8000 for more accurate results
bmen<-binommh(disease~ sex+food,babyfood$disease+babyfood$nondisease,N=1000,
data=babyfood)
data.frame(R.coef=coef(g2),R.sd=sqrt(diag(summary(g2)$cov.unscaled)),
           mh.mean=apply(bmen$chain,2,mean),mh.sd=apply(bmen$chain,2,sd))
}