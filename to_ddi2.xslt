<?xml version="1.0" encoding="UTF-8"?>
<!-- to_ddi2

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
	
	Updates a DDI file with the correct file dimensions, variable locations	given the widths
	of each variable
	
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="comment()">
		<xsl:copy/>
	</xsl:template>

	
	<!-- copies all nodes by default-->
	<xsl:template match="node() | @*">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	
	<!-- counts the number of variables and replaces var quantity -->
	<xsl:template match="/codeBook/fileDscr/fileTxt/dimensns/varQnty">
		<xsl:element name="varQnty">
			<xsl:value-of select="count(/codeBook/dataDscr/var)"/>
		</xsl:element>
	</xsl:template>

	<!-- counts the length of all variables and replaces logical record length -->
	<xsl:template match="/codeBook/fileDscr/fileTxt/dimensns/logRecL">
		<xsl:element name="logRecL">
			<xsl:value-of select="sum(/codeBook/dataDscr/var/location/@width)"/>
		</xsl:element>
	</xsl:template>
	
	<!-- replaces the first variables location to 1-->
	<xsl:template match="/codeBook/dataDscr/var[position()=1]/location">
				<xsl:element name="location">
					<xsl:attribute name="RecSegNum">1</xsl:attribute>
					<xsl:attribute name="StartPos">1</xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
				</xsl:element>
	</xsl:template>

	<!-- replaces all following variables location to the position after the previous variable -->
	<xsl:template match="/codeBook/dataDscr/var[position()>1]/location">
				<xsl:element name="location">
					<xsl:attribute name="RecSegNum">1</xsl:attribute>
					<!-- start pos is the sum of the previous widths + 1 -->
					<xsl:attribute name="StartPos"><xsl:value-of select="1 + sum(preceding::var/location/@width)"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
				</xsl:element>
	</xsl:template>
	

	
</xsl:stylesheet>
