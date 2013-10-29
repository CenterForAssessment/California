#####################################################################################
###
###		Scripts associated with 2012 HISTORY, and EOCT US HISTORY and WORLD HISTORY
###
#####################################################################################

### HISTORY - same as the Math/ELA config script

HISTORY_2012_Match.config <- list(
	 HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'HISTORY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(7:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	 HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'ELA', 'HISTORY'),
		sgp.panel.years=c('2010', '2011', '2012'),
		sgp.grade.sequences=list(6:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	 HISTORY.2012 = list(
		sgp.content.areas=c('ELA', 'ELA', 'ELA', 'HISTORY'),
		sgp.panel.years=c('2009', '2010', '2011', '2012'),
		sgp.grade.sequences=list(5:8),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)

### US HISTORY

US_HISTORY_2012_Match.config <- list(
	US_HISTORY.2012 = list( # 2 year skip to history
		sgp.content.areas=c('HISTORY', 'US_HISTORY'),
		sgp.panel.years=c('2009', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),		
	# US_HISTORY.2012 = list( # 1 Year Skip
		# sgp.content.areas=c('WORLD_HISTORY', 'US_HISTORY'),
		# sgp.panel.years=c('2010', '2012'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=4),		
	US_HISTORY.2012 = list(
		sgp.content.areas=c('WORLD_HISTORY', 'US_HISTORY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),		
	US_HISTORY.2012 = list(
		sgp.content.areas=c('HISTORY', 'WORLD_HISTORY', 'US_HISTORY'),
		sgp.panel.years=c('2009', '2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
) ### END US_HISTORY_2012_Match.config


### WORLD_HISTORY

WORLD_HISTORY_2012_Match.config <- list(
	WORLD_HISTORY.2012 = list(  #  1 year skip
		sgp.content.areas=c('HISTORY', 'WORLD_HISTORY'),
		sgp.panel.years=c('2010', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	WORLD_HISTORY.2012 = list( # Repeaters
		sgp.content.areas=c('WORLD_HISTORY', 'WORLD_HISTORY'),
		sgp.panel.years=c('2011', '2012'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END WORLD_HISTORY_2012_Match.config
