#####################################################################################
###
###		Scripts associated with 2011 HISTORY, and EOCT US HISTORY and WORLD HISTORY
###
#####################################################################################

### HISTORY - same as the Math/ELA config script

HISTORY_2011_Match.config <- list(
	 HISTORY.2011 = list(
		sgp.content.areas=c('ELA', 'HISTORY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(7:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 HISTORY.2011 = list(
		sgp.content.areas=c('ELA', 'ELA', 'HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011'),
		sgp.grade.sequences=list(6:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)

### US HISTORY

US_HISTORY_2011_Match.config <- list(
	# US_HISTORY.2011 = list( # 1 Year Skip
		# sgp.content.areas=c('WORLD_HISTORY', 'US_HISTORY'),
		# sgp.panel.years=c('2009', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),		
	US_HISTORY.2011 = list(
		sgp.content.areas=c('WORLD_HISTORY', 'US_HISTORY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)# ,		
	# US_HISTORY.2011 = list(
		# sgp.content.areas=c('HISTORY', 'WORLD_HISTORY', 'US_HISTORY'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)
) ### END US_HISTORY_2011_Match.config


### WORLD_HISTORY

WORLD_HISTORY_2011_Match.config <- list(
	# WORLD_HISTORY.2011 = list(  #  1 year skip   #  Didn't do this in 2011
		# sgp.content.areas=c('HISTORY', 'WORLD_HISTORY'),
		# sgp.panel.years=c('2009', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# WORLD_HISTORY.2011 = list(  #  Didn't do this in 2011
		# sgp.content.areas=c('HISTORY', 'WORLD_HISTORY'),
		# sgp.panel.years=c('2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),

	###  Not a matched prior, but what would have been included in 2011
	###  Need to remove duplicate from the TCRP_SGP_Norm_Group_Preference.
	WORLD_HISTORY.2011 = list(
		sgp.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

	WORLD_HISTORY.2011 = list(  #  1 year skip with ELA
		sgp.content.areas=c('HISTORY', 'ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	WORLD_HISTORY.2011 = list( # Repeaters
		sgp.content.areas=c('WORLD_HISTORY', 'WORLD_HISTORY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END WORLD_HISTORY_2011_Match.config
