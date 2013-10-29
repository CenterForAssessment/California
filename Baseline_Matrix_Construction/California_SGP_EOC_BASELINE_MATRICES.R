###################################################################################################
###
###   California Baseline SGP matrix calculation
###
###################################################################################################

### Load SGP Package

setwd('/media/Data/Dropbox/SGP/California')

require(SGP)
require(data.table)

### Load Long Data

load("~/SGP_Projects/California/Data/California_SGP-Data_ONLY.Rdata")

###
###		Grade Level ELA
###

my.sgp.baseline.config <- list(
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(2:3),
		sgp.baseline.grade.sequences.lags=1),

	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(3:4),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(2:4),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(4:5),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(3:5),
		sgp.baseline.grade.sequences.lags=c(1, 1)),
		
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(5:6),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(4:6),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6:7),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(5:7),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6:7),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(5:7),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7:8),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6:8),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8:9),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7:9),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(9:10),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8:10),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(10:11),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'ELA'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(9:11),
		sgp.baseline.grade.sequences.lags=c(1, 1))
)

CA_ELA_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_ELA_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_ELA_Baseline_Matrices.Rdata')

###
###		Grade Level Math
###

my.sgp.baseline.config <- list(
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(2:3),
		sgp.baseline.grade.sequences.lags=1),

	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(3:4),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(2:4),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(4:5),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(3:5),
		sgp.baseline.grade.sequences.lags=c(1, 1)),
		
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(5:6),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(4:6),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6:7),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(5:7),
		sgp.baseline.grade.sequences.lags=c(1, 1))
)

CA_MATHEMATICS_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_MATHEMATICS_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_MATHEMATICS_Baseline_Matrices.Rdata')

###
###		Grade Level Science
###

my.sgp.baseline.config <- list(
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'SCIENCE'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(4:5),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(3:5),
		sgp.baseline.grade.sequences.lags=c(1, 1)),
		
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'SCIENCE'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7:8),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6:8),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'SCIENCE'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 8),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'SCIENCE'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('6', 'EOCT', '8'),
		sgp.baseline.grade.sequences.lags=c(1, 1))
)

CA_SCIENCE_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_SCIENCE_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_SCIENCE_Baseline_Matrices.Rdata')


###		BIOLOGY

