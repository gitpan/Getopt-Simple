use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile
(
'clean'				=>
	{
	'FILES'			=> 'blib/* Makefile MANIFEST Getopt-Simple-*'
	},
'dist'				=>
	{
	'COMPRESS'		=> 'gzip',
	'SUFFIX'		=> 'gz'
	},
'DISTNAME'			=> 'Getopt-Simple',
'NAME'				=> 'Getopt::Simple',
'PM'				=>
	{
	'Simple.pm' 	=> '$(INST_LIBDIR)/Simple.pm',
	},
'PREREQ_PM'			=> {},
'VERSION_FROM'		=> 'Simple.pm'
);
