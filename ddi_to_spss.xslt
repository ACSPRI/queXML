<?xml version="1.0" encoding="UTF-8"?>
<!-- ddi_to_spss

	Copyright Deakin University 2005,2006,2009
	Written by Adam Zammit - adam.zammit@deakin.edu.au
	For the Deakin Computer Assisted Research Facility: http://www.deakin.edu.au/dcarf/

	This file is part of queXML.

	queXML is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	queXML is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Foobar; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

	2009 UPDATE:
		Now exports a file which is valid for GNU PSPP 

	
	Produces an SPSS description of a file based on the DDI description

	This stylesheet is used in the DCARF data output process by (see the *):

		1. Produce an SPSS data file from the data source (eg CASES, Teleform, phpSurveyor)
			containing all variables
		2. Produce a DDI Description file from the original queXML instrument using the to_ddi stylesheet
		3. Clean the SPSS data file
		4. Update and edit the DDI file to contain only the variables to be included in the dataset
		5. Use the ddi_to_export_spss stylesheet the DDI file to produce SPSS syntax to export the 
			SPSS data to fixed width format
		6. *Use the ddi_to_spss stylesheet to produce a data description of the fixed width file
			to produce an SPSS data file based on the reduced dataset
				
-->




<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	
<!-- DDI to SPSS Definition File -->
<xsl:param name="infile">client.dat</xsl:param>
<xsl:param name="outfile">client.sav</xsl:param>

<!-- escape-apos template by Jeni Tennison
	see: http://www.dpawson.co.uk/xsl/sect2/N7150.html
	
	makes sure apostrophes in text are escaped to be safely used in SPSS
-->



<xsl:template name="escape-apos">
 <xsl:param name="string"/>
 <xsl:variable name="apos">"</xsl:variable>
<xsl:choose>
 <xsl:when test='contains($string, $apos)'>
  <xsl:value-of select="substring-before($string,$apos)" />
	<xsl:text>'"</xsl:text>
	<xsl:call-template name="escape-apos">
	 <xsl:with-param name="string"
          select="substring-after($string, $apos)" />
	</xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
  <xsl:value-of select="$string" />
 </xsl:otherwise>
</xsl:choose>
</xsl:template>



	<xsl:template match="codeBook">
/* Title: <xsl:value-of select="normalize-space(stdyDscr/citation/titlStmt/titl)"/>
/* SubTitle: <xsl:value-of select="normalize-space(studyDscr/citation/titlStmt/titl)"/>
DATA LIST FIXED FILE='<xsl:value-of select="$infile"/>' / <xsl:apply-templates select="dataDscr"/>
	</xsl:template>
	
	<xsl:template match="dataDscr"><xsl:apply-templates select="var"/>
VARIABLE LABELS <xsl:apply-templates select="var[count(labl)>0]" mode="labels"/>
VALUE LABELS <xsl:apply-templates select="var[count(catgry)>0]" mode="vallabels"/>
SAVE /OUTFILE="<xsl:value-of select="$outfile"/>". 
</xsl:template>




	<xsl:template match="var">
<xsl:value-of select="normalize-space(@name)"/><xsl:text>&#32;</xsl:text><xsl:value-of select="number(location/@StartPos)"/>-<xsl:value-of select="(number(location/@StartPos) + number(location/@width)) - 1"/><xsl:if test="varFormat/@type = 'character'"><![CDATA[ (A) ]]></xsl:if><xsl:text>&#32;</xsl:text>
  	</xsl:template>	
	
	<xsl:template match="var" mode="labels">
<xsl:value-of select="normalize-space(@name)"/> "<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="substring(normalize-space(labl),1,250)"/></xsl:call-template>"<![CDATA[ /]]><xsl:text>&#32;</xsl:text>
  	</xsl:template>	

	<xsl:template match="var" mode="vallabels"><xsl:value-of select="normalize-space(@name)"/><xsl:text>&#32;</xsl:text><xsl:apply-templates select="catgry"/><![CDATA[ /]]><xsl:text>&#32;</xsl:text>
	</xsl:template>	

	<xsl:template match="catgry"><xsl:value-of select="normalize-space(catValu)"/><xsl:text>&#32;</xsl:text>"<xsl:call-template name="escape-apos" ><xsl:with-param name="string" select="substring(normalize-space(labl),1,59)"/></xsl:call-template>"<xsl:text>&#32;</xsl:text></xsl:template>

	
	
</xsl:stylesheet>
