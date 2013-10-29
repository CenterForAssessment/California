#############################################################################
###
###		Scripts associated with 2011 EOCT SCIENCE: Science, Biology,
###		   Chemistry, Physics, Life Science and Integrated Science 1
###
#############################################################################

SCIENCE_2011.config <- list(
	 SCIENCE.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(4:5),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 SCIENCE.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010', '2011'),
		sgp.grade.sequences=list(3:5),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	 SCIENCE.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(7:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 SCIENCE.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010', '2011'),
		sgp.grade.sequences=list(6:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	SCIENCE.2011 = list(
		sgp.content.areas=c('ALGEBRA_I', 'SCIENCE'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 8)),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	SCIENCE.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'SCIENCE'),
		sgp.panel.years=c('2009', '2010', '2011'),
		sgp.grade.sequences=list(c(6, 'EOCT', 8)),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)

### BIOLOGY

BIOLOGY_2011.config <- list(
	BIOLOGY.2011 = list(
		sgp.content.areas=c('ALGEBRA_I', 'BIOLOGY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	# BIOLOGY.2011 = list(  #  Not run originally in 2011.  Not sure if even possible.
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c(6,'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
	# BIOLOGY.2011 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c(7,'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
		
	BIOLOGY.2011 = list(
		sgp.content.areas=c('GENERAL_MATHEMATICS', 'BIOLOGY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	# BIOLOGY.2011 = list(  #  Not run originally in 2011.  Not sure if even possible.
		# sgp.content.areas=c('MATHEMATICS', 'GENERAL_MATHEMATICS', 'BIOLOGY'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
		
	# BIOLOGY.2011 = list(
		# sgp.content.areas=c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'BIOLOGY'), 
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	BIOLOGY.2011 = list(
		sgp.content.areas=c('GEOMETRY', 'BIOLOGY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	# BIOLOGY.2011 = list(  #  Not run originally in 2011.  Not sure if even possible.
		# sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'BIOLOGY'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	BIOLOGY.2011 = list(
		sgp.content.areas=c('ALGEBRA_II', 'BIOLOGY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)
) ### END BIOLOGY_2011.config


### PHYSICS

PHYSICS_2011.config <- list(
	PHYSICS.2011 = list(
		sgp.content.areas=c('ALGEBRA_I', 'PHYSICS'), 
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

	PHYSICS.2011 = list(
		sgp.content.areas=c('GEOMETRY', 'PHYSICS'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	# PHYSICS.2011 = list(  #  Not run originally in 2011.  Not sure if even possible.
		# sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'PHYSICS'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	PHYSICS.2011 = list(
		sgp.content.areas=c('ALGEBRA_II', 'PHYSICS'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)# ,
	# PHYSICS.2011 = list(  #  Not run originally in 2011.  Not sure if even possible.
		# sgp.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'PHYSICS'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)
) ### END PHYSICS_2011.config



CHEMISTRY_2011.config <- list(
	CHEMISTRY.2011 = list(
		sgp.content.areas=c('ALGEBRA_I', 'CHEMISTRY'), 
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	
	CHEMISTRY.2011 = list(
		sgp.content.areas=c('GEOMETRY', 'CHEMISTRY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	# CHEMISTRY.2011 = list(  #  Not run originally in 2011.  Not sure if even possible.
		# sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'CHEMISTRY'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	CHEMISTRY.2011 = list(
		sgp.content.areas=c('ALGEBRA_II', 'CHEMISTRY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)# ,
	# CHEMISTRY.2011 = list(  #  Not run originally in 2011.  Not sure if even possible.
		# sgp.content.areas=c('GEOMETRY', 'ALGEBRA_II', 'CHEMISTRY'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)
) ### END CHEMISTRY_2011.config

LIFE_SCIENCE_2011.config <- list(
	LIFE_SCIENCE.2011 = list(
		sgp.content.areas=c('ALGEBRA_I', 'LIFE_SCIENCE'), 
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)
) ### END LIFE_SCIENCE_2011.config


INTEGRATED_SCIENCE_1.2011.config <- list(
	INTEGRATED_SCIENCE_1.2011 = list(
		sgp.content.areas=c('ALGEBRA_I', 'INTEGRATED_SCIENCE_1'), 
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)#,
	# INTEGRATED_SCIENCE_1.2011 = list(
		# sgp.content.areas=c('GENERAL_MATHEMATICS', 'INTEGRATED_SCIENCE_1'), 
		# sgp.panel.years=c('2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2)
) ### END INTEGRATED_SCIENCE_1.2011.config
