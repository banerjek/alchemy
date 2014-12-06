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

# Create the AlchemyAPI object.
my $alchemyObj = new AlchemyAPI();

# Load the API key from disk.
if ($alchemyObj->LoadKey("api_key.txt") eq "error")
{
	die "Error loading API key.  Edit api_key.txt and insert your API key.";
}


my $result = '';


# Get a ranked list of named entities for a web URL.
$result = $alchemyObj->URLGetRawText("http://nwda.orbiscascade.org/ark:/80444/xv08340");
$result = $alchemyObj->URLGetRankedNamedEntities("http://nwda.orbiscascade.org/ark:/80444/xv08340");
if ($result ne "error")
{
	printf $result;
}


