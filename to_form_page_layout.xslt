<?xml version="1.0" encoding="UTF-8"?>

<!-- to_form_page_layout

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
	along with queXML; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA


	
	This stylesheet is not intended to be executed directly
	It is part of the to_form stylesheet

	This stylesheet handles the XSL:FO page layout sections

	The parameters listed below can be passed to the to_form stylesheet and will be executed within this stylesheet
	

-->

<!-- This is the page layout stylesheet -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 	xmlns:svg="http://www.w3.org/2000/svg" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dcarf="http://www.deakin.edu.au/dcarf" xmlns:barcode="http://barcode4j.krysalis.org/ns">

   <!-- **PARAMETERS** -->
   
	<!-- The form ID for the barcode -->
	<xsl:param name="questionnaireId">1</xsl:param> <!-- this is the questionnaire ID for our database - 6 digits -->	
		<!-- The page number makes up the remaining 2 digits -->		
		
	<xsl:param name="formId"/> <!-- this is the case ID - 6 digits -->
	
	<xsl:param name="toquexf">0</xsl:param>
	<xsl:param name="show_page_numbers">false</xsl:param>
	<xsl:param name="show_variables">false</xsl:param>
	
	<xsl:param name="show_section_title">true</xsl:param>
	<xsl:param name="show_section_number">true</xsl:param>

	<xsl:param name="show_question_letter">true</xsl:param>
	
	<xsl:param name="show_cover_page">true</xsl:param>
	<xsl:param name="show_first_page">true</xsl:param>
	
	<xsl:param name="show_information_symbol">false</xsl:param>

	<xsl:param name="leftalign">false</xsl:param>
	
	<!-- put each section on a new page -->
	<xsl:param name="section_page">false</xsl:param>
	
	<!--url(file://mnt/iss/quexml/deakin_logo.png)  -->
	<xsl:param name="logo">url(file://mnt/iss/quexml/deakin_logo.png)</xsl:param>
	
	<!-- url(file://mnt/iss/quexml/acspri_logo.png) -->
	<xsl:param name="logo2">false</xsl:param>
	
	<xsl:param name="barcode_page_00">true</xsl:param>
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


										  

	<xsl:attribute-set name="cover-page">
		<xsl:attribute name="background-color"><xsl:choose><xsl:when test="$toquexf = 1">rgb(255, 255, 255)</xsl:when><xsl:otherwise>rgb(200, 200, 200)</xsl:otherwise></xsl:choose></xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="rest-page">
				<xsl:attribute name="background-color"><xsl:choose><xsl:when test="$toquexf = 1">rgb(255, 255, 255)</xsl:when><xsl:otherwise>rgb(241, 241, 241)</xsl:otherwise></xsl:choose></xsl:attribute>
	</xsl:attribute-set>


	<xsl:template name="drawCornerBoxesLeft">
	
	
		<fo:block-container  width="15.5mm" top="260.5mm" height="20mm" absolute-position="absolute" border-width="0.5mm" border-color="rgb(0,0,0)" border-style="solid" border-left-color="rgb(255,255,255)" border-top-color="rgb(255,255,255)" border-bottom-color="rgb(255,255,255)">
		     <fo:block/>
	      </fo:block-container>

	     <fo:block-container  width="15.5mm" top="15.5mm" height="20mm" absolute-position="absolute" border-width="0.5mm" border-color="rgb(0,0,0)" border-style="solid" border-left-color="rgb(255,255,255)" border-top-color="rgb(255,255,255)" border-bottom-color="rgb(255,255,255)">
		     <fo:block/>
	      </fo:block-container>

	</xsl:template>

	<xsl:template name="drawCornerBoxesRight">
	  <fo:block-container  left = "0.5mm" width="15.5mm" top="260.5mm" height="20mm" absolute-position="absolute" border-width="0.5mm" border-color="rgb(0,0,0)" border-style="solid" border-right-color="rgb(255,255,255)" border-top-color="rgb(255,255,255)" border-bottom-color="rgb(255,255,255)">
		     <fo:block/>
	      </fo:block-container>

	     <fo:block-container  left = "0.5mm" width="15.5mm" top="15.5mm" height="20mm" absolute-position="absolute" border-width="0.5mm" border-color="rgb(0,0,0)" border-style="solid" border-right-color="rgb(255,255,255)" border-top-color="rgb(255,255,255)" border-bottom-color="rgb(255,255,255)">
		     <fo:block/>
	      </fo:block-container>

	</xsl:template>

	<xsl:template name="drawCornerBoxesTop">
		
		    <fo:block-container top="15.5mm" absolute-position="absolute">
<fo:table table-layout="fixed" width="100%">
        <fo:table-column column-width="20mm"/>
	<fo:table-column column-width="proportional-column-width(1)"/>
        <fo:table-column column-width="20mm"/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell column-number="1">
		<fo:block border-top-width="0.5mm" border-color="rgb(0,0,0)" border-top-style="solid"/>
            </fo:table-cell>
            <fo:table-cell column-number="3">
              <fo:block border-top-width="0.5mm" border-color="rgb(0,0,0)" border-top-style="solid"/>
            </fo:table-cell>
	    </fo:table-row>
        </fo:table-body>
      </fo:table>
</fo:block-container>

	</xsl:template>

	<xsl:template name="drawCornerBoxesBottom">
		
		    <fo:block-container top="0" absolute-position="absolute">
<fo:table table-layout="fixed" width="100%">
        <fo:table-column column-width="20mm"/>
	<fo:table-column column-width="proportional-column-width(1)"/>
        <fo:table-column column-width="20mm"/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell column-number="1">
		<fo:block border-top-width="0.5mm" border-color="rgb(0,0,0)" border-top-style="solid"/>
            </fo:table-cell>
            <fo:table-cell column-number="3">
              <fo:block border-top-width="0.5mm" border-color="rgb(0,0,0)" border-top-style="solid"/>
            </fo:table-cell>
	    </fo:table-row>
        </fo:table-body>
      </fo:table>
</fo:block-container>

	</xsl:template>


	<xsl:template name="drawBarcode">

<fo:block-container top="5.5mm" left="117mm" absolute-position="absolute">
<fo:block>
  <fo:instream-foreign-object>
	  
	  <barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns">
		  <xsl:attribute name="message"><xsl:number value="$questionnaireId" format="000000"/>#page-number:00#</xsl:attribute>
		 <barcode:intl2of5>
			 <barcode:height>6mm</barcode:height>
			 <barcode:module-width>0.6mm</barcode:module-width>
			 <barcode:human-readable><barcode:placement>none</barcode:placement></barcode:human-readable>
		 </barcode:intl2of5>
   	</barcode:barcode>

  </fo:instream-foreign-object>
</fo:block>
</fo:block-container>

	</xsl:template>

	<xsl:template name="drawBarcodeFormId">

<fo:block-container top="2mm" left="0mm" absolute-position="absolute">
<fo:block>
  <fo:instream-foreign-object>
	  
	  <barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns">
		  <xsl:attribute name="message"><xsl:number value="$formId" format="000000"/></xsl:attribute>
		 <barcode:intl2of5>
			 <barcode:height>9mm</barcode:height>
			 <barcode:module-width>0.6mm</barcode:module-width>
			 <barcode:human-readable>
				 <barcode:placement>bottom</barcode:placement>
				 <barcode:font-name>sans-serif</barcode:font-name>
			 </barcode:human-readable>
		 </barcode:intl2of5>
   	</barcode:barcode>

  </fo:instream-foreign-object>
</fo:block>
</fo:block-container>




	</xsl:template>


	
	<xsl:template match="/">
		
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">


 <fo:layout-master-set>
    <fo:simple-page-master master-name="cover" page-height="29.7cm" page-width="21.0cm">
      <fo:region-body margin="16mm" xsl:use-attribute-sets="cover-page"/>      
      <fo:region-before extent="16mm" region-name="cover-before" background-color="rgb(255,255,255)" />
      <fo:region-after extent="16mm" region-name="cover-after" background-color="rgb(255,255,255)"/>
      <fo:region-start extent="16mm" region-name="cover-start" background-color="rgb(255,255,255)" />
      <fo:region-end extent="16mm" region-name="cover-end" background-color="rgb(255,255,255)" />
    </fo:simple-page-master>
    <fo:simple-page-master master-name="qpage" page-height="29.7cm" page-width="21.0cm">
      <fo:region-body margin="16mm" xsl:use-attribute-sets="rest-page"/>      
      <fo:region-before extent="16mm" region-name="qpage-before" background-color="rgb(255,255,255)" />
      <fo:region-after extent="16mm" region-name="qpage-after" background-color="rgb(255,255,255)"/>
      <fo:region-start extent="16mm" region-name="qpage-start" background-color="rgb(255,255,255)" />
      <fo:region-end extent="16mm" region-name="qpage-end" background-color="rgb(255,255,255)" />
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="coverpage">
      <fo:single-page-master-reference master-reference="cover"/>
    </fo:page-sequence-master>
    <fo:page-sequence-master master-name="rest">
      <fo:repeatable-page-master-reference master-reference="qpage"/>
    </fo:page-sequence-master>	    

  </fo:layout-master-set>



			<!-- The layout of the questionnaire -->
	<xsl:if test="$show_cover_page='true'">
			<fo:page-sequence 
				master-reference="coverpage">

			<fo:title>Cover</fo:title>

				<fo:static-content flow-name="cover-after">
				
						<xsl:call-template name="drawCornerBoxesBottom"/>		

						<xsl:if test="$barcode_page_00='true'">
							<xsl:call-template name="drawBarcodeFormId"/>
						</xsl:if>
		
				
					
				</fo:static-content>

				<fo:static-content flow-name="cover-before">
				
					<xsl:call-template name="drawBarcode"/>
						
						<xsl:call-template name="drawCornerBoxesTop"/>

									
				</fo:static-content>
				
				<fo:static-content flow-name="cover-start">
					
						<xsl:call-template name="drawCornerBoxesLeft"/>
	
				</fo:static-content>

				<fo:static-content flow-name="cover-end">
					
						<xsl:call-template name="drawCornerBoxesRight"/>
				</fo:static-content>


				<fo:flow flow-name="xsl-region-body">
					<xsl:call-template name="coverpage"/>
				</fo:flow>
			
			
			</fo:page-sequence>
		</xsl:if>

	<!--

		<xsl:if test="$show_first_page='true'">				
			<fo:page-sequence initial-page-number="1" master-reference="firstpage">

				<fo:static-content flow-name="first-before">
					<xsl:call-template name="drawCornerBoxesTop"/>
					<fo:block-container height="100%" width="100%" background-color="(rgb-icc(255, 255, 255, #Grayscale, 1.0))">
						<xsl:call-template name="drawBarcode">
							<xsl:with-param name="page">01</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					
				</fo:static-content>

				<fo:static-content flow-name="first-start">
					<fo:block-container height="100%" width="100%" background-color="(rgb-icc(255, 255, 255, #Grayscale, 1.0))">
						<xsl:call-template name="drawCornerBoxesLeft"/>
					</fo:block-container>
				</fo:static-content>

				<fo:static-content flow-name="first-end">
					<fo:block-container height="100%" width="100%" background-color="(rgb-icc(255, 255, 255, #Grayscale, 1.0))">
						<xsl:call-template name="drawCornerBoxesRight"/>
					</fo:block-container>
				</fo:static-content>

			


				<xsl:choose>
					<xsl:when test="$show_page_numbers='true'">

						<fo:static-content flow-name="first-after">
							<fo:block-container height="100%" width="100%" background-color="(rgb-icc(255, 255, 255, #Grayscale, 1.0))"
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
							<fo:block-container height="100%" width="100%" background-color="(rgb-icc(255, 255, 255, #Grayscale, 1.0))"
						display-align="center">

						<xsl:call-template name="drawCornerBoxesBottom"/>		

					<xsl:if test="$barcode_page_01='true'">
						<xsl:call-template name="drawBarcodeFormId"/>							
						</xsl:if>

		
					</fo:block-container>
									
						</fo:static-content>
					
					
					</xsl:otherwise>
				</xsl:choose>


				<fo:flow flow-name="xsl-region-body">
					<xsl:call-template name="firstpage"/>
				</fo:flow>

			
			</fo:page-sequence>
			</xsl:if>


			-->

								
			<fo:page-sequence
				master-reference="rest"> 

				<fo:title>Questions</fo:title>



				<fo:static-content flow-name="qpage-before">
					<xsl:call-template name="drawCornerBoxesTop"/>
						
					<xsl:call-template name="drawBarcode"/>

					
				</fo:static-content>
				

				<fo:static-content flow-name="qpage-start">
			
						<xsl:call-template name="drawCornerBoxesLeft"/>
			
				</fo:static-content>

				<fo:static-content flow-name="qpage-end">
		
						<xsl:call-template name="drawCornerBoxesRight"/>
	
				</fo:static-content>


				<!-- The page numbers -->
				<xsl:choose>
					<xsl:when test="$show_page_numbers='true'">

						<fo:static-content flow-name="qpage-after">
							<fo:block-container height="100%" width="100%" background-color="(rgb-icc(255, 255, 255, #Grayscale, 1.0))"
															display-align="center">
								<fo:block text-align="center" font-family="serif" font-size="9pt">
									Page <fo:page-number/>
								</fo:block>
							</fo:block-container>
							
							<xsl:call-template name="drawCornerBoxesBottom"/>
							
						</fo:static-content>

					</xsl:when>
				
					<xsl:otherwise>

						<fo:static-content flow-name="qpage-after">
							
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
