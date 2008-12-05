<?xml version="1.0" encoding="UTF-8"?>

<!-- to_form_property_sets

	Copyright Deakin University 2005,2006,2008
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


	
	This stylesheet is not intended to be executed directly

	This stylesheet contains the "look" of elements within the form
	They may be edited to customise to your particular requirements,
	but the default settings have been tested with Teleform and produce
	acceptable results when banding and verifying.

	Some property sets are affected by changes to parameters listed in the 
	to_form_page_layout stylesheet
	
-->

<!-- This is the property sets stylesheet -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dcarf="http://www.deakin.edu.au/dcarf">

	<!-- Sizes of things -->
	<xsl:variable name="responseContainerWidth">7mm</xsl:variable>
	<xsl:variable name="triangleWidth">2.5mm</xsl:variable>
	<xsl:variable name="triangleBoxHeight">9.5mm</xsl:variable>

	<!-- Line length follows the rule: (matrixBoxWidth - responseBoxWidth)/2 -->
	<xsl:variable name="lineLength">
		<xsl:call-template name="divide">
			<xsl:with-param name="x">
				<xsl:call-template name="subtract">
					<xsl:with-param name="x" select="$matrixBoxWidth"/>
					<xsl:with-param name="y" select="$responseBoxWidth"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="y">2</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="lineLengthAndBoxWidth">
				<xsl:call-template name="add">
					<xsl:with-param name="x" select="$lineLength"/>
					<xsl:with-param name="y" select="$responseBoxWidth"/>
				</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="delimiterWidth">6mm</xsl:variable>
	<xsl:variable name="delimiterHeight">8mm</xsl:variable>
	<xsl:variable name="delimiterBoxHeight">9mm</xsl:variable>
	<xsl:variable name="delimiterMaxPerRow">24</xsl:variable>

	<xsl:variable name="subQuestionMargin">
		<xsl:choose>
			<xsl:when test="$matrixBoxWidth = '15mm'">-3mm</xsl:when>
			<xsl:otherwise>0mm</xsl:otherwise>
		</xsl:choose>

	</xsl:variable>

	<!-- Attribute sets for fonts -->
	
	<xsl:attribute-set name="titleFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">36pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="sectionFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">18pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="sectionFontCenter">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">18pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
	</xsl:attribute-set>


	
	<xsl:attribute-set name="organisationFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>

	</xsl:attribute-set>	
	
	<xsl:attribute-set name="returnHeadingFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
	</xsl:attribute-set>	
	
	<xsl:attribute-set name="helpHeadingFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
	</xsl:attribute-set>	

	<xsl:attribute-set name="webHeadingFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
	</xsl:attribute-set>	

	<xsl:attribute-set name="instructionsHeadingFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
	</xsl:attribute-set>	

	
	<xsl:attribute-set name="returnFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="margin-left">15mm</xsl:attribute>
	</xsl:attribute-set>	
	
	<xsl:attribute-set name="helpFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="margin-left">15mm</xsl:attribute>
	</xsl:attribute-set>	

	<xsl:attribute-set name="webFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="margin-left">15mm</xsl:attribute>
	</xsl:attribute-set>	
	
	<xsl:attribute-set name="instructionsFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="margin-left">15mm</xsl:attribute>
	</xsl:attribute-set>	

	
	<xsl:attribute-set name="section_info_beforeFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">3mm</xsl:attribute>
		
	</xsl:attribute-set>

	<xsl:attribute-set name="section_info_titleFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
	</xsl:attribute-set>

	<xsl:attribute-set name="section_info_afterFont">
			<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">20mm</xsl:attribute>
		<xsl:attribute name="margin-right">20mm</xsl:attribute>


	</xsl:attribute-set>	
	
	<xsl:attribute-set name="directive_beforeFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size"><xsl:value-of select="$questionFontSize"/></xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">12mm</xsl:attribute>
		<!--<xsl:attribute name="margin-right">1mm</xsl:attribute>-->
		<xsl:attribute name="margin-right"><xsl:value-of select="$skipColumnWidth"/></xsl:attribute>	
	</xsl:attribute-set>

	<xsl:attribute-set name="directive_duringFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">3mm</xsl:attribute>
		<!--<xsl:attribute name="margin-right">1mm</xsl:attribute>-->
		<xsl:attribute name="margin-right"><xsl:value-of select="$skipColumnWidth"/></xsl:attribute>	
	</xsl:attribute-set>


	<xsl:attribute-set name="directive_afterFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">3mm</xsl:attribute>
		<xsl:attribute name="margin-right">1mm</xsl:attribute>
		
	</xsl:attribute-set>

	<xsl:attribute-set name="section_info_duringFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">3mm</xsl:attribute>
		<xsl:attribute name="margin-right">2mm</xsl:attribute>
		
	</xsl:attribute-set>

	<xsl:attribute-set name="questionnaireInfoAfterFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">20mm</xsl:attribute>
		<xsl:attribute name="margin-right">20mm</xsl:attribute>
		<xsl:attribute name="margin-top">5mm</xsl:attribute>
		<xsl:attribute name="margin-bottom">5mm</xsl:attribute>
		
	</xsl:attribute-set>

	<xsl:attribute-set name="questionnaireInfoAppendixFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">20mm</xsl:attribute>
		<xsl:attribute name="margin-right">20mm</xsl:attribute>
		<xsl:attribute name="margin-top">5mm</xsl:attribute>
		<xsl:attribute name="margin-bottom">5mm</xsl:attribute>
		
	</xsl:attribute-set>


	
	<xsl:attribute-set name="questionnaireInfoBeforeFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">20mm</xsl:attribute>
		<xsl:attribute name="margin-right">20mm</xsl:attribute>
		<xsl:attribute name="margin-top">5mm</xsl:attribute>
		<xsl:attribute name="margin-bottom">5mm</xsl:attribute>
		
	</xsl:attribute-set>

	<xsl:attribute-set name="questionFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size"><xsl:value-of select="$questionFontSize"/></xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>

	</xsl:attribute-set>
	
	<xsl:attribute-set name="questionNumberFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>

	</xsl:attribute-set>	
	
	<xsl:attribute-set name="questionQualifierFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>

		<xsl:attribute name="margin-left">1mm</xsl:attribute>
	</xsl:attribute-set>			
	
	<xsl:attribute-set name="questionSpecifierFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size"><xsl:value-of select="$questionFontSize"/></xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<!--
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="margin-top">4mm</xsl:attribute>
		<xsl:attribute name="margin-right">1mm</xsl:attribute>-->
	</xsl:attribute-set>		

	


	<xsl:attribute-set name="questionSkippedToFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">16pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="labelFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">1pt</xsl:attribute>
		<xsl:attribute name="margin-right">1pt</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="free_labelFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>	
		<xsl:attribute name="margin-left">
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">1mm</xsl:when>
				<xsl:otherwise>3mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:attribute-set>	
	
	<xsl:attribute-set name="freeLabelTextFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="margin-top">-2mm</xsl:attribute>
	</xsl:attribute-set>		
	
	
	
	<xsl:attribute-set name="subquestionFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="margin-right"><xsl:value-of select="$subQuestionMargin"/></xsl:attribute>
		<xsl:attribute name="margin-bottom">2mm</xsl:attribute>
		
		
	</xsl:attribute-set>
	
		<xsl:attribute-set name="subquestionfreeFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">right</xsl:when>
				<xsl:otherwise>left</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>

		<xsl:attribute name="margin-right">
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">2mm</xsl:when>
				<xsl:otherwise>0mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="margin-left">
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">0mm</xsl:when>
				<xsl:otherwise>2mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		
		
	</xsl:attribute-set>


	<xsl:attribute-set name="category_labelFont">
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">right</xsl:when>
				<xsl:otherwise>left</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>		
		<xsl:attribute name="margin-right">
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">2mm</xsl:when>
				<xsl:otherwise>0mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="margin-left">
			<xsl:choose>
				<xsl:when test="$leftalign = 'false'">0mm</xsl:when>
				<xsl:otherwise>2mm</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:attribute-set>

	
	<xsl:attribute-set name="skiptoFont">
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		
		<xsl:attribute name="margin-left">1mm</xsl:attribute>
		
	</xsl:attribute-set>

	<!-- Attribute sets for containers -->
	<xsl:attribute-set name="skiptoContainer">
		<xsl:attribute name="border">hidden</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>	
		
	</xsl:attribute-set>
	
	<xsl:attribute-set name="free_labelContainer">
		<xsl:attribute name="border">hidden</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>	
		<xsl:attribute name="height"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		
	</xsl:attribute-set>	
	
	<xsl:attribute-set name="freeLabelTextContainer">
		<xsl:attribute name="margin-left">10mm</xsl:attribute>
		<xsl:attribute name="margin-top">2mm</xsl:attribute>
		<xsl:attribute name="margin-bottom">1mm</xsl:attribute>
		
	</xsl:attribute-set>	
	
	
	
	<xsl:attribute-set name="skipTriangleContainer">
		<xsl:attribute name="column-width"><xsl:value-of select="$triangleWidth"/></xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="titleContainer">
		<xsl:attribute name="absolute-position">fixed</xsl:attribute>
		<xsl:attribute name="top">20mm</xsl:attribute>	
		<xsl:attribute name="left">20mm</xsl:attribute>
		<xsl:attribute name="width">140mm</xsl:attribute>
		<xsl:attribute name="height">80mm</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="logoContainer">
		<xsl:attribute name="absolute-position">fixed</xsl:attribute>
		<xsl:attribute name="top">20mm</xsl:attribute>	
		<xsl:attribute name="left">155mm</xsl:attribute>
	</xsl:attribute-set>
	

	<xsl:attribute-set name="logo2Container">
		<xsl:attribute name="absolute-position">fixed</xsl:attribute>
		<xsl:attribute name="top">234mm</xsl:attribute>	
		<xsl:attribute name="left">25mm</xsl:attribute>
	</xsl:attribute-set>	
	
	<xsl:attribute-set name="organisationContainer">
		<xsl:attribute name="absolute-position">fixed</xsl:attribute>
		<xsl:attribute name="top">255mm</xsl:attribute>	
		<xsl:attribute name="left">90mm</xsl:attribute>
		<xsl:attribute name="width">100mm</xsl:attribute>
	</xsl:attribute-set>	
	
	<xsl:attribute-set name="returnContainer">
		<xsl:attribute name="absolute-position">fixed</xsl:attribute>
		<xsl:attribute name="top">135mm</xsl:attribute>	
		<xsl:attribute name="left">45mm</xsl:attribute>
		<xsl:attribute name="width">120mm</xsl:attribute>
		<xsl:attribute name="height">65mm</xsl:attribute>
	</xsl:attribute-set>	

	<xsl:attribute-set name="webContainer">
		<xsl:attribute name="absolute-position">fixed</xsl:attribute>
		<xsl:attribute name="top">180mm</xsl:attribute>	
		<xsl:attribute name="left">45mm</xsl:attribute>
		<xsl:attribute name="width">120mm</xsl:attribute>
		<xsl:attribute name="height">65mm</xsl:attribute>
	</xsl:attribute-set>	

	<xsl:attribute-set name="instructionsContainer">
		<xsl:attribute name="absolute-position">fixed</xsl:attribute>
		<xsl:attribute name="top">115mm</xsl:attribute>	
		<xsl:attribute name="left">45mm</xsl:attribute>
		<xsl:attribute name="width">120mm</xsl:attribute>
		<xsl:attribute name="height">65mm</xsl:attribute>
	</xsl:attribute-set>	


	<xsl:attribute-set name="helpContainer">
		<xsl:attribute name="absolute-position">fixed</xsl:attribute>
		<xsl:attribute name="top">215mm</xsl:attribute>	
		<xsl:attribute name="left">45mm</xsl:attribute>
		<xsl:attribute name="width">120mm</xsl:attribute>
		<xsl:attribute name="height">65mm</xsl:attribute>
	</xsl:attribute-set>	

	
	
	<xsl:attribute-set name="sectiontextContainer">
		<xsl:attribute name="margin-left">3mm</xsl:attribute>
		<xsl:attribute name="margin-top">3mm</xsl:attribute>
		<xsl:attribute name="margin-bottom">3mm</xsl:attribute>
		
	</xsl:attribute-set>

	<xsl:attribute-set name="sectionContainer">
		<xsl:attribute name="border-top-style">solid</xsl:attribute>
		<xsl:attribute name="border-top-width">5pt</xsl:attribute>
		<xsl:attribute name="border-top-color">rgb(255, 255, 255)</xsl:attribute>	
		<xsl:attribute name="padding-bottom">5mm</xsl:attribute>
		<xsl:attribute name="background-color"><xsl:choose><xsl:when test="$toquexf = 1">rgb(255,255,255)</xsl:when><xsl:otherwise>rgb(221, 221, 221)</xsl:otherwise></xsl:choose></xsl:attribute>
		<xsl:attribute name="break-before">
			<xsl:choose>
				<xsl:when test="$section_page = 'true'">page</xsl:when>
				<xsl:otherwise>auto</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		
		<!-- This puts each section on a new page if set to "page" -->
		
		
	</xsl:attribute-set>
	
	<xsl:attribute-set name="firstQuestionContainer">
		<xsl:attribute name="keep-together">always</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="section_info_beforeContainer">
		<xsl:attribute name="margin-right">1mm</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="section_info_afterContainer">
		<xsl:attribute name="margin-right">1mm</xsl:attribute>
		<xsl:attribute name="margin-top">5mm</xsl:attribute>
		<xsl:attribute name="margin-bottom">5mm</xsl:attribute>
	</xsl:attribute-set>


	<xsl:attribute-set name="section_info_duringContainer">
		<xsl:attribute name="margin-top">1mm</xsl:attribute>
		<xsl:attribute name="margin-right">1mm</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="questionContainer">
		
		<xsl:attribute name="keep-together">always</xsl:attribute>
			
		<xsl:attribute name="border-top-style">solid</xsl:attribute>
		<xsl:attribute name="border-top-width">3pt</xsl:attribute>
		<xsl:attribute name="border-top-color">rgb(255, 255, 255)</xsl:attribute>
				
	</xsl:attribute-set>
	
	<xsl:attribute-set name="questionTextContainer">
		<xsl:attribute name="margin-left">2mm</xsl:attribute>
		<xsl:attribute name="margin-right">1mm</xsl:attribute>
		<xsl:attribute name="margin-top">1mm</xsl:attribute>
		<xsl:attribute name="margin-bottom">1mm</xsl:attribute>		
	</xsl:attribute-set>	
	
	
	<xsl:attribute-set name="questionnaireInfoAfterContainer">
		<!--
		<xsl:attribute name="border-top-style">solid</xsl:attribute>
		<xsl:attribute name="border-top-width">1pt</xsl:attribute>
		<xsl:attribute name="border-top-color">rgb(0, 0, 0,)</xsl:attribute>	-->
		<xsl:attribute name="margin-top">10mm</xsl:attribute>
		
	</xsl:attribute-set>	
	
	<xsl:attribute-set name="questionnaireInfoBeforeContainer">
		
		<xsl:attribute name="border-style">solid</xsl:attribute>
		<xsl:attribute name="border-width">2pt</xsl:attribute>
		<xsl:attribute name="border-color">rgb(0, 0, 0)</xsl:attribute>	

		
		
	</xsl:attribute-set>	
	
	
	<xsl:attribute-set name="responseContainer">
		<xsl:attribute name="margin-top">2mm</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="categoryContainer">
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="margin-right">20mm</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="subquestionContainer">
		<xsl:attribute name="border-style">hidden</xsl:attribute>
		
		<xsl:attribute name="display-align">center</xsl:attribute>			

	</xsl:attribute-set>
	
	<xsl:attribute-set name="subquestionfreeContainer">
		<xsl:attribute name="border-style">hidden</xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>			

	</xsl:attribute-set>
	
	<xsl:attribute-set name="category_labelContainer">
		<xsl:attribute name="border-style">hidden</xsl:attribute>
    	<xsl:attribute name="border-width">0</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="labelContainer">
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="subquestionboxContainer">
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="category_boxContainer">
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="border-style">hidden</xsl:attribute>
		<xsl:attribute name="border-width">0</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
	</xsl:attribute-set>
	
	<!-- Attribute sets for graphics/SVG -->
	<xsl:attribute-set name="fixedSVG">
		<xsl:attribute name="width"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$responseContainerWidth"/></xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="fixedNoLineSVG">
		<xsl:attribute name="width"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="skipSVG">
		<xsl:attribute name="width"><xsl:value-of select="$triangleWidth"/></xsl:attribute>
		<xsl:attribute name="height">5mm</xsl:attribute>
		<xsl:attribute name="top">2mm</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="boxarrowSVG">
		<xsl:attribute name="width"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$triangleBoxHeight"/></xsl:attribute>
	</xsl:attribute-set>


	<xsl:attribute-set name="freeSVG">
		<xsl:attribute name="width"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$delimiterBoxHeight"/></xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineBeforeNSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2">0</xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineBeforeESVG">
		<xsl:attribute name="x1">5.8mm</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2">5.8mm</xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke-dasharray: 2, 2;stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineBeforeSSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineBeforeWSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2">0</xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>


	<xsl:attribute-set name="delimiterLineSingleNSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2">0</xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineSingleESVG">
		<xsl:attribute name="x1"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineSingleSSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineSingleWSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2">0</xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	
	<xsl:attribute-set name="delimiterLineMiddleNSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2">0</xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineMiddleESVG">
		<xsl:attribute name="x1">5.8mm</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2">5.8mm</xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke-dasharray: 2, 2;stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineMiddleSSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineAfterNSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2">0</xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineAfterESVG">
		<xsl:attribute name="x1"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterLineAfterSSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="delimiterComma">
		<xsl:attribute name="y">7.8mm</xsl:attribute>
		<xsl:attribute name="x">0</xsl:attribute>
		<xsl:attribute name="fill">black</xsl:attribute>
		<xsl:attribute name="font-family">serif</xsl:attribute>
		<xsl:attribute name="font-size">16pt</xsl:attribute>
		<xsl:attribute name="text-anchor">start</xsl:attribute>
	</xsl:attribute-set>


	<xsl:attribute-set name="delimiterBoxSVG">
		<xsl:attribute name="x">0</xsl:attribute>
		<xsl:attribute name="y">0</xsl:attribute>
		<xsl:attribute name="width"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$delimiterHeight"/></xsl:attribute>
		<xsl:attribute name="style">fill:rgb(255,255,255);</xsl:attribute>
	</xsl:attribute-set>


	<xsl:attribute-set name="boxSVG">
		<xsl:attribute name="width"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="style">fill:rgb(255,255,255);stroke-width:0.5pt;stroke:rgb(0,0,0)</xsl:attribute>
		<xsl:attribute name="x">0</xsl:attribute>
		<xsl:attribute name="y">1mm</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="boxNoLineSVG">
		<xsl:attribute name="width"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="style">fill:rgb(255,255,255);stroke-width:0.5pt;stroke:rgb(0,0,0)</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="crossleftSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 1.3pt;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="crossrightSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="y2">0</xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 1.3pt;</xsl:attribute>
	</xsl:attribute-set>


	<xsl:attribute-set name="matrixSVG">
		<xsl:attribute name="width"><xsl:value-of select="$matrixBoxWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="matrixSVGshort">
		<xsl:attribute name="width">7mm</xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
	</xsl:attribute-set>

	

	<xsl:attribute-set name="matrixboxSVG">
		<xsl:attribute name="width"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		
			<!--draw the box starting $lineLength  the way in -->
		
		<xsl:attribute name="x"><xsl:value-of select="$lineLength"/></xsl:attribute>
		<xsl:attribute name="y">0</xsl:attribute>
		<xsl:attribute name="style">fill:rgb(255,255,255);stroke-width:0.5pt;stroke:rgb(0,0,0)</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="matrixboxSVGshort">
		<xsl:attribute name="width"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
		
			<!--draw the box starting $lineLength  the way in -->
		
		<xsl:attribute name="x">1mm</xsl:attribute>
		<xsl:attribute name="y">0</xsl:attribute>
		<xsl:attribute name="style">fill:rgb(255,255,255);stroke-width:0.5pt;stroke:rgb(0,0,0)</xsl:attribute>
	</xsl:attribute-set>

	
	<xsl:attribute-set name="linebeforeSVG">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1">2.5mm</xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$lineLength"/></xsl:attribute>
		<xsl:attribute name="y2">2.5mm</xsl:attribute>
		<xsl:attribute name="style">stroke-dasharray: 2, 2;stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="lineafterSVG">
		
		<xsl:attribute name="x1"><xsl:value-of select="$lineLengthAndBoxWidth"/></xsl:attribute>
		<xsl:attribute name="y1">2.5mm</xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$matrixBoxWidth"/></xsl:attribute>
		<xsl:attribute name="y2">2.5mm</xsl:attribute>
		<xsl:attribute name="style">stroke-dasharray: 2, 2;stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>


	<xsl:attribute-set name="linebeforeSVGshort">
		<xsl:attribute name="x1">0</xsl:attribute>
		<xsl:attribute name="y1">2.5mm</xsl:attribute>
		<xsl:attribute name="x2">1mm</xsl:attribute>
		<xsl:attribute name="y2">2.5mm</xsl:attribute>
		<xsl:attribute name="style">stroke-dasharray: 2, 2;stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="lineafterSVGshort">
		
		<xsl:attribute name="x1">6mm</xsl:attribute>
		<xsl:attribute name="y1">2.5mm</xsl:attribute>
		<xsl:attribute name="x2">7mm</xsl:attribute>
		<xsl:attribute name="y2">2.5mm</xsl:attribute>
		<xsl:attribute name="style">stroke-dasharray: 2, 2;stroke: black; stroke-width: 0.5pt;</xsl:attribute>
	</xsl:attribute-set>
	
	
	<xsl:attribute-set name="linebottomSVG">
		<xsl:attribute name="x1">2.5mm</xsl:attribute>
		<xsl:attribute name="y1">6mm</xsl:attribute>
		<xsl:attribute name="x2">2.5mm</xsl:attribute>
		<xsl:attribute name="y2">7mm</xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.8pt;</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="linetopSVG">
		<xsl:attribute name="x1">2.5mm</xsl:attribute>
		<xsl:attribute name="y1">0</xsl:attribute>
		<xsl:attribute name="x2">2.5mm</xsl:attribute>
		<xsl:attribute name="y2">1mm</xsl:attribute>
		<xsl:attribute name="style">stroke: black; stroke-width: 0.8pt;</xsl:attribute>
	</xsl:attribute-set>
	
	
	
	<xsl:attribute-set name="triangleSVG">
		<xsl:attribute name="points">0,0 1,1 0,2</xsl:attribute>
		<xsl:attribute name="style">fill: black;</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="triangleBottomSVG">
		<xsl:attribute name="points">0,2.46 2,2.46 1,3.6</xsl:attribute>
		<xsl:attribute name="style">fill: black;</xsl:attribute>
	</xsl:attribute-set>

	

	<!-- Attribute sets for tables -->
	<xsl:attribute-set name="fixedResponseColumn">
		<xsl:attribute name="column-width"><xsl:value-of select="$responseBoxWidth"/></xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="freeResponseColumn">
		<xsl:attribute name="column-width"><xsl:value-of select="$delimiterWidth"/></xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="matrixResponseColumn">
		<xsl:attribute name="column-width"><xsl:value-of select="$matrixBoxWidth"/></xsl:attribute>
	</xsl:attribute-set>

	
	<xsl:attribute-set name="skipColumn">
		<xsl:attribute name="column-width"><xsl:value-of select="$skipColumnWidth"/></xsl:attribute>
	</xsl:attribute-set>	

	<xsl:attribute-set name="matrixSkipColumn">
		<xsl:attribute name="column-width"><xsl:value-of select="$matrixSkipColumnWidth"/></xsl:attribute>
	</xsl:attribute-set>	
	
	<xsl:attribute-set name="tableRow">
		<xsl:attribute name="border-width">0</xsl:attribute>
		<xsl:attribute name="margin-top">0</xsl:attribute>
		<xsl:attribute name="margin-bottom">0</xsl:attribute>
		<xsl:attribute name="padding-top">0</xsl:attribute>
		<xsl:attribute name="padding-bottom">0</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
	</xsl:attribute-set>
	
</xsl:stylesheet>

