#  The content areas that will get SGPs produced:
historys <- c('US_HISTORY', 'WORLD_HISTORY')
maths <- c('GENERAL_MATHEMATICS', 'ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS') 
sciences <- c('SCIENCE', 'LIFE_SCIENCE', 'INTEGRATED_SCIENCE_1', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS') #'EARTH_SCIENCE', 

#  The various prior combinations that will be used:
math.priors <- c('MATHEMATICS__MATHEMATICS__ALGEBRA_I', 'ALGEBRA_I__GEOMETRY__ALGEBRA_II', 'MATHEMATICS__GENERAL_MATHEMATICS',
	'MATHEMATICS__ALGEBRA_I', 'GENERAL_MATHEMATICS__ALGEBRA_I', 'ALGEBRA_I__GEOMETRY', 'GEOMETRY__ALGEBRA_II',  
	'GENERAL_MATHEMATICS','ALGEBRA_I', 'ALGEBRA_II', 'GEOMETRY', 'SUMMATIVE_HS_MATHEMATICS')
ela.priors <- c('ELA__ELA__ELA', 'ELA__ELA', 'ELA')

setwd("Goodness_of_Fit")

#  Use sgp.exact.grade.progression=TRUE for any progression with more than one prior to force it to that progression only.
#  Need to do that so that we set the PRIOR_PREF correctly.

#  Use two types of sgp.config arguments here.  
#  2011 will use the existing coefficient matrices to produce SGPs.  2012 will produce them and SGPs
CA.config.11 <- NULL
CA.config.12 <- NULL

for (prior in c(math.priors, ela.priors)) {
	
	### Make new working directory to save GoFit plots
	tmp.dir <- paste(prior, "_AS_PRIOR", sep="")
	if (is.na(file.info(tmp.dir)$isdir)){
		dir.create(tmp.dir)
	}
	setwd(tmp.dir)

	if (prior == 'MATHEMATICS__MATHEMATICS__ALGEBRA_I')	{
		CA.config.12 <- list(
				GEOMETRY.2012 = list(
					sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
					sgp.exact.grade.progression=TRUE,
					sgp.panel.years=c('2009', '2010', '2011', '2012'),
					sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT'))),

				BIOLOGY.2012 = list(
					sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I", "BIOLOGY"),
					sgp.exact.grade.progression=TRUE,
					sgp.panel.years=c('2009', '2010', '2011', '2012'),
					sgp.grade.sequences=list(c('EOCT', 'EOCT','EOCT', 'EOCT'))))
	}

	if (prior == 'ALGEBRA_I__GEOMETRY__ALGEBRA_II')	{
		CA.config.12 <- list(
				SUMMATIVE_HS_MATHEMATICS.2012 = list(
					sgp.content.areas=c("ALGEBRA_I", "GEOMETRY", "ALGEBRA_II", "SUMMATIVE_HS_MATHEMATICS"),
					sgp.exact.grade.progression=TRUE,
					sgp.panel.years=c('2009', '2010', '2011', '2012'),
					sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT'))),
				PHYSICS.2012 = list(
					sgp.content.areas=c("ALGEBRA_I", "GEOMETRY", "ALGEBRA_II", "PHYSICS"),
					sgp.exact.grade.progression=TRUE,
					sgp.panel.years=c('2009', '2010', '2011', '2012'),
					sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT'))),
				CHEMISTRY.2012 = list(
					sgp.content.areas=c("ALGEBRA_I", "GEOMETRY", "ALGEBRA_II", "CHEMISTRY"),
					sgp.exact.grade.progression=TRUE,
					sgp.panel.years=c('2009', '2010', '2011', '2012'),
					sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT'))))
	}

	if (prior == 'MATHEMATICS__GENERAL_MATHEMATICS')	{
		#  Not enough students for GENERAL_MATHEMATICS repeaters in 2012.  Leave this to 8th grade analysis in typical sets...
		CA.config.12 <- list(
			ALGEBRA_I.2012 = list(
				sgp.content.areas=c("MATHEMATICS", "GENERAL_MATHEMATICS", "ALGEBRA_I"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),

			BIOLOGY.2012 = list(
				sgp.content.areas=c("MATHEMATICS", "GENERAL_MATHEMATICS", "BIOLOGY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))

		CA.config.11 <- list(
			GENERAL_MATHEMATICS.2011 = list(
				sgp.content.areas=c("MATHEMATICS", "GENERAL_MATHEMATICS", "GENERAL_MATHEMATICS"),  # course repeaters
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2009', '2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))
	}

	if (prior == 'MATHEMATICS__ALGEBRA_I')	{
		CA.config.12 <- list(
			GEOMETRY.2012 = list(
				sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),

			SCIENCE.2012 = list(
				sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I", "SCIENCE"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),
			BIOLOGY.2012 = list(
				sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I", "BIOLOGY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))

		CA.config.11 <- list(
			GEOMETRY.2011 = list(
				sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2009', '2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),

			SCIENCE.2011 = list(
				sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I", "SCIENCE"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2009', '2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))
	}
					
	if (prior == 'GENERAL_MATHEMATICS__ALGEBRA_I')	{
		CA.config.12 <- list(
			GEOMETRY.2012 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "ALGEBRA_I", "GEOMETRY"), 
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),
			BIOLOGY.2012 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "ALGEBRA_I", "BIOLOGY"), 
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))

		CA.config.11 <- list(
			GEOMETRY.2011 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "ALGEBRA_I", "GEOMETRY"), 
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2009', '2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))
	}
 
	if (prior == 'ALGEBRA_I__GEOMETRY')	{
		CA.config.12 <- list(
			ALGEBRA_II.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "GEOMETRY", "ALGEBRA_II"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),
			BIOLOGY.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "GEOMETRY", "BIOLOGY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),
			PHYSICS.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "GEOMETRY", "PHYSICS"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "GEOMETRY", "CHEMISTRY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))

		CA.config.11 <- list(
			ALGEBRA_II.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "GEOMETRY", "ALGEBRA_II"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2009', '2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))
	}
	

	if (prior == 'GEOMETRY__ALGEBRA_II')	{
		CA.config.12 <- list(
			SUMMATIVE_HS_MATHEMATICS.2012 = list(
				sgp.content.areas=c("GEOMETRY", "ALGEBRA_II", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),
			PHYSICS.2012 = list(
				sgp.content.areas=c("GEOMETRY", "ALGEBRA_II", "PHYSICS"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("GEOMETRY", "ALGEBRA_II", "CHEMISTRY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))
}

	if (prior == 'GENERAL_MATHEMATICS')	{
		CA.config.12 <- list(
			GENERAL_MATHEMATICS.2012 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "GENERAL_MATHEMATICS"),  # course repeaters
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_I.2012 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "ALGEBRA_I"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))), 
				
			INTEGRATED_SCIENCE_1.2012 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "INTEGRATED_SCIENCE_1"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			BIOLOGY.2012 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "BIOLOGY"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

		CA.config.11 <- list(
			GENERAL_MATHEMATICS.2010 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "GENERAL_MATHEMATICS"),  # course repeaters
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_I.2010 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "ALGEBRA_I"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))), 
				
			BIOLOGY.2010 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "BIOLOGY"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

			GENERAL_MATHEMATICS.2011 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "GENERAL_MATHEMATICS"),  # course repeaters
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_I.2011 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "ALGEBRA_I"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
			BIOLOGY.2011 = list(
				sgp.content.areas=c("GENERAL_MATHEMATICS", "BIOLOGY"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))
	}		

	if (prior == 'ALGEBRA_I')	{
		CA.config.12 <- list(
			ALGEBRA_I.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "ALGEBRA_I"),  # course repeaters
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_II.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "ALGEBRA_II"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			GEOMETRY.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "GEOMETRY"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
			BIOLOGY.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "BIOLOGY"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SCIENCE.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "SCIENCE"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			INTEGRATED_SCIENCE_1.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "INTEGRATED_SCIENCE_1"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			LIFE_SCIENCE.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "LIFE_SCIENCE"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			# EARTH_SCIENCE.2012 = list(
				# sgp.content.areas=c("ALGEBRA_I", "EARTH_SCIENCE"), 
				# sgp.panel.years=c('2011', '2012'),
				# sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			PHYSICS.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "PHYSICS"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("ALGEBRA_I", "CHEMISTRY"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

		CA.config.11 <- list(
			ALGEBRA_I.2010 = list(
				sgp.content.areas=c("ALGEBRA_I", "ALGEBRA_I"),  # course repeaters
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_II.2010 = list(
				sgp.content.areas=c("ALGEBRA_I", "ALGEBRA_II"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			GEOMETRY.2010 = list(
				sgp.content.areas=c("ALGEBRA_I", "GEOMETRY"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
			BIOLOGY.2010 = list(
				sgp.content.areas=c("ALGEBRA_I", "BIOLOGY"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SCIENCE.2010 = list(
				sgp.content.areas=c("ALGEBRA_I", "SCIENCE"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			INTEGRATED_SCIENCE_1.2010 = list(
				sgp.content.areas=c("ALGEBRA_I", "INTEGRATED_SCIENCE_1"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			LIFE_SCIENCE.2010 = list(
				sgp.content.areas=c("ALGEBRA_I", "LIFE_SCIENCE"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			PHYSICS.2010 = list(
				sgp.content.areas=c("ALGEBRA_I", "PHYSICS"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			CHEMISTRY.2010 = list(
				sgp.content.areas=c("ALGEBRA_I", "CHEMISTRY"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
				
			ALGEBRA_I.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "ALGEBRA_I"),  # course repeaters
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_II.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "ALGEBRA_II"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			GEOMETRY.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "GEOMETRY"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
			BIOLOGY.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "BIOLOGY"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SCIENCE.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "SCIENCE"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),                                     
			INTEGRATED_SCIENCE_1.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "INTEGRATED_SCIENCE_1"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			LIFE_SCIENCE.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "LIFE_SCIENCE"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			PHYSICS.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "PHYSICS"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			CHEMISTRY.2011 = list(
				sgp.content.areas=c("ALGEBRA_I", "CHEMISTRY"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))
	}


	if (prior == 'GEOMETRY')	{
		CA.config.12 <- list(
			ALGEBRA_I.2012 = list(
				sgp.content.areas=c("GEOMETRY", "ALGEBRA_I"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			GEOMETRY.2012 = list(
				sgp.content.areas=c("GEOMETRY", "GEOMETRY"), # course repeaters
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_II.2012 = list(
				sgp.content.areas=c("GEOMETRY", "ALGEBRA_II"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SUMMATIVE_HS_MATHEMATICS.2012 = list(
				sgp.content.areas=c("GEOMETRY", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
			BIOLOGY.2012 = list(
				sgp.content.areas=c("GEOMETRY", "BIOLOGY"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			# EARTH_SCIENCE.2012 = list(
				# sgp.content.areas=c("GEOMETRY", "EARTH_SCIENCE"), #  First time try +1000
				# sgp.panel.years=c('2011', '2012'),
				# sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			# INTEGRATED_SCIENCE_1.2012 = list(   							#  First time try +1000
				# sgp.content.areas=c("GEOMETRY", "INTEGRATED_SCIENCE_1"), 
				# sgp.panel.years=c('2011', '2012'),
				# sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			PHYSICS.2012 = list(
				sgp.content.areas=c("GEOMETRY", "PHYSICS"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("GEOMETRY", "CHEMISTRY"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

		CA.config.11 <- list(
			ALGEBRA_I.2010 = list(
				sgp.content.areas=c("GEOMETRY", "ALGEBRA_I"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),				
			GEOMETRY.2010 = list(
				sgp.content.areas=c("GEOMETRY", "GEOMETRY"),  # course repeaters
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_II.2010 = list(
				sgp.content.areas=c("GEOMETRY", "ALGEBRA_II"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SUMMATIVE_HS_MATHEMATICS.2010 = list(
				sgp.content.areas=c("GEOMETRY", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
			BIOLOGY.2010 = list(
				sgp.content.areas=c("GEOMETRY", "BIOLOGY"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			PHYSICS.2010 = list(
				sgp.content.areas=c("GEOMETRY", "PHYSICS"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			CHEMISTRY.2010 = list(
				sgp.content.areas=c("GEOMETRY", "CHEMISTRY"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),


			ALGEBRA_I.2011 = list(
				sgp.content.areas=c("GEOMETRY", "ALGEBRA_I"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			GEOMETRY.2011 = list(
				sgp.content.areas=c("GEOMETRY", "GEOMETRY"),  # course repeaters
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_II.2011 = list(
				sgp.content.areas=c("GEOMETRY", "ALGEBRA_II"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SUMMATIVE_HS_MATHEMATICS.2011 = list(
				sgp.content.areas=c("GEOMETRY", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
			BIOLOGY.2011 = list(
				sgp.content.areas=c("GEOMETRY", "BIOLOGY"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			PHYSICS.2011 = list(
				sgp.content.areas=c("GEOMETRY", "PHYSICS"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			CHEMISTRY.2011 = list(
				sgp.content.areas=c("GEOMETRY", "CHEMISTRY"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))
	}
					

	if (prior == 'ALGEBRA_II')	{
		CA.config.12 <- list(
			GEOMETRY.2012 = list(
				sgp.content.areas=c("ALGEBRA_II", "GEOMETRY"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_II.2012 = list(
				sgp.content.areas=c("ALGEBRA_II", "ALGEBRA_II"),  # course repeaters
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SUMMATIVE_HS_MATHEMATICS.2012 = list(
				sgp.content.areas=c("ALGEBRA_II", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
			BIOLOGY.2012 = list(
				sgp.content.areas=c("ALGEBRA_II", "BIOLOGY"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			PHYSICS.2012 = list(
				sgp.content.areas=c("ALGEBRA_II", "PHYSICS"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			CHEMISTRY.2012 = list(
				sgp.content.areas=c("ALGEBRA_II", "CHEMISTRY"), 
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

		CA.config.11 <- list(
			GEOMETRY.2010 = list(
				sgp.content.areas=c("ALGEBRA_II", "GEOMETRY"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			ALGEBRA_II.2010 = list(
				sgp.content.areas=c("ALGEBRA_II", "ALGEBRA_II"),  # course repeaters
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SUMMATIVE_HS_MATHEMATICS.2010 = list(
				sgp.content.areas=c("ALGEBRA_II", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),				

			BIOLOGY.2010 = list(
				sgp.content.areas=c("ALGEBRA_II", "BIOLOGY"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			PHYSICS.2010 = list(
				sgp.content.areas=c("ALGEBRA_II", "PHYSICS"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			CHEMISTRY.2010 = list(
				sgp.content.areas=c("ALGEBRA_II", "CHEMISTRY"), 
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
				
			GEOMETRY.2011 = list(
				sgp.content.areas=c("ALGEBRA_II", "GEOMETRY"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),					
			ALGEBRA_II.2011 = list(
				sgp.content.areas=c("ALGEBRA_II", "ALGEBRA_II"),  # course repeaters
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SUMMATIVE_HS_MATHEMATICS.2011 = list(
				sgp.content.areas=c("ALGEBRA_II", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
				
			BIOLOGY.2011 = list(
				sgp.content.areas=c("ALGEBRA_II", "BIOLOGY"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			PHYSICS.2011 = list(
				sgp.content.areas=c("ALGEBRA_II", "PHYSICS"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			CHEMISTRY.2011 = list(
				sgp.content.areas=c("ALGEBRA_II", "CHEMISTRY"), 
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))
	}
					
					
	if (prior == 'SUMMATIVE_HS_MATHEMATICS')	{
		CA.config.12 <- list(
			SUMMATIVE_HS_MATHEMATICS.2012 = list(
				sgp.content.areas=c("SUMMATIVE_HS_MATHEMATICS", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

		CA.config.11 <- list(
			SUMMATIVE_HS_MATHEMATICS.2010 = list(
				sgp.content.areas=c("SUMMATIVE_HS_MATHEMATICS", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			SUMMATIVE_HS_MATHEMATICS.2011 = list(
				sgp.content.areas=c("SUMMATIVE_HS_MATHEMATICS", "SUMMATIVE_HS_MATHEMATICS"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))
	}
	
###
### Sciences
###

###  REMOVED 6/26/12

###
###  History
###

	if (prior == 'ELA__ELA__ELA')	{
		CA.config.12 <- list(
			WORLD_HISTORY.2012 = list(
				sgp.content.areas=c("ELA", "ELA", "ELA", "WORLD_HISTORY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2009', '2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT'))),
			US_HISTORY.2012 = list(
				sgp.content.areas=c("ELA", "ELA", "ELA", "US_HISTORY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2009', '2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT'))))
	}


	if (prior == 'ELA__ELA')	{ #  Didn't do 2 ELA prior for 2011 last year ???
		CA.config.12 <- list(
			WORLD_HISTORY.2012 = list(
				sgp.content.areas=c("ELA", "ELA", "WORLD_HISTORY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))),
			US_HISTORY.2012 = list(
				sgp.content.areas=c("ELA", "ELA", "US_HISTORY"),
				sgp.exact.grade.progression=TRUE,
				sgp.panel.years=c('2010', '2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT'))))
	}	

	if (prior == 'ELA')	{
		CA.config.12 <- list(
			WORLD_HISTORY.2012 = list(
				sgp.content.areas=c("ELA", "WORLD_HISTORY"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			US_HISTORY.2012 = list(
				sgp.content.areas=c("ELA", "US_HISTORY"),
				sgp.panel.years=c('2011', '2012'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

		CA.config.11 <- list(
			WORLD_HISTORY.2010 = list(	
				sgp.content.areas=c("ELA", "WORLD_HISTORY"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			US_HISTORY.2010 = list(
				sgp.content.areas=c("ELA", "US_HISTORY"),
				sgp.panel.years=c('2009', '2010'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			WORLD_HISTORY.2011 = list(
				sgp.content.areas=c("ELA", "WORLD_HISTORY"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
			US_HISTORY.2011 = list(
				sgp.content.areas=c("ELA", "US_HISTORY"),
				sgp.panel.years=c('2010', '2011'),
				sgp.grade.sequences=list(c('EOCT', 'EOCT'))))
	}


######################################################################################################
######################################################################################################

	message(paste("\n\n", prior, "used as PRIOR\n"))

	#  Establish prior preference based on number of priors.
	if (length(strsplit(prior, "__")[[1]])==3) {
		prior.pref <- 1
	} 
	if (length(strsplit(prior, "__")[[1]])==2) {
		prior.pref <- 2
	} 
	if (length(strsplit(prior, "__")[[1]])==1) {
		prior.pref <- 3
	}
	
	if (!is.null(CA.config.11)) { 
		California_SGP <-analyzeSGP(California_SGP, 
                                    state="CA",
                                    sgp.config=CA.config.11,
                                    sgp.projections=FALSE,
                                    sgp.projections.lagged=FALSE,
                                    sgp.percentiles.baseline= FALSE,
                                    sgp.projections.baseline= FALSE,
                                    sgp.projections.lagged.baseline=FALSE,
                                    simulate.sgps=FALSE,
                                    sgp.use.my.coefficient.matrices=TRUE,
                                    parallel.config=list(
                                       BACKEND="PARALLEL",
                                       WORKERS=list(PERCENTILES=length(CA.config.11))))
    }
    
	if (!is.null(CA.config.12)) { 
        California_SGP <-analyzeSGP(California_SGP, 
                                    state="CA",
                                    sgp.config=CA.config.12,
                                    sgp.projections=FALSE,
                                    sgp.projections.lagged=FALSE,
                                    sgp.percentiles.baseline= FALSE,
                                    sgp.projections.baseline= FALSE,
                                    sgp.projections.lagged.baseline=FALSE,
                                    simulate.sgps=FALSE,
                                    parallel.config=list(
                                       BACKEND="PARALLEL",
                                       WORKERS=list(PERCENTILES=length(CA.config.12))))
	}
	
	setwd("../")

	Goodness_of_Fit[["BY_PRIOR"]][[prior]] <- California_SGP@SGP[["Goodness_of_Fit"]]
	Knots_Boundaries[["BY_PRIOR"]][[prior]] <- California_SGP@SGP[["Knots_Boundaries"]]

	California_SGP@SGP[["Goodness_of_Fit"]] <- NULL
	California_SGP@SGP[["Knots_Boundaries"]] <- NULL

	if (prior %in% math.priors) {
		for (i in maths) {
			for (y in c('2010', '2011', '2012')) {
				tmp.subj<-paste(i, y, sep=".") 
				if (tmp.subj %in% names(California_SGP@SGP[["SGPercentiles"]])) {
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_TYPE']] <- 1
					California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_PREF']] <- prior.pref
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['SGP_PRIORS_USED']] <- prior
					SGPercentiles[[tmp.subj]] <- rbind.fill(SGPercentiles[[tmp.subj]], California_SGP@SGP[["SGPercentiles"]][[tmp.subj]])
				}
			}
		}
		for (i in c(sciences)) {
			for (y in c('2010', '2011', '2012')) {
				tmp.subj<-paste(i, y, sep=".") 
				if (tmp.subj %in% names(California_SGP@SGP[["SGPercentiles"]])) {
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_TYPE']] <- 2
					California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_PREF']] <- prior.pref
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['SGP_PRIORS_USED']] <- prior
					SGPercentiles[[tmp.subj]] <- rbind.fill(SGPercentiles[[tmp.subj]], California_SGP@SGP[["SGPercentiles"]][[tmp.subj]])
				}
			}
		}
	}

	if (prior %in% ela.priors) {
		# if (prior == "ELA") prior.type <- 2 else prior.type <- 1
		for (i in historys) {
			for (y in c('2010', '2011', '2012')) {
				tmp.subj<-paste(i, y, sep=".") 
				if (tmp.subj %in% names(California_SGP@SGP[["SGPercentiles"]])) {
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_TYPE']] <- 2
					California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['PRIOR_PREF']] <- prior.pref
					# California_SGP@SGP[["SGPercentiles"]][[tmp.subj]][['SGP_PRIORS_USED']] <- prior
					SGPercentiles[[tmp.subj]] <- rbind.fill(SGPercentiles[[tmp.subj]], California_SGP@SGP[["SGPercentiles"]][[tmp.subj]])
				}
			}
		}
	}

	California_SGP@SGP[["SGPercentiles"]] <- NULL
	CA.config.11 <- NULL
	CA.config.12 <- NULL

} # END for (prior in xxx)

	setwd("../")