my.sgp.baseline.config <- list(
	##  Algebra I Priors
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	##  General Math Priors
	list(
		sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'BIOLOGY'), # Can only exist with 7th grade Math.  Gen Math in 8th & 9th grade only.
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	##  Geometry Priors
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	## Algebra II prior
	list(
		sgp.baseline.content.areas=c('ALGEBRA_II', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

##
## Matched Priors
##

	list(
		sgp.baseline.content.areas=c('SCIENCE', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('SCIENCE', 'INTEGRATED_SCIENCE_1', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=c('INTEGRATED_SCIENCE_1', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('CHEMISTRY', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('PHYSICS', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('BIOLOGY', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_BIOLOGY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_BIOLOGY_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_BIOLOGY_Baseline_Matrices.Rdata')


###		PHYSICS

my.sgp.baseline.config <- list(
	##  Algebra I Priors
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'PHYSICS'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	# list(
		# sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'PHYSICS'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(6, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1)),
	# list(
		# sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'PHYSICS'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1)),

	##  Geometry Priors
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'PHYSICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'PHYSICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	## Algebra II prior
	list(
		sgp.baseline.content.areas=c('ALGEBRA_II', 'PHYSICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'PHYSICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

##
## Matched Priors
##

	list(
		sgp.baseline.content.areas=c('CHEMISTRY', 'PHYSICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('BIOLOGY', 'PHYSICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)# ,
	# list(
		# sgp.baseline.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICS'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1))
)

CA_PHYSICS_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_PHYSICS_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_PHYSICS_Baseline_Matrices.Rdata')


###		CHEMISTRY

my.sgp.baseline.config <- list(
	##  Algebra I Priors
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'CHEMISTRY'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	# list( # 7
		# sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'CHEMISTRY'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(6, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1)),
	# list( # 981
		# sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'CHEMISTRY'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1)),
	list(
		sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	##  Geometry Priors
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	## Algebra II prior
	list(
		sgp.baseline.content.areas=c('ALGEBRA_II', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

##
## Matched Priors
##

	list(
		sgp.baseline.content.areas=c('BIOLOGY', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('INTEGRATED_SCIENCE_1', 'BIOLOGY', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),
	list(
		sgp.baseline.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('LIFE_SCIENCE', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('BIOLOGY', 'LIFE_SCIENCE', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('CHEMISTRY', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_CHEMISTRY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_CHEMISTRY_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_CHEMISTRY_Baseline_Matrices.Rdata')


###		LIFE_SCIENCE

my.sgp.baseline.config <- list(
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'LIFE_SCIENCE'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	# list(
		# sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'LIFE_SCIENCE'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(6, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1)),
	# list(
		# sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'LIFE_SCIENCE'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1)),
	# list(
		# sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'LIFE_SCIENCE'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1))
	list(
		sgp.baseline.content.areas=c('BIOLOGY', 'LIFE_SCIENCE'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_LIFE_SCIENCE_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_LIFE_SCIENCE_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_LIFE_SCIENCE_Baseline_Matrices.Rdata')


###		INTEGRATED_SCIENCE_1

my.sgp.baseline.config <- list(
	##  Algebra I Priors
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'INTEGRATED_SCIENCE_1'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	# list( #14
		# sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'INTEGRATED_SCIENCE_1'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(6, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1)),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'INTEGRATED_SCIENCE_1'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),
	# list( #827
		# sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'INTEGRATED_SCIENCE_1'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1)),

	##  Gen Math Priors
	list(
		sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'INTEGRATED_SCIENCE_1'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'INTEGRATED_SCIENCE_1'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('SCIENCE', 'INTEGRATED_SCIENCE_1'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_INTEGRATED_SCIENCE_1_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_INTEGRATED_SCIENCE_1_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_INTEGRATED_SCIENCE_1_Baseline_Matrices.Rdata')


###		ALGEBRA_I

my.sgp.baseline.config <- list(
	##  Grade Level Math Priors
	 list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	 list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(5:6, 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	 list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	 list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6:7, 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	##  Gen Math Priors
	list( 
		sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I'), # Can only exist with 7th grade Math.  Gen Math in 8th & 9th grade only.
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	## Repeaters
	list( 
		sgp.baseline.content.areas=c('ALGEBRA_I', 'ALGEBRA_I'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_ALGEBRA_I_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_ALGEBRA_I_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_ALGEBRA_I_Baseline_Matrices.Rdata')


###		GENERAL_MATHEMATICS

my.sgp.baseline.config <- list(
	##  Grade Level Math Priors
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'GENERAL_MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6:7, 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	## course repeaters
	list( 
		sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'GENERAL_MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_GENERAL_MATHEMATICS_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_GENERAL_MATHEMATICS_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_GENERAL_MATHEMATICS_Baseline_Matrices.Rdata')


###		GEOMETRY

my.sgp.baseline.config <- list(
	##  Algebra I Priors
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'GEOMETRY'), # contains 'supercohort' of kids with 2010 Gen Math & Grade level Math
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),

	list(
		sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	## Algebra II prior
	list(
		sgp.baseline.content.areas=c('ALGEBRA_II', 'GEOMETRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	##  Geometry Repeaters
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'GEOMETRY'), #  course repeaters
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_GEOMETRY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_GEOMETRY_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_GEOMETRY_Baseline_Matrices.Rdata')



###		ALGEBRA_II

my.sgp.baseline.config <- list(
	##  Algebra I Priors
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'ALGEBRA_II'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	# list(
		# sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II'),
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(6, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1, 1)),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),
	list(
		sgp.baseline.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	##  Geometry Priors
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'ALGEBRA_II'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	## Algebra II Repeaters
	list(
		sgp.baseline.content.areas=c('ALGEBRA_II', 'ALGEBRA_II'),  # course repeaters
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_ALGEBRA_II_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_ALGEBRA_II_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_ALGEBRA_II_Baseline_Matrices.Rdata')


###		SUMMATIVE_HS_MATHEMATICS

my.sgp.baseline.config <- list(
	##  Geometry Priors
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	## Algebra II prior
	list(
		sgp.baseline.content.areas=c('ALGEBRA_II', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	## Sum Math Repeaters
	list(
		sgp.baseline.content.areas=c('SUMMATIVE_HS_MATHEMATICS', 'SUMMATIVE_HS_MATHEMATICS'),  # course repeaters
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_SUMMATIVE_HS_MATHEMATICS_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_SUMMATIVE_HS_MATHEMATICS_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_SUMMATIVE_HS_MATHEMATICS_Baseline_Matrices.Rdata')


###
###		History Subjects
###

###  Grade Level History

my.sgp.baseline.config <- list(
	 list(
		sgp.baseline.content.areas=c('ELA', 'HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7:8),
		sgp.baseline.grade.sequences.lags=1),
	 list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(6:8),
		sgp.baseline.grade.sequences.lags=c(1,1))
)

CA_HISTORY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_HISTORY_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_HISTORY_Baseline_Matrices.Rdata')


###		US_HISTORY

my.sgp.baseline.config <- list(
	###  Grade Level ELA
	###  Use this going forward in 2013 for Cohort and Baseline SGPs
	list(
		sgp.baseline.content.areas=c('ELA', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(10, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),		
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(9, 10, 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	list(
		sgp.baseline.content.areas=c('HISTORY', 'US_HISTORY'), #  Will only be 2 years in super-cohort
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT'),
		sgp.baseline.grade.sequences.lags=3),

	list(
		sgp.baseline.content.areas=c('WORLD_HISTORY', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=c('WORLD_HISTORY', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	# list(
		# sgp.baseline.content.areas=c('HISTORY', 'WORLD_HISTORY', 'US_HISTORY'), #  Will only be 2 years in super-cohort
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=c('HISTORY', 'WORLD_HISTORY', 'US_HISTORY'), #  Will only be 2 years in super-cohort
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(2,1))
)

CA_US_HISTORY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_US_HISTORY_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_US_HISTORY_Baseline_Matrices.Rdata')


###		WORLD_HISTORY

my.sgp.baseline.config <- list(
	list(
		sgp.baseline.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(7, 8, 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	list(
		sgp.baseline.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(9, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 9, 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	list(
		sgp.baseline.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(10, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(9, 10, 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	list(
		sgp.baseline.content.areas=c('HISTORY', 'WORLD_HISTORY'), #  Will only be 2 years in super-cohort
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT'),
		sgp.baseline.grade.sequences.lags=3),
	list(
		sgp.baseline.content.areas=c('HISTORY', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=c('HISTORY', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c(8, 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),

	list(
		sgp.baseline.content.areas=c('WORLD_HISTORY', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_WORLD_HISTORY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))

save(CA_WORLD_HISTORY_Baseline_Matrices, file='Data/Baseline_Matrices/Course Specific/CA_WORLD_HISTORY_Baseline_Matrices.Rdata')



###
###		Combine Baseline Matrices for SGPstateData
###

CA_Baseline_Matrices <- list()

for (ca in c('ELA', 'MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II', 'SUMMATIVE_HS_MATHEMATICS', 
		'SCIENCE', 'INTEGRATED_SCIENCE_1', 'LIFE_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS',
		'HISTORY', 'WORLD_HISTORY', 'US_HISTORY')) {
	CA_Baseline_Matrices[[paste(ca, '.BASELINE', sep='')]] <- eval(parse(text=paste('CA_', ca, "_Baseline_Matrices[['", ca, ".BASELINE']]", sep='')))
}

save(CA_Baseline_Matrices, file='Data/Baseline_Matrices/CA_Baseline_Matrices.Rdata')



#################################################################
###   Add in Baseline matrices to match SGP_CONFIG from 2010-12
###   All GRADE changed to EOCT for EOCT courses.
###   Added 10/20/13
#################################################################

load("Data/Baseline_Matrices/CA_Baseline_Matrices.Rdata")
	
	California_SGP@Data$TMP_GRADE <- California_SGP@Data$GRADE
	California_SGP@Data[CONTENT_AREA %in% c('ELA', 'MATHEMATICS', 'SCIENCE', 'HISTORY'), GRADE := 'EOCT']


my.sgp.baseline.config <- list(
	##  Algebra I Priors
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

##
## Matched Priors
##
	list(
		sgp.baseline.content.areas=c('SCIENCE', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('SCIENCE', 'INTEGRATED_SCIENCE_1', 'BIOLOGY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1))
)

CA_BIOLOGY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))


my.sgp.baseline.config <- list(
	list(
		sgp.baseline.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1))
)

CA_CHEMISTRY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))


my.sgp.baseline.config <- list(
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'INTEGRATED_SCIENCE_1'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'INTEGRATED_SCIENCE_1'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1)),

	list(
		sgp.baseline.content.areas=c('SCIENCE', 'INTEGRATED_SCIENCE_1'), 
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_INTEGRATED_SCIENCE_1_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))


my.sgp.baseline.config <- list(
	##  Gen Math Priors
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1))
)

CA_ALGEBRA_I_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))


my.sgp.baseline.config <- list(
	list(
		sgp.baseline.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1, 1))
)

CA_GEOMETRY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))


###
###		History Subjects
###

my.sgp.baseline.config <- list(
	###  Grade Level ELA
	list(
		sgp.baseline.content.areas=c('ELA', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),		
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),

	list(
		sgp.baseline.content.areas=c('HISTORY', 'US_HISTORY'), #  Will only be 2 years in super-cohort
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=3),

	list(
		sgp.baseline.content.areas=c('HISTORY', 'WORLD_HISTORY', 'US_HISTORY'), #  Will only be 2 years in super-cohort
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(2,1))
)

CA_US_HISTORY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))


my.sgp.baseline.config <- list(
	list(
		sgp.baseline.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=c('ELA', 'ELA', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=c(1,1)),
 
	# list( # not used in 2010-12
		# sgp.baseline.content.areas=c('HISTORY', 'WORLD_HISTORY'), #  Will only be 2 years in super-cohort
		# sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=3),
	list(
		sgp.baseline.content.areas=c('HISTORY', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=c('HISTORY', 'WORLD_HISTORY'),
		sgp.baseline.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1)
)

CA_WORLD_HISTORY_Baseline_Matrices <- baselineSGP(
	California_SGP,
	sgp.baseline.config=my.sgp.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND='PARALLEL',
		WORKERS=list(TAUS=20)))



###
###		Combine Baseline Matrices for SGPstateData
###

CA_Baseline_Matrices <- list()

for (ca in c('ALGEBRA_I', 'GEOMETRY','INTEGRATED_SCIENCE_1', 'BIOLOGY', 'CHEMISTRY', 'WORLD_HISTORY', 'US_HISTORY')) {
	CA_Baseline_Matrices[[paste(ca, '.BASELINE', sep='')]] <- eval(parse(text=paste('CA_', ca, "_Baseline_Matrices[['", ca, ".BASELINE']]", sep='')))
}

CA_Baseline_Matrices$ALGEBRA_I.BASELINE <- c(CA_Baseline_Matrices$ALGEBRA_I.BASELINE, CA_ALGEBRA_I_Baseline_Matrices$ALGEBRA_I.BASELINE)
CA_Baseline_Matrices$GEOMETRY.BASELINE <- c(CA_Baseline_Matrices$GEOMETRY.BASELINE, CA_GEOMETRY_Baseline_Matrices$GEOMETRY.BASELINE)
CA_Baseline_Matrices$INTEGRATED_SCIENCE_1.BASELINE <- c(CA_Baseline_Matrices$INTEGRATED_SCIENCE_1.BASELINE, CA_INTEGRATED_SCIENCE_1_Baseline_Matrices$INTEGRATED_SCIENCE_1.BASELINE)
CA_Baseline_Matrices$BIOLOGY.BASELINE <- c(CA_Baseline_Matrices$BIOLOGY.BASELINE, CA_BIOLOGY_Baseline_Matrices$BIOLOGY.BASELINE)
CA_Baseline_Matrices$CHEMISTRY.BASELINE <- c(CA_Baseline_Matrices$CHEMISTRY.BASELINE, CA_CHEMISTRY_Baseline_Matrices$CHEMISTRY.BASELINE)
CA_Baseline_Matrices$WORLD_HISTORY.BASELINE <- c(CA_Baseline_Matrices$WORLD_HISTORY.BASELINE, CA_WORLD_HISTORY_Baseline_Matrices$WORLD_HISTORY.BASELINE)
CA_Baseline_Matrices$US_HISTORY.BASELINE <- c(CA_Baseline_Matrices$US_HISTORY.BASELINE, CA_US_HISTORY_Baseline_Matrices$US_HISTORY.BASELINE)

save(CA_Baseline_Matrices, file='Data/Baseline_Matrices/CA_Baseline_Matrices.Rdata')
