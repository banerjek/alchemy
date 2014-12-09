#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Entity Extraction
# Author: Orchestr8, LLC
# Copyright (C) 2009-2010, Orchestr8, LLC.
#
############################################################################
 
use strict;
use AlchemyAPI;
use CAM::PDF;
use LWP::Simple;

# Create the AlchemyAPI object.
my $alchemyObj = new AlchemyAPI();

# Load the API key from disk.
if ($alchemyObj->LoadKey("api_key.txt") eq "error")
{
	die "Error loading API key.  Edit api_key.txt and insert your API key.";
}


my $result = '';
my $doc = '';
my $url = '';
my $pdf = '';
my $filename = 'temp.pdf';


my $entityParams = new AlchemyAPI_EntityParams();
$entityParams->SetDisambiguate(0);
$entityParams->SetLinkedData(0);
$entityParams->SetOutputMode('xml');

$url = 'http://digitalcommons.ohsu.edu/cgi/viewcontent.cgi?article=1020&context=hca-oralhist'; # textual
#$url = 'http://digitalcommons.ohsu.edu/cgi/viewcontent.cgi?article=2108&context=etd'; # image pdf 

my $content = get($url);
die "Couldn't download page" unless defined $content;

open(PDFFILE, '>', $filename);
print PDFFILE $content;
close PDFFILE;

$pdf = CAM::PDF->new($filename);

for (my $i=1; $i <= $pdf->numPages(); $i++) {
	$doc = $doc.$pdf->getPageText($i);
	}

#get rid of junk
$doc =~ s/[^!-~\s]//g; 
# get rid of repeated whitespace
$doc =~ s/([ \n\r])+/$1/gi; 

#$pdf = PDF::OCR2->new($filename);
#$PDF::OCR2::CHECK_PDF   = 0;
#$PDF::OCR2::REPAIR_XREF = 1;
#$doc = $pdf->text;

# Get a ranked list of named entities for a web URL.
#$result = $alchemyObj->URLGetRawText("http://nwda.orbiscascade.org/ark:/80444/xv08340");
#$result = $alchemyObj->URLGetRankedNamedEntities("http://nwda.orbiscascade.org/ark:/80444/xv08340", $entityParams);
#$result = $alchemyObj->URLGetRankedNamedEntities("http://digitalcommons.ohsu.edu/fdadrug/", $entityParams);
$result = $alchemyObj->TextGetRankedNamedEntities($doc, $entityParams);

if ($result ne "error")
{
	printf $result;
}


