#############################################################################
###
###		Scripts associated with 2011 EOCT SCIENCE: Science, Biology,
###		   Chemistry, Physics, Life Science and Integrated Science 1
###
#############################################################################

SCIENCE_2010.config <- list(
	 SCIENCE.2010 = list(
		sgp.content.areas=c('MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(4:5),
		sgp.norm.group.preference=1),

	 SCIENCE.2010 = list(
		sgp.content.areas=c('MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(7:8),
		sgp.norm.group.preference=1),

	SCIENCE.2010 = list(
		sgp.content.areas=c('ALGEBRA_I', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 8)),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)

### BIOLOGY

BIOLOGY_2010.config <- list(
	BIOLOGY.2010 = list(
		sgp.content.areas=c('ALGEBRA_I', 'BIOLOGY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
		
	BIOLOGY.2010 = list(
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'BIOLOGY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
		
	BIOLOGY.2010 = list(
		sgp.content.areas=c('GEOMETRY', 'BIOLOGY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	BIOLOGY.2010 = list(
		sgp.content.areas=c('ALGEBRA_II', 'BIOLOGY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END BIOLOGY_2010.config


### PHYSICS

PHYSICS_2010.config <- list(
	PHYSICS.2010 = list(
		sgp.content.areas=c('ALGEBRA_I', 'PHYSICS'), 
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	PHYSICS.2010 = list(
		sgp.content.areas=c('GEOMETRY', 'PHYSICS'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	PHYSICS.2010 = list(
		sgp.content.areas=c('ALGEBRA_II', 'PHYSICS'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END PHYSICS_2010.config



CHEMISTRY_2010.config <- list(
	CHEMISTRY.2010 = list(
		sgp.content.areas=c('ALGEBRA_I', 'CHEMISTRY'), 
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	
	CHEMISTRY.2010 = list(
		sgp.content.areas=c('GEOMETRY', 'CHEMISTRY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	CHEMISTRY.2010 = list(
		sgp.content.areas=c('ALGEBRA_II', 'CHEMISTRY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END CHEMISTRY_2010.config

LIFE_SCIENCE_2010.config <- list(
	LIFE_SCIENCE.2010 = list(
		sgp.content.areas=c('ALGEBRA_I', 'LIFE_SCIENCE'), 
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END LIFE_SCIENCE_2010.config


INTEGRATED_SCIENCE_1.2010.config <- list(
	INTEGRATED_SCIENCE_1.2010 = list(
		sgp.content.areas=c('ALGEBRA_I', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)#,
	# INTEGRATED_SCIENCE_1.2010 = list(
		# sgp.content.areas=c('GENERAL_MATHEMATICS', 'INTEGRATED_SCIENCE_1'), 
		# sgp.panel.years=c('2009', '2010'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)
) ### END INTEGRATED_SCIENCE_1.2010.config
