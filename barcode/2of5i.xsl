<?xml version="1.0" encoding="iso-8859-1"?>
<!-- ========================================================= -->
<!--                                                           -->
<!-- (c) 2003, RenderX                                         -->
<!--                                                           -->
<!-- Author: Alexander Peshkov <peshkov@renderx.com>           -->
<!--                                                           -->
<!-- Permission is granted to use this document, copy and      -->
<!-- modify free of charge, provided that every derived work   -->
<!-- bear a reference to the present document.                 -->
<!--                                                           -->
<!-- This document contains a computer program written in      -->
<!-- XSL Transformations Language. It is published with no     -->
<!-- warranty of any kind about its usability, as a mere       -->
<!-- example of XSL technology. RenderX shall not be           -->
<!-- considered liable for any damage or loss of data caused   -->
<!-- by use of this program.                                   -->
<!--                                                           -->
<!-- ========================================================= -->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:my="codabar-data">

<!-- ========================================================= -->
<!-- This stylesheet contains named template                   --> 
<!-- (barcode-2of5i) that encodes sequence of digits using     -->
<!-- 2-of-5 interleaved barcode scheme, with no check digit.   -->
<!--                                                           -->
<!--                     Mandatory parameters are:             -->
<!--                                                           -->
<!--  "value"           - a string to encode; can contain      -->
<!--                      only decimal digits                  -->
<!--  "string"          - a human readable string;             -->
<!--                      represents data encoded in           -->
<!--                      the barcode in a human-readable form -->
<!--                      Optional parameter.                  -->
<!--                      Default is: 'value' with checksum    -->
<!--                      and non-significant null added when  -->
<!--                      necessary.                           -->
<!--  "print-text"      - boolean, defines if a human          -->
<!--                      readable label should be printed.    -->
<!--                      Default is: 'true'.                  -->
<!--  "addchecksum"     - boolean, defines if checksum should  -->
<!--                      be added by the barcode generator;   -->
<!--                      Default is 'false'                   -->
<!--  "module"          - width of the elementary unit         -->
<!--                      bar/space;                           -->
<!--                      Default is 0.012in                   -->
<!--  "wide-to-narrow"  - width ratio for bars/spaces;         -->
<!--                      Default is 3.0                       -->
<!--  "height"          - pattern height (= bar length).       -->
<!--                      Default is 0.25in                    -->
<!--  "quiet-horizontal" - quiet zone horizontal margin width  -->
<!--                      Default is 0.24in                    -->
<!--  "quiet-vertical"   - quiet zone vertical margin width    -->
<!--                      Default is 0.06in                    -->
<!--  "font-family"     - a font family used to print textual  -->
<!--                      representation of a barcode.         -->
<!--                      Default is 'Courier'                 -->
<!--  "font-height"     - a height of the font used to print   -->
<!--                      textual representation of a barcode. -->
<!--                      Default is 8pt                       -->
<!-- ========================================================= -->

    <xsl:import href="2of5i-svg.xsl"/>

    <xsl:output method="xml"
                version="1.0"
                indent="yes"/>

    <xsl:param name="value"/>
    <xsl:param name="string"/>
    <xsl:param name="print-text" select="'true'"/>
    <xsl:param name="addchecksum" select="'false'"/>
    <xsl:param name="module" select="'0.024in'"/>
    <xsl:param name="wide-to-narrow" select="3.0"/>
    <xsl:param name="height" select="'0.25in'"/>
    <xsl:param name="quiet-horizontal" select="'0.24in'"/>
    <xsl:param name="quiet-vertical" select="'0.06in'"/>
    <xsl:param name="font-family" select="'sans-serif'"/>
    <xsl:param name="font-height" select="'10pt'"/>
    
    <!-- Driver template used for command line processing, an analog of 'Main' function in C -->
	<xsl:template match="/">
	  <xsl:call-template name="barcode-2of5i">
        <xsl:with-param name="value" select="$value"/>
        <xsl:with-param name="string" select="$string"/>
        <xsl:with-param name="print-text" select="$print-text"/>
        <xsl:with-param name="addchecksum" select="$addchecksum"/>
        <xsl:with-param name="module" select="$module"/>
        <xsl:with-param name="wide-to-narrow" select="$wide-to-narrow"/>
        <xsl:with-param name="height" select="$height"/>
        <xsl:with-param name="quiet-horizontal" select="$quiet-horizontal"/>
        <xsl:with-param name="quiet-vertical" select="$quiet-vertical"/>
        <xsl:with-param name="font-family" select="$font-family"/>
        <xsl:with-param name="font-height" select="$font-height"/>
      </xsl:call-template>
    </xsl:template>

    <!-- Main template used to create a barcode -->
    <xsl:template name="barcode-2of5i">
      <xsl:param name="value"/>
      <xsl:param name="string"/>
      <xsl:param name="print-text" select="'true'"/>
      <xsl:param name="addchecksum" select="'false'"/>
      <xsl:param name="module" select="'0.024in'"/> 
      <xsl:param name="wide-to-narrow" select="3.0"/> 
      <xsl:param name="height" select="'0.25in'"/> 
      <xsl:param name="quiet-horizontal" select="'0.24in'"/>
      <xsl:param name="quiet-vertical" select="'0.06in'"/>
      <xsl:param name="font-family" select="'serif'"/>
      <xsl:param name="font-height" select="'10pt'"/>
      
      <!-- Check data consistency -->
      <xsl:if test="string-length($value)=0">
        <xsl:message terminate="yes">Error: 'value' is not specified.</xsl:message>
      </xsl:if>
      <xsl:if test="string-length(translate($value,'1234567890',''))!=0">
        <xsl:message terminate="yes">Error: unexpected characters in 'value'.</xsl:message>
      </xsl:if> 

      <!-- Add checksum if required.  -->
      <!-- Source string must have even number of digits, justify it with leading '0' if necessary -->
      <xsl:variable name="value-real">
        <xsl:if test="((string-length($value) + ($addchecksum='true')) mod 2) != 0">0</xsl:if>
        <xsl:value-of select="$value"/>
        <xsl:if test="$addchecksum='true'">
          <xsl:call-template name="makeChecksum">
            <xsl:with-param name="value" select="$value"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:variable>

      <!-- Add strart/stop symbols and prepare actual barcode -->
      <xsl:variable name="value-encoded">
        <xsl:value-of select="'0000'"/>
        <xsl:call-template name="recursive-coder">
	      <xsl:with-param name="value" select="$value-real"/>
	    </xsl:call-template>
	    <xsl:value-of select="'100'"/>
	  </xsl:variable>

      <!-- Call backend to generate SVG image of the barcode -->
      <xsl:call-template name="draw-barcode">
        <xsl:with-param name="sequence" select="$value-encoded"/>
        <xsl:with-param name="string">
          <xsl:choose>
            <xsl:when test="string-length($string)=0">
              <xsl:value-of select="$value-real"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$string"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="print-text" select="$print-text"/>
        <xsl:with-param name="module" select="$module"/>
        <xsl:with-param name="height" select="$height"/>
        <xsl:with-param name="quiet-horizontal" select="$quiet-horizontal"/>
        <xsl:with-param name="quiet-vertical" select="$quiet-vertical"/>        
        <xsl:with-param name="font-family" select="$font-family"/>
        <xsl:with-param name="font-height" select="$font-height"/>
      </xsl:call-template>
    </xsl:template>

    <!-- ========================================================= -->
    <!-- Calculate module 10 checksum character                    -->
    <xsl:template name="makeChecksum">
      <xsl:param name="value"/>
      <xsl:param name="position" select="2"/>
      <xsl:param name="sum-odd" select="0"/>
      <xsl:param name="sum-even" select="0"/>
      
      <xsl:choose>
        <xsl:when test="string-length($value) &gt; 0">
          <xsl:variable name="digit" select="substring($value, string-length($value))"/>
          <xsl:call-template name="makeChecksum">
            <xsl:with-param name="value" select="substring($value,1,string-length($value) - 1)"/>
            <xsl:with-param name="sum-odd" select="$sum-odd + $digit*($position mod 2)"/>
            <xsl:with-param name="sum-even" select="$sum-even + $digit*(($position+1) mod 2)"/>
            <xsl:with-param name="position" select="$position + 1"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="(10 - (($sum-odd + 3*$sum-even) mod 10)) mod 10"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    
    <!-- ========================================================= -->
    <!-- Encode string of digits using 2 of 5 interleave encoding  -->
    <xsl:template name="recursive-coder">
      <xsl:param name="value"/>
    
      <!-- Convert two leading digits into binary sequence encoded with 2 of 5 code -->
      <xsl:variable name="digit1" select="document('')//my:num2bars/entry[@digit=substring($value, 1, 1)]/text()"/>
      <xsl:variable name="digit2" select="document('')//my:num2bars/entry[@digit=substring($value, 2, 1)]/text()"/>

      <!-- Interleave bits of two binary sequences -->
      <xsl:value-of select="concat(substring($digit1,1,1), substring($digit2,1,1),
                                   substring($digit1,2,1), substring($digit2,2,1),
                                   substring($digit1,3,1), substring($digit2,3,1),
                                   substring($digit1,4,1), substring($digit2,4,1),
                                   substring($digit1,5,1), substring($digit2,5,1))"/>
      
      <!-- If there is more digits to be drawn - activate recursion -->
      <xsl:if test="string-length($value) &gt; 2">
        <xsl:call-template name="recursive-coder">
          <xsl:with-param name="value" select="substring($value,3)"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:template>
    
	
	<!-- Code table defined in the standard -->
    <my:num2bars>
        <entry digit="0">00110</entry>
        <entry digit="1">10001</entry>
        <entry digit="2">01001</entry>
        <entry digit="3">11000</entry>
        <entry digit="4">00101</entry>
        <entry digit="5">10100</entry>
        <entry digit="6">01100</entry>
        <entry digit="7">00011</entry>
        <entry digit="8">10010</entry>
        <entry digit="9">01010</entry>
    </my:num2bars>

</xsl:stylesheet>