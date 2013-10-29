#############################################################################
###
###		Scripts associated with 2013 EOCT SCIENCE: Science, Biology,
###		   Chemistry, Physics, Life Science and Integrated Science 1
###
#############################################################################

### SCIENCE

SCIENCE_2013.config <- list(
	 SCIENCE.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(4:5),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 SCIENCE.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(3:5),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 SCIENCE.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(2:5),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	 SCIENCE.2013 = list(
		sgp.content.areas=c( 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(7:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	 SCIENCE.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(6:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 SCIENCE.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(5:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 SCIENCE.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(4:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	SCIENCE.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'SCIENCE'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 8)),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	SCIENCE.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'SCIENCE'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c(6, 'EOCT', 8)),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	SCIENCE.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'SCIENCE'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(5:6, 'EOCT', 8)),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	SCIENCE.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(4:6, 'EOCT', 8)),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)

### BIOLOGY

BIOLOGY_2013.config <- list(
	BIOLOGY.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
		
	## All 6th grade Math priors produce:  Singular design matrix deep inside:  as.vector(my.matrix@.Data[,1]) ==> [1] "Error in rq.fit.br(x, y, tau = tau, ...) : Singular design matrix\n"
	# BIOLOGY.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(6,'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	# BIOLOGY.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		# sgp.panel.years=c('2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(5:6, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# BIOLOGY.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		# sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(4:6, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
		
	BIOLOGY.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c(7,'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(5:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	BIOLOGY.2013 = list(
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'GENERAL_MATHEMATICS', 'BIOLOGY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'GENERAL_MATHEMATICS', 'BIOLOGY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(5:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
		
	BIOLOGY.2013 = list(
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'), 
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'), 
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'), 
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	BIOLOGY.2013 = list(
		sgp.content.areas=c('GEOMETRY', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	# BIOLOGY.2013 = list( #  Big drop off adding Math (50%), and fit is worse adding priors.  Not worth "splitting up" the cohort.
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'BIOLOGY'), 
		# sgp.panel.years=c('2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	# BIOLOGY.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'BIOLOGY'), 
		# sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# BIOLOGY.2013 = list( # 600 kids
		# sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'BIOLOGY'), 
		# sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),


	BIOLOGY.2013 = list(
		sgp.content.areas=c('ALGEBRA_II', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	BIOLOGY.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II', 'BIOLOGY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END BIOLOGY_2013.config


### PHYSICS

PHYSICS_2013.config <- list(
	PHYSICS.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'PHYSICS'), 
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	# PHYSICS.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'PHYSICS'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# PHYSICS.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'PHYSICS'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
	# PHYSICS.2013 = list(
		# sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'PHYSICS'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	PHYSICS.2013 = list(
		sgp.content.areas=c('GEOMETRY', 'PHYSICS'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	PHYSICS.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'PHYSICS'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	# PHYSICS.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'PHYSICS'),
		# sgp.panel.years=c('2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	# PHYSICS.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'PHYSICS'),
		# sgp.panel.years=c('2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# PHYSICS.2013 = list(
		# sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'PHYSICS'),
		# sgp.panel.years=c('2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	PHYSICS.2013 = list(
		sgp.content.areas=c('ALGEBRA_II', 'PHYSICS'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	PHYSICS.2013 = list(
		sgp.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'PHYSICS'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	PHYSICS.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II', 'PHYSICS'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END PHYSICS_2013.config



CHEMISTRY_2013.config <- list(
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'CHEMISTRY'), 
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	# CHEMISTRY.2013 = list( #  Singular design matrix deep inside:  as.vector(my.matrix@.Data[,1]) ==> [1] "Error in rq.fit.br(x, y, tau = tau, ...) : Singular design matrix\n"
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'CHEMISTRY'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	# CHEMISTRY.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'CHEMISTRY'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'CHEMISTRY'), 
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	CHEMISTRY.2013 = list(
		sgp.content.areas=c('GEOMETRY', 'CHEMISTRY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'CHEMISTRY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	# CHEMISTRY.2013 = list( #  Singular design matrix deep inside:  as.vector(my.matrix@.Data[,1]) ==> ...
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'CHEMISTRY'),
		# sgp.panel.years=c('2010', '2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'CHEMISTRY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY', 'CHEMISTRY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	CHEMISTRY.2013 = list(
		sgp.content.areas=c('ALGEBRA_II', 'CHEMISTRY'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'CHEMISTRY'),
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II', 'CHEMISTRY'),
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END CHEMISTRY_2013.config

LIFE_SCIENCE_2013.config <- list(
	LIFE_SCIENCE.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'LIFE_SCIENCE'), 
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4)# ,
	# LIFE_SCIENCE.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'LIFE_SCIENCE'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	# LIFE_SCIENCE.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'LIFE_SCIENCE'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# LIFE_SCIENCE.2013 = list(
		# sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'LIFE_SCIENCE'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)
) ### END LIFE_SCIENCE_2013.config


INTEGRATED_SCIENCE_1.2013.config <- list(
	INTEGRATED_SCIENCE_1.2013 = list(
		sgp.content.areas=c('ALGEBRA_I', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	# INTEGRATED_SCIENCE_1.2013 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'INTEGRATED_SCIENCE_1'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	INTEGRATED_SCIENCE_1.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	# INTEGRATED_SCIENCE_1.2013 = list(
		# sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'INTEGRATED_SCIENCE_1'), 
		# sgp.panel.years=c('2011', '2012', '2013'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
		
	INTEGRATED_SCIENCE_1.2013 = list(
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	INTEGRATED_SCIENCE_1.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2011', '2012', '2013'),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	INTEGRATED_SCIENCE_1.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'GENERAL_MATHEMATICS', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	INTEGRATED_SCIENCE_1.2013 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'GENERAL_MATHEMATICS', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2009', '2010', '2011', '2012', '2013'),
		sgp.grade.sequences=list(c(5:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END INTEGRATED_SCIENCE_1.2013.config
