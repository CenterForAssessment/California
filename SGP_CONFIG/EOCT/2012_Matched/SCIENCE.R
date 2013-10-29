#############################################################################
###
###		Scripts associated with 2012 EOCT SCIENCE: Science, Biology,
###		   Chemistry, Physics, Life Science and Integrated Science 1
###
#############################################################################

### SCIENCE - same as the Math/ELA config script

SCIENCE_2012_Match.config <- list(
	 SCIENCE.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(4:5),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 SCIENCE.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(3:5),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 SCIENCE.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(2:5),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	 SCIENCE.2012 = list(
		sgp.content.areas=c( 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(7:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 SCIENCE.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(6:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 SCIENCE.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(5:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	SCIENCE.2012 = list(
		sgp.content.areas=c('ALGEBRA_I', 'SCIENCE'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 8)),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	SCIENCE.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'SCIENCE'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c(6, 'EOCT', 8)),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)
)

### BIOLOGY

BIOLOGY_2012_Match.config <- list(
	BIOLOGY.2012 = list(
		sgp.content.areas=c('SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	
	BIOLOGY.2012 = list(
		sgp.content.areas=c('INTEGRATED_SCIENCE_1', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	BIOLOGY.2012 = list(
		sgp.content.areas=c('SCIENCE', 'INTEGRATED_SCIENCE_1', 'BIOLOGY'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	BIOLOGY.2012 = list(
		sgp.content.areas=c('CHEMISTRY', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

	# BIOLOGY.2012 = list(
		# sgp.content.areas=c('PHYSICS', 'BIOLOGY'),
		# sgp.panel.years=c('2011', '2012'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),

	BIOLOGY.2012 = list(
		sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END BIOLOGY_2012_Match.config


CHEMISTRY_2012_Match.config <- list(
	CHEMISTRY.2012 = list(
		sgp.content.areas=c('BIOLOGY', 'CHEMISTRY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
		
	CHEMISTRY.2012 = list(
		sgp.content.areas=c('INTEGRATED_SCIENCE_1', 'BIOLOGY', 'CHEMISTRY'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	CHEMISTRY.2012 = list(
		sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)# ,

###  Not run in 2012 below:
	# CHEMISTRY.2012 = list(
		# sgp.content.areas=c('LIFE_SCIENCE', 'CHEMISTRY'),
		# sgp.panel.years=c('2011', '2012'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# CHEMISTRY.2012 = list(#  included in CA_Courses_Source-Matched_Priors_2012.R, but no matrix found
		# sgp.content.areas=c('BIOLOGY', 'LIFE_SCIENCE', 'CHEMISTRY'), # BIO works as second prior, but not Integr Sci
		# sgp.panel.years=c('2010', '2011', '2012'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)# ,

	# CHEMISTRY.2012 = list( #  included in CA_Courses_Source-Matched_Priors_2012.R, but no matrix found
		# sgp.content.areas=c('CHEMISTRY', 'CHEMISTRY'),
		# sgp.panel.years=c('2011', '2012'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=0)
) ### END CHEMISTRY_2012_Match.config

### PHYSICS

PHYSICS_2012_Match.config <- list(
	PHYSICS.2012 = list(
		sgp.content.areas=c('CHEMISTRY', 'PHYSICS'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	PHYSICS.2012 = list(
		sgp.content.areas=c('BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	PHYSICS.2012 = list(
		sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),


	PHYSICS.2012 = list(
		sgp.content.areas=c('BIOLOGY', 'PHYSICS'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3)

	##  Not enough kids for repeaters
	
) ### END PHYSICS_2012_Match.config


LIFE_SCIENCE_2012_Match.config <- list(
	LIFE_SCIENCE.2012 = list(
		sgp.content.areas=c('BIOLOGY', 'LIFE_SCIENCE'), 
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)# ,
) ### END LIFE_SCIENCE_2012_Match.config


INTEGRATED_SCIENCE_1.2012_Match.config <- list(
	INTEGRATED_SCIENCE_1.2012 = list(
		sgp.content.areas=c('SCIENCE', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END INTEGRATED_SCIENCE_1.2012_Match.config
