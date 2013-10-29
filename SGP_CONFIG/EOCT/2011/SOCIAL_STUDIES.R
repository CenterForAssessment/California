##################################################################################
###
### Scripts associated with 2011 HISTORY, and EOCT US HISTORY and WORLD HISTORY
###
##################################################################################

### HISTORY

HISTORY_2011.config <- list(
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

US_HISTORY_2011.config <- list(
	US_HISTORY.2011 = list(
		sgp.content.areas=c('ELA', 'US_HISTORY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)# ,		
	# US_HISTORY.2011 = list(  #  Not run originally in 2011.  Not sure if even possible.
		# sgp.content.areas=c('ELA', 'ELA', 'US_HISTORY'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)		
) ### END US_HISTORY_2011.config


### WORLD_HISTORY

WORLD_HISTORY_2011.config <- list(
	WORLD_HISTORY.2011 = list(
		sgp.content.areas=c('ELA', 'WORLD_HISTORY'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)# ,
	# WORLD_HISTORY.2011 = list(  #  Not run originally in 2011.  Not sure if even possible.
		# sgp.content.areas=c('ELA', 'ELA', 'WORLD_HISTORY'),
		# sgp.panel.years=c('2009', '2010', '2011'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1)
) ### END WORLD_HISTORY_2011.config
