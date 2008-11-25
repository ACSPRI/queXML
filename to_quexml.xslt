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
	
	<!-- replaces variable names in response/subQuestion fields -->
	<xsl:template match="/questionnaire/section/question/subQuestion">
				<xsl:copy>

        <xsl:attribute name="varName">
        <xsl:number count="section" level="any" format="A"/><xsl:number count="question" level="single" format="1"/><xsl:number count="subQuestion" level="single" format="a"/>
     </xsl:attribute>	
			<xsl:apply-templates select="@*[not(name()='varName')] | node()"/>
			</xsl:copy>
	</xsl:template>


	<!-- replaces variable names in response fields -->
	<xsl:template match="/questionnaire/section/question/response">
	
	<xsl:copy>
		<xsl:attribute name="varName">
			<xsl:number count="section" level="any" format="A"/><xsl:number count="question" level="single" format="1"/>
			<xsl:if test="count(../response) > 1">_<xsl:number count="response" level="single" format="1"/></xsl:if>
		</xsl:attribute>
					<xsl:apply-templates select="@*[not(name()='varName')] | node()"/>
					</xsl:copy>
	</xsl:template>


<!-- replace all values with ordered values -->
	<xsl:template match="/questionnaire/section/question/response/fixed/category/value">
		<xsl:element name="value">
			<xsl:number count="../category" level="single" format="1"/>		
		</xsl:element>
    </xsl:template>



	
</xsl:stylesheet>
