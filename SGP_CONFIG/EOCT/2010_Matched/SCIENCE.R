#############################################################################
###
###		Scripts associated with 2010 EOCT SCIENCE: Science, Biology,
###		   Chemistry, Physics, Life Science and Integrated Science 1
###
#############################################################################

### SCIENCE - same as the Math/ELA config script

SCIENCE_2010_Match.config <- list(
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

BIOLOGY_2010_Match.config <- list(
	BIOLOGY.2010 = list(
		sgp.content.areas=c('SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	
	BIOLOGY.2010 = list(
		sgp.content.areas=c('INTEGRATED_SCIENCE_1', 'BIOLOGY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	# BIOLOGY.2010 = list(
		# sgp.content.areas=c('CHEMISTRY', 'BIOLOGY'),
		# sgp.panel.years=c('2009', '2010'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	# BIOLOGY.2010 = list(
		# sgp.content.areas=c('PHYSICS', 'BIOLOGY'),
		# sgp.panel.years=c('2009', '2010'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	BIOLOGY.2010 = list(
		sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END BIOLOGY_2010_Match.config


CHEMISTRY_2010_Match.config <- list(
	CHEMISTRY.2010 = list(
		sgp.content.areas=c('BIOLOGY', 'CHEMISTRY'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)# ,
		
	# CHEMISTRY.2010 = list(
		# sgp.content.areas=c('LIFE_SCIENCE', 'CHEMISTRY'),
		# sgp.panel.years=c('2009', '2010'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	# CHEMISTRY.2010 = list(
		# sgp.content.areas=c('CHEMISTRY', 'CHEMISTRY'),
		# sgp.panel.years=c('2009', '2010'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=0)
) ### END CHEMISTRY_2010_Match.config

### PHYSICS

PHYSICS_2010_Match.config <- list(
	PHYSICS.2010 = list(
		sgp.content.areas=c('CHEMISTRY', 'PHYSICS'),
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)# ,

	# PHYSICS.2010 = list(
		# sgp.content.areas=c('BIOLOGY', 'PHYSICS'),
		# sgp.panel.years=c('2009', '2010'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)

	##  Not enough kids for repeaters
	
) ### END PHYSICS_2010_Match.config


LIFE_SCIENCE_2010_Match.config <- list(
	LIFE_SCIENCE.2010 = list(
		sgp.content.areas=c('BIOLOGY', 'LIFE_SCIENCE'), 
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END LIFE_SCIENCE_2010_Match.config


INTEGRATED_SCIENCE_1.2010_Match.config <- list(
	INTEGRATED_SCIENCE_1.2010 = list(
		sgp.content.areas=c('SCIENCE', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2009', '2010'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END INTEGRATED_SCIENCE_1.2010_Match.config
