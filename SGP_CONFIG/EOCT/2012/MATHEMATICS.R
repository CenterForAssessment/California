#####################################################################################
###
### 	Scripts associated with 2012 EOCT MATHEMATICS: ALGEBRA_I,   
###			GENERAL_MATHEMATICS, GEOMETRY, ALGEBRA_II, and SUMMATIVE_HS_MATHEMATICS
###
#####################################################################################

### Grade-Level EOCT Courses

ALGEBRA_I_MS_2012.config <- list(
	 ALGEBRA_I.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c(6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 ALGEBRA_I.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c(5:6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 ALGEBRA_I.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(c(4:6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	 ALGEBRA_I.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c(7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 ALGEBRA_I.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c(6:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 ALGEBRA_I.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(c(5:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)

GENERAL_MATHEMATICS_MS_2012.config <- list(
	 GENERAL_MATHEMATICS.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c(7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 GENERAL_MATHEMATICS.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'GENERAL_MATHEMATICS'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c(6:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 GENERAL_MATHEMATICS.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'GENERAL_MATHEMATICS'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(c(5:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)


### ALL EOCT Courses

ALGEBRA_I_2012.config <- list(
	ALGEBRA_I.2012 = list( 
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	ALGEBRA_I.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	# ALGEBRA_I.2012 = list( #  Only 7 grade possible here - Gen Math in 8th and 9th grade only.
		# sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'ALGEBRA_I'),
		# sgp.panel.years=c('2010', '2011', '2012'),
		# sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),

	ALGEBRA_I.2012 = list( 
		sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_I'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) # ALGEBRA_I_2012.config


GENERAL_MATHEMATICS_2012.config <- list(
	GENERAL_MATHEMATICS.2012 = list( # Gen Math in 8th and 9th grade, so not really repeaters.
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'GENERAL_MATHEMATICS'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)#,

	# GENERAL_MATHEMATICS.2012 = list( # Didn't run this in 2012
		# sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'GENERAL_MATHEMATICS'),
		# sgp.panel.years=c('2010', '2011', '2012'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)
)
		
		
GEOMETRY_2012.config <- list(
	GEOMETRY.2012 = list(
		sgp.content.areas=c('ALGEBRA_II', 'GEOMETRY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),

	GEOMETRY.2012 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'), # contains 'supercohort' of kids with 2010 Gen Math & Grade level Math
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),

	GEOMETRY.2012 = list(
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'), 
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

	GEOMETRY.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	GEOMETRY.2012 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	# GEOMETRY.2012 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
		# sgp.panel.years=c('2010', '2011', '2012'),
		# sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# GEOMETRY.2012 = list(
		# sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
		# sgp.panel.years=c('2009', '2010', '2011', '2012'),
		# sgp.grade.sequences=list(c(5, 6, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
	# GEOMETRY.2012 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
		# sgp.panel.years=c('2010', '2011', '2012'),
		# sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# GEOMETRY.2012 = list(
		# sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
		# sgp.panel.years=c('2009', '2010', '2011', '2012'),
		# sgp.grade.sequences=list(c(6, 7, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	GEOMETRY.2012 = list(
		sgp.content.areas=c('GEOMETRY', 'GEOMETRY'), #  course repeaters
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
)

ALGEBRA_II_2012.config <- list(
	ALGEBRA_II.2012 = list(
		sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_II'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),

	ALGEBRA_II.2012 = list(
		sgp.content.areas=c('GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	ALGEBRA_II.2012 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

	ALGEBRA_II.2012 = list(
		sgp.content.areas=c('ALGEBRA_II', 'ALGEBRA_II'),  # course repeaters
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
)


SUMMATIVE_HS_MATHEMATICS_2012.config <- list(
	SUMMATIVE_HS_MATHEMATICS.2012 = list(
		sgp.content.areas=c('GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),

	SUMMATIVE_HS_MATHEMATICS.2012 = list(
		sgp.content.areas=c('ALGEBRA_II', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	SUMMATIVE_HS_MATHEMATICS.2012 = list(
		sgp.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	SUMMATIVE_HS_MATHEMATICS.2012 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	SUMMATIVE_HS_MATHEMATICS.2012 = list(
		sgp.content.areas=c('SUMMATIVE_HS_MATHEMATICS', 'SUMMATIVE_HS_MATHEMATICS'),  # course repeaters
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END EOCT SUMMATIVE_HS_MATHEMATICS_2012.config
