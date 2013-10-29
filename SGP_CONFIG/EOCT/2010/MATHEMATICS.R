#####################################################################################
###
### 	Scripts associated with 2010 EOCT MATHEMATICS: ALGEBRA_I,   
###			GENERAL_MATHEMATICS,GEOMETRY, ALGEBRA_II, SUMMATIVE_HS_MATHEMATICS
###
#####################################################################################

### Mathematics EOCT Courses

ALGEBRA_I_MS_2010.config <- list(
	 ALGEBRA_I.2010 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c(6, 'EOCT')),
		sgp.norm.group.preference=1),

	 ALGEBRA_I.2010 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c(7, 'EOCT')),
		sgp.norm.group.preference=1)
)

ALGEBRA_I_2010.config <- list(
	ALGEBRA_I.2010 = list( 
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	ALGEBRA_I.2010 = list( 
		sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_I'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) # ALGEBRA_I_2010.config


GENERAL_MATHEMATICS_MS_2010.config <- list(
	 GENERAL_MATHEMATICS.2010 = list(
		sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c(7, 'EOCT')),
		sgp.norm.group.preference=1)
)

GENERAL_MATHEMATICS_2010.config <- list(
	GENERAL_MATHEMATICS.2010 = list( # course repeaters
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'GENERAL_MATHEMATICS'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
)
		
		
GEOMETRY_2010.config <- list(
	GEOMETRY.2010 = list(
		sgp.content.areas=c('ALGEBRA_II', 'GEOMETRY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	GEOMETRY.2010 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	GEOMETRY.2010 = list(
		sgp.content.areas=c('GEOMETRY', 'GEOMETRY'), #  course repeaters
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
)

ALGEBRA_II_2010.config <- list(
	ALGEBRA_II.2010 = list(
		sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_II'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	ALGEBRA_II.2010 = list(
		sgp.content.areas=c('GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	ALGEBRA_II.2010 = list(
		sgp.content.areas=c('ALGEBRA_II', 'ALGEBRA_II'),  # course repeaters
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
)


SUMMATIVE_HS_MATHEMATICS_2010.config <- list(
	SUMMATIVE_HS_MATHEMATICS.2010 = list(
		sgp.content.areas=c('GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	SUMMATIVE_HS_MATHEMATICS.2010 = list(
		sgp.content.areas=c('ALGEBRA_II', 'SUMMATIVE_HS_MATHEMATICS'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	SUMMATIVE_HS_MATHEMATICS.2010 = list(
		sgp.content.areas=c('SUMMATIVE_HS_MATHEMATICS', 'SUMMATIVE_HS_MATHEMATICS'),  # course repeaters
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END EOCT SUMMATIVE_HS_MATHEMATICS_2010.config
