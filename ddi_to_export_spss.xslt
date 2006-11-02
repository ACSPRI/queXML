<?xml version="1.0" encoding="UTF-8"?>
<!-- ddi_to_export_spss

	Copyright Deakin University 2005,2006
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
	
	Produces SPSS syntax used to export variables based on their name in the DDI file
	to a fixed width data file.

	This stylesheet is used in the DCARF data output process by (see the *):

		1. Produce an SPSS data file from the data source (eg CASES, Teleform, phpSurveyor)
			containing all variables
		2. Produce a DDI Description file from the original queXML instrument using the to_ddi stylesheet
		3. Clean the SPSS data file
		4. Update and edit the DDI file to contain only the variables to be included in the dataset
		5. *Use this stylesheet with the DDI file to produce SPSS syntax to export the SPSS data to 
			fixed width format
		6. Use the ddi_to_spss stylesheet to produce a data description of the fixed width file
			to produce an SPSS data file based on the reduced dataset
	
-->


<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="no"/>

	<xsl:template match="codeBook">

		<xsl:text>WRITE OUTFILE='client.dat' </xsl:text>
		<xsl:text>
</xsl:text>
		<xsl:text>/ </xsl:text>

		<xsl:for-each select="//var">
			<xsl:value-of select="@ID"/>
			<xsl:choose>
				<xsl:when test="varFormat/@type = 'character'">
					<xsl:text> (A</xsl:text><xsl:value-of select="location/@width"/><xsl:text>)</xsl:text>
				</xsl:when>			
				<xsl:otherwise>
					<xsl:text> (F</xsl:text><xsl:value-of select="location/@width"/><xsl:text>.0)</xsl:text>					
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="position() != last()">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:for-each>		
		<xsl:text>.
</xsl:text>
		<xsl:text>&#32;</xsl:text>
		<xsl:text>EXECUTE .
</xsl:text>	
		<xsl:text>&#32;</xsl:text>
	</xsl:template>
	
</xsl:stylesheet>
