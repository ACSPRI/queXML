<?xml version="1.0" encoding="UTF-8"?>

<!-- to_form_page_layout

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


	
	This stylesheet is not intended to be executed directly
	It is part of the to_form stylesheet

	This stylesheet handles the XSL:FO page layout sections

	The parameters listed below can be passed to the to_form stylesheet and will be executed within this stylesheet
	

-->

<!-- This is the page layout stylesheet -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 	xmlns:svg="http://www.w3.org/2000/svg" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dcarf="http://www.deakin.edu.au/dcarf">

    <!-- Import barcode generator templates -->
  <xsl:import href="barcode/2of5i.xsl"/>
   <!--<xsl:import href="barcode/code128.xsl"/>-->


   <!-- **PARAMETERS** -->
   
	<!-- The form ID for the barcode -->
	<xsl:param name="questionnaireId"/> <!-- this is the questionnaire ID for our database - 6 digits -->	
		<!-- The page number makes up the remaining 2 digits -->		
		
	<xsl:param name="formId"/> <!-- this is the case ID - 6 digits -->
	
	<xsl:param name="toteleform">0</xsl:param>
	<xsl:param name="show_page_numbers">false</xsl:param>
	<xsl:param name="show_variables">false</xsl:param>
	
	<xsl:param name="show_section_title">true</xsl:param>
	<xsl:param name="show_section_number">true</xsl:param>

	<xsl:param name="show_question_letter">true</xsl:param>
	
	<xsl:param name="show_cover_page">true</xsl:param>
	<xsl:param name="show_first_page">true</xsl:param>

	<!-- put each section on a new page -->
	<xsl:param name="section_page">false</xsl:param>
	
	<!--url(file://mnt/iss/quexml/deakin_logo.png)  -->
	<xsl:param name="logo">url(file://mnt/iss/quexml/deakin_logo.png)</xsl:param>
	
	<!-- url(file://mnt/iss/quexml/acspri_logo.png) -->
	<xsl:param name="logo2">false</xsl:param>
	
	<xsl:param name="barcode_page_01">false</xsl:param>
	<xsl:param name="barcode_page_02">false</xsl:param>
	<xsl:param name="barcode_page_03">false</xsl:param>
	<xsl:param name="barcode_page_04">false</xsl:param>
	<xsl:param name="barcode_page_05">false</xsl:param>
	<xsl:param name="barcode_page_06">false</xsl:param>
	<xsl:param name="barcode_page_07">false</xsl:param>
	<xsl:param name="barcode_page_08">false</xsl:param>
	<xsl:param name="barcode_page_09">false</xsl:param>
	<xsl:param name="barcode_page_10">false</xsl:param>
	<xsl:param name="barcode_page_11">false</xsl:param>
	<xsl:param name="barcode_page_12">false</xsl:param>
	<xsl:param name="barcode_page_13">false</xsl:param>
	<xsl:param name="barcode_page_14">false</xsl:param>
	<xsl:param name="barcode_page_15">false</xsl:param>
	<xsl:param name="barcode_page_16">false</xsl:param>
	<xsl:param name="barcode_page_17">false</xsl:param>
	<xsl:param name="barcode_page_18">false</xsl:param>
	<xsl:param name="barcode_page_19">false</xsl:param>
	<xsl:param name="barcode_page_20">false</xsl:param>
	<xsl:param name="barcode_page_21">false</xsl:param>
	<xsl:param name="barcode_page_22">false</xsl:param>
	<xsl:param name="barcode_page_23">false</xsl:param>
	<xsl:param name="barcode_page_24">false</xsl:param>
	<xsl:param name="barcode_page_25">false</xsl:param>
	<xsl:param name="barcode_page_26">false</xsl:param>
	<xsl:param name="barcode_page_27">false</xsl:param>
	<xsl:param name="barcode_page_28">false</xsl:param>
	<xsl:param name="barcode_page_29">false</xsl:param>
	<xsl:param name="barcode_page_30">false</xsl:param>
	<xsl:param name="barcode_page_31">false</xsl:param>
	<xsl:param name="barcode_page_32">false</xsl:param>
	<xsl:param name="barcode_page_33">false</xsl:param>
	<xsl:param name="barcode_page_34">false</xsl:param>
	<xsl:param name="barcode_page_35">false</xsl:param>
	<xsl:param name="barcode_page_36">false</xsl:param>
	<xsl:param name="barcode_page_37">false</xsl:param>
	<xsl:param name="barcode_page_38">false</xsl:param>
	<xsl:param name="barcode_page_39">false</xsl:param>
	<xsl:param name="barcode_page_40">false</xsl:param>
	<xsl:param name="barcode_page_41">false</xsl:param>
	<xsl:param name="barcode_page_42">false</xsl:param>
	<xsl:param name="barcode_page_43">false</xsl:param>
	<xsl:param name="barcode_page_44">false</xsl:param>
	<xsl:param name="barcode_page_45">false</xsl:param>
	<xsl:param name="barcode_page_46">false</xsl:param>
	<xsl:param name="barcode_page_47">false</xsl:param>
	<xsl:param name="barcode_page_48">false</xsl:param>
	<xsl:param name="barcode_page_49">false</xsl:param>
	<xsl:param name="barcode_page_50">false</xsl:param>
	<xsl:param name="barcode_page_51">false</xsl:param>
	<xsl:param name="barcode_page_52">false</xsl:param>
	<xsl:param name="barcode_page_53">false</xsl:param>
	<xsl:param name="barcode_page_54">false</xsl:param>
	<xsl:param name="barcode_page_55">false</xsl:param>
	<xsl:param name="barcode_page_56">false</xsl:param>
	<xsl:param name="barcode_page_57">false</xsl:param>
	<xsl:param name="barcode_page_58">false</xsl:param>
	<xsl:param name="barcode_page_59">false</xsl:param>
	<xsl:param name="barcode_page_60">false</xsl:param>
<!-- sizes of things -->

	<xsl:param name="skipColumnWidth">20mm</xsl:param>
	<xsl:param name="matrixSkipColumnWidth">15mm</xsl:param>	
	<xsl:param name="matrixBoxWidth">15mm</xsl:param>
	<xsl:param name="responseBoxWidth">5mm</xsl:param>
	
<!-- font size -->
	<xsl:variable name="questionFontSize">12pt</xsl:variable>
	


<!-- functions -->
<xsl:template name="mm">
		<xsl:param name="x"/>
		 <xsl:choose>
				<xsl:when test="contains($x,'mm')">
					<xsl:value-of select="number(substring-before($x,'mm'))"/>
				</xsl:when>
				<xsl:when test="contains($x,'cm')">
					<xsl:value-of select="10*number(substring-before($x,'cm'))"/>
				</xsl:when>
				<xsl:when test="contains($x,'m')">
					<xsl:value-of select="1000*number(substring-before($x,'m'))"/>
				</xsl:when>
				<xsl:when test="contains($x,'pt')">
					<xsl:value-of select="25.4*number(substring-before($x,'pt'))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$x"/>
				</xsl:otherwise>
			</xsl:choose>			 
	</xsl:template>


	<xsl:template name="add">
		 <xsl:param name="x"/>
		 <xsl:param name="y"/>
		<xsl:variable name="xmm"><xsl:call-template name="mm"><xsl:with-param name="x" select="$x"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ymm"><xsl:call-template name="mm"><xsl:with-param name="x" select="$y"/></xsl:call-template></xsl:variable>
		
		<xsl:value-of select="concat(($xmm + $ymm), 'mm')"/>
	</xsl:template>

	<xsl:template name="subtract">
		 <xsl:param name="x"/>
		 <xsl:param name="y"/>
		<xsl:variable name="xmm"><xsl:call-template name="mm"><xsl:with-param name="x" select="$x"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ymm"><xsl:call-template name="mm"><xsl:with-param name="x" select="$y"/></xsl:call-template></xsl:variable>
		
		<xsl:value-of select="concat(($xmm - $ymm), 'mm')"/>
	</xsl:template>

	<xsl:template name="multiply">
		 <xsl:param name="x"/>
		 <xsl:param name="y"/>
		<xsl:variable name="xmm"><xsl:call-template name="mm"><xsl:with-param name="x" select="$x"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ymm"><xsl:call-template name="mm"><xsl:with-param name="x" select="$y"/></xsl:call-template></xsl:variable>
		
		<xsl:value-of select="concat(($xmm * $ymm), 'mm')"/>
	</xsl:template>
	
	<xsl:template name="divide">
		 <xsl:param name="x"/>
		 <xsl:param name="y"/>
		<xsl:variable name="xmm"><xsl:call-template name="mm"><xsl:with-param name="x" select="$x"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ymm"><xsl:call-template name="mm"><xsl:with-param name="x" select="$y"/></xsl:call-template></xsl:variable>
		
		<xsl:value-of select="concat(($xmm div $ymm), 'mm')"/>
	</xsl:template>



	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>


	<xsl:attribute-set name="pagepadding">
		<xsl:attribute name="padding-top">12mm</xsl:attribute>
		<xsl:attribute name="padding-bottom">12mm</xsl:attribute>
		<xsl:attribute name="padding-left">12mm</xsl:attribute>
		<xsl:attribute name="padding-right">12mm</xsl:attribute>
	</xsl:attribute-set>												  

	<xsl:attribute-set name="coverpage">
		<xsl:attribute name="background-color">(rgb(200,200,200))</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="restpage">
		<xsl:attribute name="background-color">(rgb(241,241,241))</xsl:attribute>
	</xsl:attribute-set>


	<xsl:attribute-set name="coverpageteleform">
		<xsl:attribute name="background-color">(rgb(255,255,255))</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="restpageteleform">
		<xsl:attribute name="background-color">(rgb(255,255,255))</xsl:attribute>
	</xsl:attribute-set>
	
	
	<xsl:template name="drawCornerBoxesLeft">
	
		<fo:block>
			<fo:instream-foreign-object>
				<svg:svg width="12mm" height="285mm">
					<svg:line x1="12mm" y1="10.94mm" x2="12mm" y2="30.94mm" style="stroke:rgb(0,0,0);stroke-width:1mm"/>	
					<svg:line x1="12mm" y1="252.84mm" x2="12mm" y2="272.84mm" style="stroke:rgb(0,0,0);stroke-width:1mm"/>
				</svg:svg>
			</fo:instream-foreign-object>	
		</fo:block>
	</xsl:template>

	<xsl:template name="drawCornerBoxesRight">
		<fo:block>
			<fo:instream-foreign-object>
				<svg:svg width="12mm" height="285mm">

					<svg:line x1="0" y1="10.94mm" x2="0" y2="30.94mm" style="stroke:rgb(0,0,0);stroke-width:1mm"/>	
					<svg:line x1="0" y1="252.84mm" x2="0" y2="272.84mm" style="stroke:rgb(0,0,0);stroke-width:1mm"/>

				</svg:svg>
			</fo:instream-foreign-object>	
		</fo:block>
	</xsl:template>

	<xsl:template name="drawCornerBoxesTop">
		
		<fo:block-container    
		   left="18mm"
		   top="14.9mm"
           width="174mm"
			height="1mm"
           absolute-position="fixed">
           <fo:block>
			<fo:instream-foreign-object>
				<svg:svg width="174mm" height="1mm">
					<svg:line x1="0" y1="0" x2="20mm" y2="0" style="stroke:rgb(0,0,0);stroke-width:1mm"/>
					<svg:line x1="154mm" y1="0" x2="174mm" y2="0" style="stroke:rgb(0,0,0);stroke-width:1mm"/>	
				</svg:svg>
			</fo:instream-foreign-object>
			</fo:block>
		</fo:block-container>
	</xsl:template>

	<xsl:template name="drawCornerBoxesBottom">
		
		<fo:block-container
			left="18mm"
		  top="276.3mm"
           width="174mm"
           height="1mm"
           absolute-position="fixed">
           <fo:block>
			<fo:instream-foreign-object>
				<svg:svg width="174mm" height="1mm">
					<svg:line x1="0" y1="0" x2="20mm" y2="0" style="stroke:rgb(0,0,0);stroke-width:1mm"/>
					<svg:line x1="154mm" y1="0" x2="174mm" y2="0" style="stroke:rgb(0,0,0);stroke-width:1mm"/>	
				</svg:svg>
			</fo:instream-foreign-object>
			</fo:block>
		</fo:block-container>
		
	</xsl:template>


	<xsl:template name="drawBarcode">
		<xsl:param name="page">00</xsl:param>
		
		<fo:block-container absolute-position="fixed" left="133mm" top="5mm">
		<fo:block>
			<fo:instream-foreign-object content-width="100%" content-height="12mm" top="0">
              <xsl:call-template name="barcode-2of5i">
                <xsl:with-param name="value">
					<xsl:number value="($questionnaireId * 100) + ($page)" format="00000001"/>
                </xsl:with-param>
                <xsl:with-param name="print-text">'false'</xsl:with-param>                
              </xsl:call-template>
			</fo:instream-foreign-object>
		</fo:block>
		</fo:block-container>

	</xsl:template>

	<xsl:template name="drawBarcodeFormId">
				
		<fo:block-container absolute-position="fixed" left="19mm" top="278mm">
			<fo:block>
			<fo:instream-foreign-object content-width="100%" content-height="12mm" top="0">
              <xsl:call-template name="barcode-2of5i">
                <xsl:with-param name="value">
					<xsl:number value="($questionnaireId * 1000000) + ($formId)" format="000000000001"/>
                </xsl:with-param>

             </xsl:call-template>
			</fo:instream-foreign-object>
			</fo:block>
		</fo:block-container>

	</xsl:template>


	
	<xsl:template match="/">
	

	
	
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				
				<!-- Cover page layout -->
				<fo:simple-page-master
					master-name="cover"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
					

						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding coverpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding coverpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="cover-before"/>
						<fo:region-after 	extent="12mm" region-name="cover-after"/>
						<fo:region-start 	extent="12mm" region-name="cover-start"/>
						<fo:region-end 	extent="12mm" region-name="cover-end"/>
				
				</fo:simple-page-master>
			
				<!-- first page layout -->
				<fo:simple-page-master
					master-name="first"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
						
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>


						
						<fo:region-before 	extent="12mm" region-name="first-before"/>
							<fo:region-after 	extent="12mm" region-name="first-after"/>							
						<fo:region-start 	extent="12mm" region-name="first-start"/>
						<fo:region-end 	extent="12mm" region-name="first-end"/>
						
				</fo:simple-page-master>
	
	

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q01"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

	
						
						<fo:region-before 	extent="12mm" region-name="q01-before"/>
						<xsl:choose>
							<xsl:when test="$barcode_page_01='true'">
								<fo:region-after 	extent="12mm" region-name="barcode-after"/>							
							</xsl:when>
							<xsl:otherwise>
								<fo:region-after 	extent="12mm" region-name="q-after"/>
							</xsl:otherwise>
						</xsl:choose>						
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q02"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q02-before"/>
						<xsl:choose>
							<xsl:when test="$barcode_page_02='true'">
								<fo:region-after 	extent="12mm" region-name="barcode-after"/>							
							</xsl:when>
							<xsl:otherwise>
								<fo:region-after 	extent="12mm" region-name="q-after"/>
							</xsl:otherwise>
						</xsl:choose>						

						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q03"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
					
						<fo:region-before 	extent="12mm" region-name="q03-before"/>
						<xsl:choose>
							<xsl:when test="$barcode_page_03='true'">
								<fo:region-after 	extent="12mm" region-name="barcode-after"/>							
							</xsl:when>
							<xsl:otherwise>
								<fo:region-after 	extent="12mm" region-name="q-after"/>
							</xsl:otherwise>
						</xsl:choose>						
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q04"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
					
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q04-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q05"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q05-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q06"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
										<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q06-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q07"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q07-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q08"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q08-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q09"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q09-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q10"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q10-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q11"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q11-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q12"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q12-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q13"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q13-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q14"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q14-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q15"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q15-before"/>
						<xsl:choose>
							<xsl:when test="$barcode_page_15='true'">
								<fo:region-after 	extent="12mm" region-name="barcode-after"/>							
							</xsl:when>
							<xsl:otherwise>
								<fo:region-after 	extent="12mm" region-name="q-after"/>
							</xsl:otherwise>
						</xsl:choose>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q16"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q16-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q17"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q17-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q18"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q18-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q19"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q19-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q20"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q20-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q21"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q21-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q22"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q22-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q23"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q23-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q24"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q24-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q25"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q25-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q26"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q26-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q27"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q27-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q28"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q28-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q29"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q29-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q30"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q30-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q31"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

	
						
						<fo:region-before 	extent="12mm" region-name="q31-before"/>
						<xsl:choose>
							<xsl:when test="$barcode_page_01='true'">
								<fo:region-after 	extent="12mm" region-name="barcode-after"/>							
							</xsl:when>
							<xsl:otherwise>
								<fo:region-after 	extent="12mm" region-name="q-after"/>
							</xsl:otherwise>
						</xsl:choose>						
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q32"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q32-before"/>
						<xsl:choose>
							<xsl:when test="$barcode_page_02='true'">
								<fo:region-after 	extent="12mm" region-name="barcode-after"/>							
							</xsl:when>
							<xsl:otherwise>
								<fo:region-after 	extent="12mm" region-name="q-after"/>
							</xsl:otherwise>
						</xsl:choose>						

						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q33"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
					
						<fo:region-before 	extent="12mm" region-name="q33-before"/>
						<xsl:choose>
							<xsl:when test="$barcode_page_03='true'">
								<fo:region-after 	extent="12mm" region-name="barcode-after"/>							
							</xsl:when>
							<xsl:otherwise>
								<fo:region-after 	extent="12mm" region-name="q-after"/>
							</xsl:otherwise>
						</xsl:choose>						
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q34"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
					
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q34-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q35"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q35-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q36"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
										<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q36-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q37"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q37-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q38"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q38-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q39"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q39-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q40"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q40-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q41"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q41-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q42"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q42-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q43"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q43-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q44"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q44-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q45"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q45-before"/>
						<xsl:choose>
							<xsl:when test="$barcode_page_15='true'">
								<fo:region-after 	extent="12mm" region-name="barcode-after"/>							
							</xsl:when>
							<xsl:otherwise>
								<fo:region-after 	extent="12mm" region-name="q-after"/>
							</xsl:otherwise>
						</xsl:choose>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q46"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q46-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q47"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q47-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q48"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q48-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q49"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q49-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q50"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q50-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q51"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q51-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q52"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q52-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q53"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q53-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q54"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q54-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q55"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q55-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q56"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q56-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q57"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q57-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q58"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q58-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q59"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>

						
						<fo:region-before 	extent="12mm" region-name="q59-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				

				<!-- questionnaire page layout - for barcoding uniquely -->
				<fo:simple-page-master
					master-name="q60"
					page-height="29.7cm"
					page-width="21.0cm"
					margin-top="6mm"
					margin-bottom="6mm"
					margin-left="6mm"
					margin-right="6mm">
	
	
						<xsl:choose>
							<xsl:when test="$toteleform = 0">
								<fo:region-body xsl:use-attribute-sets="pagepadding restpage"/>
							</xsl:when>
							<xsl:otherwise>
								<fo:region-body xsl:use-attribute-sets="pagepadding restpageteleform"/>
							</xsl:otherwise>
						</xsl:choose>
						
						<fo:region-before 	extent="12mm" region-name="q60-before"/>
						<fo:region-after 	extent="12mm" region-name="q-after"/>
						<fo:region-start 	extent="12mm" region-name="q-start"/>
						<fo:region-end 	extent="12mm" region-name="q-end"/>
										
				</fo:simple-page-master>
				
				
	
				<!-- Define a page sequence for a questionnaire -->
				
				<!-- The sequence here is Cover page, even, odd, even, odd ... etc-->
				<fo:page-sequence-master master-name="coverpage">
						<fo:single-page-master-reference master-reference="cover"/>
				
				</fo:page-sequence-master>

				<fo:page-sequence-master master-name="firstpage">
				
					<fo:single-page-master-reference master-reference="first"/>
				</fo:page-sequence-master>


				<fo:page-sequence-master master-name="rest">
					
					<fo:single-page-master-reference master-reference="q02"/>
					<fo:single-page-master-reference master-reference="q03"/>
					<fo:single-page-master-reference master-reference="q04"/>
					<fo:single-page-master-reference master-reference="q05"/>
					<fo:single-page-master-reference master-reference="q06"/>
					<fo:single-page-master-reference master-reference="q07"/>
					<fo:single-page-master-reference master-reference="q08"/>
					<fo:single-page-master-reference master-reference="q09"/>
					<fo:single-page-master-reference master-reference="q10"/>
					<fo:single-page-master-reference master-reference="q11"/>
					<fo:single-page-master-reference master-reference="q12"/>
					<fo:single-page-master-reference master-reference="q13"/>
					<fo:single-page-master-reference master-reference="q14"/>
					<fo:single-page-master-reference master-reference="q15"/>
					<fo:single-page-master-reference master-reference="q16"/>
					<fo:single-page-master-reference master-reference="q17"/>
					<fo:single-page-master-reference master-reference="q18"/>
					<fo:single-page-master-reference master-reference="q19"/>
					<fo:single-page-master-reference master-reference="q20"/>
					<fo:single-page-master-reference master-reference="q21"/>
					<fo:single-page-master-reference master-reference="q22"/>
					<fo:single-page-master-reference master-reference="q23"/>
					<fo:single-page-master-reference master-reference="q24"/>
					<fo:single-page-master-reference master-reference="q25"/>
					<fo:single-page-master-reference master-reference="q26"/>
					<fo:single-page-master-reference master-reference="q27"/>
					<fo:single-page-master-reference master-reference="q28"/>
					<fo:single-page-master-reference master-reference="q29"/>
					<fo:single-page-master-reference master-reference="q30"/>
					<fo:single-page-master-reference master-reference="q31"/>			
					<fo:single-page-master-reference master-reference="q32"/>
					<fo:single-page-master-reference master-reference="q33"/>
					<fo:single-page-master-reference master-reference="q34"/>
					<fo:single-page-master-reference master-reference="q35"/>
					<fo:single-page-master-reference master-reference="q36"/>
					<fo:single-page-master-reference master-reference="q37"/>
					<fo:single-page-master-reference master-reference="q38"/>
					<fo:single-page-master-reference master-reference="q39"/>
					<fo:single-page-master-reference master-reference="q40"/>
					<fo:single-page-master-reference master-reference="q41"/>
					<fo:single-page-master-reference master-reference="q42"/>
					<fo:single-page-master-reference master-reference="q43"/>
					<fo:single-page-master-reference master-reference="q44"/>
					<fo:single-page-master-reference master-reference="q45"/>
					<fo:single-page-master-reference master-reference="q46"/>
					<fo:single-page-master-reference master-reference="q47"/>
					<fo:single-page-master-reference master-reference="q48"/>
					<fo:single-page-master-reference master-reference="q49"/>
					<fo:single-page-master-reference master-reference="q50"/>
					<fo:single-page-master-reference master-reference="q51"/>
					<fo:single-page-master-reference master-reference="q52"/>
					<fo:single-page-master-reference master-reference="q53"/>
					<fo:single-page-master-reference master-reference="q54"/>
					<fo:single-page-master-reference master-reference="q55"/>
					<fo:single-page-master-reference master-reference="q56"/>
					<fo:single-page-master-reference master-reference="q57"/>
					<fo:single-page-master-reference master-reference="q58"/>
					<fo:single-page-master-reference master-reference="q59"/>
					<fo:single-page-master-reference master-reference="q60"/>	
				</fo:page-sequence-master>
			
			</fo:layout-master-set>
	


			<!-- The layout of the questionnaire -->
	<xsl:if test="$show_cover_page='true'">
			<fo:page-sequence 
				master-reference="coverpage">
			
				<fo:static-content flow-name="cover-after">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))"
						display-align="center">

						<xsl:call-template name="drawCornerBoxesBottom"/>		
						
						<xsl:call-template name="drawBarcodeFormId"/>
		
					</fo:block-container>
					
					
					
				</fo:static-content>

				<fo:static-content flow-name="cover-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))"
														display-align="before" top="0">

						

						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">00</xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="drawCornerBoxesTop"/>

					</fo:block-container>
					
				</fo:static-content>
				
				<fo:static-content flow-name="cover-start">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawCornerBoxesLeft"/>
					</fo:block-container>
				</fo:static-content>

				<fo:static-content flow-name="cover-end">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawCornerBoxesRight"/>
					</fo:block-container>
				</fo:static-content>


				<fo:flow flow-name="xsl-region-body">
					<xsl:call-template name="coverpage"/>
				</fo:flow>
			
			
			</fo:page-sequence>
		</xsl:if>

		<xsl:if test="$show_first_page='true'">				
			<fo:page-sequence initial-page-number="1" master-reference="firstpage">

				<fo:static-content flow-name="first-before">
					<xsl:call-template name="drawCornerBoxesTop"/>
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">01</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					
				</fo:static-content>

				<fo:static-content flow-name="first-start">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawCornerBoxesLeft"/>
					</fo:block-container>
				</fo:static-content>

				<fo:static-content flow-name="first-end">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawCornerBoxesRight"/>
					</fo:block-container>
				</fo:static-content>

			


				<!-- The page numbers -->
				<xsl:choose>
					<xsl:when test="$show_page_numbers='true'">

						<fo:static-content flow-name="first-after">
							<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))"
															display-align="center">
								<fo:block text-align="center" font-family="sans-serif" font-size="9pt">
									Page <fo:page-number/>
								</fo:block>
							</fo:block-container>
					<xsl:call-template name="drawCornerBoxesBottom"/>
						</fo:static-content>

					</xsl:when>
				
					<xsl:otherwise>

						<fo:static-content flow-name="first-after">
							<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))"
						display-align="center">

						<xsl:call-template name="drawCornerBoxesBottom"/>		
						
						<xsl:call-template name="drawBarcodeFormId"/>
		
					</fo:block-container>
									
						</fo:static-content>
					
					
					</xsl:otherwise>
				</xsl:choose>


				<fo:flow flow-name="xsl-region-body">
					<xsl:call-template name="firstpage"/>
				</fo:flow>

			
			</fo:page-sequence>
			</xsl:if>
			
								
			<fo:page-sequence
				master-reference="rest"
				initial-page-number="2">

			<fo:static-content flow-name="barcode-after">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))"
						display-align="center">

						<xsl:call-template name="drawCornerBoxesBottom"/>		
						
						<xsl:call-template name="drawBarcodeFormId"/>
		
					</fo:block-container>
									
				</fo:static-content>			
				


				<fo:static-content flow-name="q02-before">
					<xsl:call-template name="drawCornerBoxesTop"/>
						
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">02</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					
				</fo:static-content>
				


				<fo:static-content flow-name="q03-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">03</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q04-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">04</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q05-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">05</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q06-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">06</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q07-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">07</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q08-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">08</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q09-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">09</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q10-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">10</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q11-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">11</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q12-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">12</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q13-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">13</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q14-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">14</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q15-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">15</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q16-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">16</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				
	
				
				<fo:static-content flow-name="q17-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">17</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q18-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">18</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q19-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">19</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q20-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">20</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q21-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">21</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q22-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">22</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q23-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">23</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q24-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">24</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q25-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">25</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q26-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">26</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q27-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">27</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q28-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">28</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q29-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">29</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q30-before">
					
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">30</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					
					<xsl:call-template name="drawCornerBoxesTop"/>
					
				</fo:static-content>


				<fo:static-content flow-name="q31-before">
					
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">31</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					
					<xsl:call-template name="drawCornerBoxesTop"/>
					
				</fo:static-content>

				
				<fo:static-content flow-name="q32-before">
					<xsl:call-template name="drawCornerBoxesTop"/>
						
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">32</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					
				</fo:static-content>
				


				<fo:static-content flow-name="q33-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">33</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q34-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">34</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q35-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">35</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q36-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">36</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q37-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">37</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q38-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">38</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q39-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">39</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q40-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">40</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q41-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">41</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q42-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">42</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q43-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">43</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q44-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">44</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q45-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">45</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q46-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">46</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				
	
				
				<fo:static-content flow-name="q47-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">47</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q48-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">48</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q49-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">49</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q50-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">50</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q51-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">51</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q52-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">52</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q53-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">53</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q54-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">54</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q55-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">55</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q56-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">56</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q57-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">57</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q58-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">58</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q59-before">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">59</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<xsl:call-template name="drawCornerBoxesTop"/>
				</fo:static-content>
				

				<fo:static-content flow-name="q60-before">
					
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">60</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					
					<xsl:call-template name="drawCornerBoxesTop"/>
					
				</fo:static-content>

				
				<fo:static-content flow-name="q-start">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawCornerBoxesLeft"/>
					</fo:block-container>
				</fo:static-content>

				<fo:static-content flow-name="q-end">
					<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))">
						<xsl:call-template name="drawCornerBoxesRight"/>
					</fo:block-container>
				</fo:static-content>


				<!-- The page numbers -->
				<xsl:choose>
					<xsl:when test="$show_page_numbers='true'">

						<fo:static-content flow-name="q-after">
							<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))"
															display-align="center">
								<fo:block text-align="center" font-family="sans-serif" font-size="9pt">
									Page <fo:page-number/>
								</fo:block>
							</fo:block-container>
							
							<xsl:call-template name="drawCornerBoxesBottom"/>
							
						</fo:static-content>

					</xsl:when>
				
					<xsl:otherwise>

						<fo:static-content flow-name="q-after">
							<fo:block-container height="100%" width="100%" background-color="(rgb(255,255,255))"
															display-align="center">
								<fo:block text-align="center" font-family="sans-serif" font-size="9pt">
									<xsl:text/>
								</fo:block>
							</fo:block-container>
							
							<xsl:call-template name="drawCornerBoxesBottom"/>
							
						</fo:static-content>
					
					
					</xsl:otherwise>
				</xsl:choose>

				
				<fo:flow flow-name="xsl-region-body">
					<xsl:call-template name="sections"/>
				</fo:flow>
			
			</fo:page-sequence>

		</fo:root>
	
	</xsl:template>



	
</xsl:stylesheet>
