use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile
(
	($] ge '5.005') ?
	(
		'AUTHOR' => 'Ron Savage (rpsavage@ozemail.com.au)',
		'ABSTRACT' => 'A simple-to-use interface to Getopt::Long',
    ) : (),
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
