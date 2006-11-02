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
                xmlns:my="code128-data">

<!-- ========================================================= -->
<!-- This stylesheet contains named template (barcode-code128) -->
<!-- that encodes given data using code 128 barcode scheme.    -->
<!--                                                           -->
<!--                     Mandatory parameters are:             -->
<!--                                                           -->
<!--  "value"           - a string to encode; can contain      -->
<!--                      ASCII chars and special control      -->
<!--                      sequences depending on code subset   -->
<!--                      (A, B or C) being used. Alphanumeric -->
<!--                      data and punctuation should be used  -->
<!--                      as it is, excluding percent ('%')    -->
<!--                      sign. It's used to escape control    -->
<!--                      characters. To enter percent sign    -->
<!--                      one must escape it by itself.        -->
<!--                      Examples:                            -->
<!--                      A       - capital 'A' character;     -->
<!--                      7       - digit 7;                   -->
<!--                      :       - colon sign;                -->
<!--                      %BS%    - BackSpace control;         -->
<!--                      %CODEA% - special code 128 character;-->
<!--                                switches active code subset-->
<!--                                to A;                      -->
<!--                      %%      - percent sign.              -->
<!--                      Note that characters must be         -->
<!--                      consistent with active code subset   -->
<!--                      For example, you cannot use %ESC%    -->
<!--                      if code subset B is active or you    -->   
<!--                      cannot enter odd digit sequence if   -->
<!--                      code subset C is active.             -->
<!--                                                           -->
<!--                      Optional parameters are:             -->
<!--                                                           -->
<!--  "string"          - a human readable string;             -->
<!--                      represents data encoded in           -->
<!--                      the barcode in a human-readable form -->
<!--                      Optional parameter. By default       -->
<!--                      equal to 'value'.                    -->
<!--  "print-text"      - boolean, defines if a human          -->
<!--                      readable label should be printed.    -->
<!--                      Default is: 'true'                   -->
<!--  "subset"          - a single character; defines code     -->
<!--                      subset to be used. You can switch    -->
<!--                      subset inside of the data sequence   -->
<!--                      using appropriate control characters.-->
<!--                      Note that generator would not switch -->
<!--                      code subsets on its own - it's up    -->
<!--                      to the user to select optimal subset.-->
<!--                      Possible values are: A, B, C         -->
<!--                      Default is 'A'                       -->
<!--  "makeUCC"         - boolean; defines if special          -->
<!--                      character required by UCC/EAN code   -->
<!--                      should be added by the barcode       -->
<!--                      generator;                           -->
<!--                      Default is 'false'                   -->
<!--  "module"          - width of the elementary unit         -->
<!--                      bar/space;                           -->
<!--                      Default is 0.0075in                  -->
<!--  "height"          - pattern height (= bar length).       -->
<!--                      Default is 0.25in                    -->
<!--  "quiet-horizontal" - quiet zone horizontal margin width   -->
<!--                      Default is 0.075in                   -->
<!--  "quiet-vertical"   - quiet zone vertical margin width     -->
<!--                      Default is 0.075in                   -->
<!--  "font-family"     - a font family used to print textual  -->
<!--                      representation of a barcode.         -->
<!--                      Default is 'Courier'                 -->
<!--  "font-height"     - a height of the font used to print   -->
<!--                      textual representation of a barcode. -->
<!--                      Default is 6pt                       -->
<!-- ========================================================= -->

    <xsl:import href="code128-svg.xsl"/>
    
    <xsl:output method="xml"
                version="1.0"
                indent="yes"/>

    <xsl:param name="value"/>
    <xsl:param name="string"/>
    <xsl:param name="print-text" select="'true'"/>
    <xsl:param name="subset" select="'A'"/>
    <xsl:param name="makeUCC" select="'false'"/>
    <xsl:param name="module" select="'0.0075in'"/>
    <xsl:param name="height" select="'0.25in'"/>
    <xsl:param name="quiet-horizontal" select="'0.075in'"/>
    <xsl:param name="quiet-vertical" select="'0.075in'"/>
    <xsl:param name="font-family" select="'Courier'"/>
    <xsl:param name="font-height" select="'6pt'"/>

    <xsl:variable name="apos">'</xsl:variable>
    
    <!-- Driver template used for command line processing, an analog of 'Main' function in C -->
	<xsl:template match="/">
	  <xsl:call-template name="barcode-code128">
        <xsl:with-param name="value" select="$value"/>
        <xsl:with-param name="string" select="$string"/>
        <xsl:with-param name="print-text" select="$print-text"/>
        <xsl:with-param name="subset" select="$subset"/>
        <xsl:with-param name="makeUCC" select="$makeUCC"/>
        <xsl:with-param name="module" select="$module"/>
        <xsl:with-param name="height" select="$height"/>
        <xsl:with-param name="quiet-horizontal" select="$quiet-horizontal"/>
        <xsl:with-param name="quiet-vertical" select="$quiet-vertical"/>
        <xsl:with-param name="font-family" select="$font-family"/>
        <xsl:with-param name="font-height" select="$font-height"/>
      </xsl:call-template>
    </xsl:template>

    <!-- Main template used to create a barcode -->
    <xsl:template name="barcode-code128">
      <xsl:param name="value"/>
      <xsl:param name="string"/>
      <xsl:param name="print-text" select="'true'"/>
      <xsl:param name="subset" select="'A'"/>
      <xsl:param name="makeUCC" select="'false'"/>
      <xsl:param name="module" select="'0.0075in'"/>
      <xsl:param name="height" select="'0.25in'"/>
      <xsl:param name="quiet-horizontal" select="'0.075in'"/>
      <xsl:param name="quiet-vertical" select="'0.075in'"/>
      <xsl:param name="font-family" select="'Courier'"/>
      <xsl:param name="font-height" select="'6pt'"/>

      <!-- Normalize parameters and call recursive coder template -->
      <xsl:variable name="value-encoded">
        <xsl:call-template name="recursive-coder">
          <xsl:with-param name="value">
            <!-- Add FNC1 symbol if UCC/EAN selected -->
            <xsl:if test="$makeUCC='true'">
              <xsl:text>%FNC1%</xsl:text>
            </xsl:if>
            <xsl:value-of select="$value"/>            
          </xsl:with-param>
          <xsl:with-param name="subset">
            <!-- Check if correct subset selected -->
            <xsl:choose>
              <xsl:when test="string-length(translate($subset,'ABC',''))!=0">
                <xsl:message>Error: unknown subset is selected '<xsl:value-of select="$subset"/>'. Resetting subset to 'A'</xsl:message>
                <xsl:text>A</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$subset"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="sum">
            <!-- Initialize sum parameter to the value of the Start code -->
            <xsl:choose>
              <xsl:when test="$subset='A'">103</xsl:when>
              <xsl:when test="$subset='B'">104</xsl:when>
              <xsl:when test="$subset='C'">105</xsl:when>
            </xsl:choose>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:variable>

      <!-- Add start/stop characters -->
      <xsl:variable name="value-final">
        <xsl:choose>
          <xsl:when test="$subset='A'"><xsl:value-of select="document('')//my:value2bars/entry[@value='103']/text()"/></xsl:when>
          <xsl:when test="$subset='B'"><xsl:value-of select="document('')//my:value2bars/entry[@value='104']/text()"/></xsl:when>
          <xsl:when test="$subset='C'"><xsl:value-of select="document('')//my:value2bars/entry[@value='105']/text()"/></xsl:when>
        </xsl:choose>
        <xsl:value-of select="$value-encoded"/>
        <xsl:value-of select="document('')//my:value2bars/entry[@value='106']/text()"/>        
      </xsl:variable>

      <!-- Call backend to generate SVG image of the barcode -->
      <xsl:call-template name="draw-barcode">
        <xsl:with-param name="sequence" select="$value-final"/>
        <xsl:with-param name="string">
          <xsl:choose>
            <xsl:when test="string-length($string)=0">
              <xsl:value-of select="$value"/>
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


    <!-- This template makes actual data-encoding and calculates checksum-->
    <xsl:template name="recursive-coder">
      <xsl:param name="value"/>
      <xsl:param name="subset"/>
      <xsl:param name="sum" select="0"/>
      <xsl:param name="position" select="1"/>
      <xsl:param name="shift-back" select="''"/>
      
      <!-- Get first character from the sequence -->
      <xsl:variable name="char">
        <xsl:choose>
          <xsl:when test="substring($value, 1,2)='%%'">
            <xsl:text>%</xsl:text>
          </xsl:when>
          <xsl:when test="starts-with($value, '%')">
            <xsl:value-of select="substring-before(substring($value,2),'%')"/>
          </xsl:when>
          <xsl:when test="$subset='C'">
            <xsl:value-of select="substring($value,1,2)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring($value,1,1)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <!-- Get value associated with this char -->
      <xsl:variable name="char-value" select="document('')//my:char2value/entry[@char=$char and @subset=$subset]/text()"/>
      <!-- Validate, empty string means that the character is not availabe in the current subset -->
      <xsl:if test="string-length($char-value)=0">
        <!-- Error! We do a hard failure here since it's unclear how to behave otherwise -->
        <xsl:message terminate="yes">Error: character <xsl:value-of select="$char"/> is not available in <xsl:value-of select="$subset"/> code subset. Processing terminated.</xsl:message>
      </xsl:if>
      <!-- Encode char using bar states (output) -->
      <xsl:value-of select="document('')//my:value2bars/entry[@value=$char-value]/text()"/>
      <!-- Remove translated char from value -->
      <xsl:variable name="value-new">
        <xsl:choose>
          <xsl:when test="$char='%'">
            <xsl:value-of select="substring($value, 3)"/>
          </xsl:when>
          <xsl:when test="string-length($char)=1">
            <xsl:value-of select="substring($value, 2)"/>
          </xsl:when>
          <xsl:when test="string-length($char)=2 and $subset='C'">
            <xsl:value-of select="substring($value, 3)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring($value, 3 + string-length($char))"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <!-- Check if there is more chars to be encoded -->
      <!-- YES: Call recursion, switch subset when necessary -->
      <!-- NO: Calculate checksum, finish encoding -->
      <xsl:choose>
        <xsl:when test="string-length($value-new) &gt; 0">
          <xsl:call-template name="recursive-coder">
            <xsl:with-param name="value" select="$value-new"/>
            <xsl:with-param name="subset">
              <xsl:choose>
                <xsl:when test="$char='CODEA'"><xsl:text>A</xsl:text></xsl:when>
                <xsl:when test="$char='CODEB'"><xsl:text>B</xsl:text></xsl:when>
                <xsl:when test="$char='CODEC'"><xsl:text>C</xsl:text></xsl:when>
                <xsl:when test="$char='SHIFT'">
                  <xsl:if test="$subset='A'"><xsl:text>B</xsl:text></xsl:if>
                  <xsl:if test="$subset='B'"><xsl:text>A</xsl:text></xsl:if>
                </xsl:when>
                <xsl:when test="$shift-back!=''"><xsl:value-of select="$shift-back"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="$subset"/></xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="shift-back">
              <xsl:if test="$char='SHIFT'"><xsl:value-of select="$subset"/></xsl:if>
            </xsl:with-param>
            <xsl:with-param name="position" select="$position + 1"/>
            <xsl:with-param name="sum" select="$sum + $position * $char-value"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="checksum-value" select="($sum + $position * $char-value) mod 103"/>
          <!-- Encode char using bar states (output) -->
          <xsl:value-of select="document('')//my:value2bars/entry[@value=$checksum-value]/text()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>



	<!-- Code tables defined in the standard -->
	
	<my:char2value>
	    <entry char="&#x0020;" subset="A">0</entry>
	    <entry char="&#x0020;" subset="B">0</entry>
	    <entry char="00" subset="C">0</entry>
	    <entry char="!" subset="A">1</entry>
	    <entry char="!" subset="B">1</entry>
	    <entry char="01" subset="C">1</entry>
	    <entry char="&#x0022;" subset="A">2</entry>
	    <entry char="&#x0022;" subset="B">2</entry>
	    <entry char="02" subset="C">2</entry>
	    <entry char="#" subset="A">3</entry>
	    <entry char="#" subset="B">3</entry>
	    <entry char="03" subset="C">3</entry>
	    <entry char="$" subset="A">4</entry>
	    <entry char="$" subset="B">4</entry>
	    <entry char="04" subset="C">4</entry>
	    <entry char="%" subset="A">5</entry>
	    <entry char="%" subset="B">5</entry>
	    <entry char="05" subset="C">5</entry>
	    <entry char="&#x0026;" subset="A">6</entry>
	    <entry char="&#x0026;" subset="B">6</entry>
	    <entry char="06" subset="C">6</entry>
	    <entry char="$apos" subset="A">7</entry>
	    <entry char="$apos" subset="B">7</entry>
	    <entry char="07" subset="C">7</entry>
	    <entry char="(" subset="A">8</entry>
	    <entry char="(" subset="B">8</entry>
	    <entry char="08" subset="C">8</entry>
	    <entry char=")" subset="A">9</entry>
	    <entry char=")" subset="B">9</entry>
	    <entry char="09" subset="C">9</entry>
	    <entry char="*" subset="A">10</entry>
	    <entry char="*" subset="B">10</entry>
	    <entry char="10" subset="C">10</entry>
	    <entry char="+" subset="A">11</entry>
	    <entry char="+" subset="B">11</entry>
	    <entry char="11" subset="C">11</entry>
	    <entry char="," subset="A">12</entry>
	    <entry char="," subset="B">12</entry>
	    <entry char="12" subset="C">12</entry>
	    <entry char="-" subset="A">13</entry>
	    <entry char="-" subset="B">13</entry>
	    <entry char="13" subset="C">13</entry>
	    <entry char="." subset="A">14</entry>
	    <entry char="." subset="B">14</entry>
	    <entry char="14" subset="C">14</entry>
	    <entry char="/" subset="A">15</entry>
	    <entry char="/" subset="B">15</entry>
	    <entry char="15" subset="C">15</entry>
	    <entry char="0" subset="A">16</entry>
	    <entry char="0" subset="B">16</entry>
	    <entry char="16" subset="C">16</entry>
	    <entry char="1" subset="A">17</entry>
	    <entry char="1" subset="B">17</entry>
	    <entry char="17" subset="C">17</entry>
	    <entry char="2" subset="A">18</entry>
	    <entry char="2" subset="B">18</entry>
	    <entry char="18" subset="C">18</entry>
	    <entry char="3" subset="A">19</entry>
	    <entry char="3" subset="B">19</entry>
	    <entry char="19" subset="C">19</entry>
	    <entry char="4" subset="A">20</entry>
	    <entry char="4" subset="B">20</entry>
	    <entry char="20" subset="C">20</entry>
	    <entry char="5" subset="A">21</entry>
	    <entry char="5" subset="B">21</entry>
	    <entry char="21" subset="C">21</entry>
	    <entry char="6" subset="A">22</entry>
	    <entry char="6" subset="B">22</entry>
	    <entry char="22" subset="C">22</entry>
	    <entry char="7" subset="A">23</entry>
	    <entry char="7" subset="B">23</entry>
	    <entry char="23" subset="C">23</entry>
	    <entry char="8" subset="A">24</entry>
	    <entry char="8" subset="B">24</entry>
	    <entry char="24" subset="C">24</entry>
	    <entry char="9" subset="A">25</entry>
	    <entry char="9" subset="B">25</entry>
	    <entry char="25" subset="C">25</entry>
	    <entry char=":" subset="A">26</entry>
	    <entry char=":" subset="B">26</entry>
	    <entry char="26" subset="C">26</entry>
	    <entry char=";" subset="A">27</entry>
	    <entry char=";" subset="B">27</entry>
	    <entry char="27" subset="C">27</entry>
	    <entry char="&#x003C;" subset="A">28</entry>
	    <entry char="&#x003C;" subset="B">28</entry>
	    <entry char="28" subset="C">28</entry>
	    <entry char="=" subset="A">29</entry>
	    <entry char="=" subset="B">29</entry>
	    <entry char="29" subset="C">29</entry>
	    <entry char="&#x003E;" subset="A">30</entry>
	    <entry char="&#x003E;" subset="B">30</entry>
	    <entry char="30" subset="C">30</entry>
	    <entry char="?" subset="A">31</entry>
	    <entry char="?" subset="B">31</entry>
	    <entry char="31" subset="C">31</entry>
	    <entry char="@" subset="A">32</entry>
	    <entry char="@" subset="B">32</entry>
	    <entry char="32" subset="C">32</entry>
	    <entry char="A" subset="A">33</entry>
	    <entry char="A" subset="B">33</entry>
	    <entry char="33" subset="C">33</entry>
	    <entry char="B" subset="A">34</entry>
	    <entry char="B" subset="B">34</entry>
	    <entry char="34" subset="C">34</entry>
	    <entry char="C" subset="A">35</entry>
	    <entry char="C" subset="B">35</entry>
	    <entry char="35" subset="C">35</entry>
	    <entry char="D" subset="A">36</entry>
	    <entry char="D" subset="B">36</entry>
	    <entry char="36" subset="C">36</entry>
	    <entry char="E" subset="A">37</entry>
	    <entry char="E" subset="B">37</entry>
	    <entry char="37" subset="C">37</entry>
	    <entry char="F" subset="A">38</entry>
	    <entry char="F" subset="B">38</entry>
	    <entry char="38" subset="C">38</entry>
	    <entry char="G" subset="A">39</entry>
	    <entry char="G" subset="B">39</entry>
	    <entry char="39" subset="C">39</entry>
	    <entry char="H" subset="A">40</entry>
	    <entry char="H" subset="B">40</entry>
	    <entry char="40" subset="C">40</entry>
	    <entry char="I" subset="A">41</entry>
	    <entry char="I" subset="B">41</entry>
	    <entry char="41" subset="C">41</entry>
	    <entry char="J" subset="A">42</entry>
	    <entry char="J" subset="B">42</entry>
	    <entry char="42" subset="C">42</entry>
	    <entry char="K" subset="A">43</entry>
	    <entry char="K" subset="B">43</entry>
	    <entry char="43" subset="C">43</entry>
	    <entry char="L" subset="A">44</entry>
	    <entry char="L" subset="B">44</entry>
	    <entry char="44" subset="C">44</entry>
	    <entry char="M" subset="A">45</entry>
	    <entry char="M" subset="B">45</entry>
	    <entry char="45" subset="C">45</entry>
	    <entry char="N" subset="A">46</entry>
	    <entry char="N" subset="B">46</entry>
	    <entry char="46" subset="C">46</entry>
	    <entry char="O" subset="A">47</entry>
	    <entry char="O" subset="B">47</entry>
	    <entry char="47" subset="C">47</entry>
	    <entry char="P" subset="A">48</entry>
	    <entry char="P" subset="B">48</entry>
	    <entry char="48" subset="C">48</entry>
	    <entry char="Q" subset="A">49</entry>
	    <entry char="Q" subset="B">49</entry>
	    <entry char="49" subset="C">49</entry>
	    <entry char="R" subset="A">50</entry>
	    <entry char="R" subset="B">50</entry>
	    <entry char="50" subset="C">50</entry>
	    <entry char="S" subset="A">51</entry>
	    <entry char="S" subset="B">51</entry>
	    <entry char="51" subset="C">51</entry>
	    <entry char="T" subset="A">52</entry>
	    <entry char="T" subset="B">52</entry>
	    <entry char="52" subset="C">52</entry>
	    <entry char="U" subset="A">53</entry>
	    <entry char="U" subset="B">53</entry>
	    <entry char="53" subset="C">53</entry>
	    <entry char="V" subset="A">54</entry>
	    <entry char="V" subset="B">54</entry>
	    <entry char="54" subset="C">54</entry>
	    <entry char="W" subset="A">55</entry>
	    <entry char="W" subset="B">55</entry>
	    <entry char="55" subset="C">55</entry>
	    <entry char="X" subset="A">56</entry>
	    <entry char="X" subset="B">56</entry>
	    <entry char="56" subset="C">56</entry>
	    <entry char="Y" subset="A">57</entry>
	    <entry char="Y" subset="B">57</entry>
	    <entry char="57" subset="C">57</entry>
	    <entry char="Z" subset="A">58</entry>
	    <entry char="Z" subset="B">58</entry>
	    <entry char="58" subset="C">58</entry>
	    <entry char="[" subset="A">59</entry>
	    <entry char="[" subset="B">59</entry>
	    <entry char="59" subset="C">59</entry>
	    <entry char="\" subset="A">60</entry>
	    <entry char="\" subset="B">60</entry>
	    <entry char="60" subset="C">60</entry>
	    <entry char="]" subset="A">61</entry>
	    <entry char="]" subset="B">61</entry>
	    <entry char="61" subset="C">61</entry>
	    <entry char="^" subset="A">62</entry>
	    <entry char="^" subset="B">62</entry>
	    <entry char="62" subset="C">62</entry>
	    <entry char="_" subset="A">63</entry>
	    <entry char="_" subset="B">63</entry>
	    <entry char="63" subset="C">63</entry>
	    <entry char="NUL" subset="A">64</entry>
	    <entry char="`" subset="B">64</entry>
	    <entry char="64" subset="C">64</entry>
	    <entry char="SOH" subset="A">65</entry>
	    <entry char="a" subset="B">65</entry>
	    <entry char="65" subset="C">65</entry>
	    <entry char="STX" subset="A">66</entry>
	    <entry char="b" subset="B">66</entry>
	    <entry char="66" subset="C">66</entry>
	    <entry char="ETX" subset="A">67</entry>
	    <entry char="c" subset="B">67</entry>
	    <entry char="67" subset="C">67</entry>
	    <entry char="EOT" subset="A">68</entry>
	    <entry char="d" subset="B">68</entry>
	    <entry char="68" subset="C">68</entry>
	    <entry char="ENQ" subset="A">69</entry>
	    <entry char="e" subset="B">69</entry>
	    <entry char="69" subset="C">69</entry>
	    <entry char="ACK" subset="A">70</entry>
	    <entry char="f" subset="B">70</entry>
	    <entry char="70" subset="C">70</entry>
	    <entry char="BEL" subset="A">71</entry>
	    <entry char="g" subset="B">71</entry>
	    <entry char="71" subset="C">71</entry>
	    <entry char="BS" subset="A">72</entry>
	    <entry char="h" subset="B">72</entry>
	    <entry char="72" subset="C">72</entry>
	    <entry char="HT" subset="A">73</entry>
	    <entry char="i" subset="B">73</entry>
	    <entry char="73" subset="C">73</entry>
	    <entry char="LF" subset="A">74</entry>
	    <entry char="j" subset="B">74</entry>
	    <entry char="74" subset="C">74</entry>
	    <entry char="VT" subset="A">75</entry>
	    <entry char="k" subset="B">75</entry>
	    <entry char="75" subset="C">75</entry>
	    <entry char="FF" subset="A">76</entry>
	    <entry char="I" subset="B">76</entry>
	    <entry char="76" subset="C">76</entry>
	    <entry char="CR" subset="A">77</entry>
	    <entry char="m" subset="B">77</entry>
	    <entry char="77" subset="C">77</entry>
	    <entry char="SO" subset="A">78</entry>
	    <entry char="n" subset="B">78</entry>
	    <entry char="78" subset="C">78</entry>
	    <entry char="SI" subset="A">79</entry>
	    <entry char="o" subset="B">79</entry>
	    <entry char="79" subset="C">79</entry>
	    <entry char="DLE" subset="A">80</entry>
	    <entry char="p" subset="B">80</entry>
	    <entry char="80" subset="C">80</entry>
	    <entry char="DC1" subset="A">81</entry>
	    <entry char="q" subset="B">81</entry>
	    <entry char="81" subset="C">81</entry>
	    <entry char="DC2" subset="A">82</entry>
	    <entry char="r" subset="B">82</entry>
	    <entry char="82" subset="C">82</entry>
	    <entry char="DC3" subset="A">83</entry>
	    <entry char="s" subset="B">83</entry>
	    <entry char="83" subset="C">83</entry>
	    <entry char="DC4" subset="A">84</entry>
	    <entry char="t" subset="B">84</entry>
	    <entry char="84" subset="C">84</entry>
	    <entry char="NAK" subset="A">85</entry>
	    <entry char="u" subset="B">85</entry>
	    <entry char="85" subset="C">85</entry>
	    <entry char="SYN" subset="A">86</entry>
	    <entry char="v" subset="B">86</entry>
	    <entry char="86" subset="C">86</entry>
	    <entry char="ETB" subset="A">87</entry>
	    <entry char="w" subset="B">87</entry>
	    <entry char="87" subset="C">87</entry>
	    <entry char="CAN" subset="A">88</entry>
	    <entry char="x" subset="B">88</entry>
	    <entry char="88" subset="C">88</entry>
	    <entry char="EM" subset="A">89</entry>
	    <entry char="y" subset="B">89</entry>
	    <entry char="89" subset="C">89</entry>
	    <entry char="SUB" subset="A">90</entry>
	    <entry char="z" subset="B">90</entry>
	    <entry char="90" subset="C">90</entry>
	    <entry char="ESC" subset="A">91</entry>
	    <entry char="{" subset="B">91</entry>
	    <entry char="91" subset="C">91</entry>
	    <entry char="FS" subset="A">92</entry>
	    <entry char="|" subset="B">92</entry>
	    <entry char="92" subset="C">92</entry>
	    <entry char="GS" subset="A">93</entry>
	    <entry char="}" subset="B">93</entry>
	    <entry char="93" subset="C">93</entry>
	    <entry char="RS" subset="A">94</entry>
	    <entry char="~" subset="B">94</entry>
	    <entry char="94" subset="C">94</entry>
	    <entry char="US" subset="A">95</entry>
	    <entry char="DEL" subset="B">95</entry>
	    <entry char="95" subset="C">95</entry>
	    <entry char="FNC3" subset="A">96</entry>
	    <entry char="FNC3" subset="B">96</entry>
	    <entry char="96" subset="C">96</entry>
	    <entry char="FNC2" subset="A">97</entry>
	    <entry char="FNC2" subset="B">97</entry>
	    <entry char="97" subset="C">97</entry>
	    <entry char="SHIFT" subset="A">98</entry>
	    <entry char="SHIFT" subset="B">98</entry>
	    <entry char="98" subset="C">98</entry>
	    <entry char="CODEC" subset="A">99</entry>
	    <entry char="CODEC" subset="B">99</entry>
	    <entry char="99" subset="C">99</entry>
	    <entry char="CODEB" subset="A">100</entry>
	    <entry char="FNC4" subset="B">100</entry>
	    <entry char="CODEB" subset="C">100</entry>
	    <entry char="FNC4" subset="A">101</entry>
	    <entry char="CODEA" subset="B">101</entry>
	    <entry char="CODEA" subset="C">101</entry>
	    <entry char="FNC1" subset="A">102</entry>
	    <entry char="FNC1" subset="B">102</entry>
	    <entry char="FNC1" subset="C">102</entry>
	</my:char2value>
	
	<my:value2bars>
	    <entry value="0">212222</entry>
	    <entry value="1">222122</entry>
	    <entry value="2">222221</entry>
	    <entry value="3">121223</entry>
	    <entry value="4">121322</entry>
	    <entry value="5">131222</entry>
	    <entry value="6">122213</entry>
	    <entry value="7">122312</entry>
	    <entry value="8">132212</entry>
	    <entry value="9">221213</entry>
	    <entry value="10">221312</entry>
	    <entry value="11">231212</entry>
	    <entry value="12">112232</entry>
	    <entry value="13">122132</entry>
	    <entry value="14">122231</entry>
	    <entry value="15">113222</entry>
	    <entry value="16">123122</entry>
	    <entry value="17">123221</entry>
	    <entry value="18">223211</entry>
	    <entry value="19">221132</entry>
	    <entry value="20">221231</entry>
	    <entry value="21">213212</entry>
	    <entry value="22">223112</entry>
	    <entry value="23">312131</entry>
	    <entry value="24">311222</entry>
	    <entry value="25">321122</entry>
	    <entry value="26">321221</entry>
	    <entry value="27">312212</entry>
	    <entry value="28">322112</entry>
	    <entry value="29">322211</entry>
	    <entry value="30">212123</entry>
	    <entry value="31">212321</entry>
	    <entry value="32">232121</entry>
	    <entry value="33">111323</entry>
	    <entry value="34">131123</entry>
	    <entry value="35">131321</entry>
	    <entry value="36">112313</entry>
	    <entry value="37">132113</entry>
	    <entry value="38">132311</entry>
	    <entry value="39">211313</entry>
	    <entry value="40">231113</entry>
	    <entry value="41">231311</entry>
	    <entry value="42">112133</entry>
	    <entry value="43">112331</entry>
	    <entry value="44">132131</entry>
	    <entry value="45">113123</entry>
	    <entry value="46">113321</entry>
	    <entry value="47">133121</entry>
	    <entry value="48">313121</entry>
	    <entry value="49">211331</entry>
	    <entry value="50">231131</entry>
	    <entry value="51">213113</entry>
	    <entry value="52">213311</entry>
	    <entry value="53">213131</entry>
	    <entry value="54">311123</entry>
	    <entry value="55">311321</entry>
	    <entry value="56">331121</entry>
	    <entry value="57">312113</entry>
	    <entry value="58">312311</entry>
	    <entry value="59">332111</entry>
	    <entry value="60">314111</entry>
	    <entry value="61">221411</entry>
	    <entry value="62">431111</entry>
	    <entry value="63">111224</entry>
	    <entry value="64">111422</entry>
	    <entry value="65">121124</entry>
	    <entry value="66">121421</entry>
	    <entry value="67">141122</entry>
	    <entry value="68">141221</entry>
	    <entry value="69">112214</entry>
	    <entry value="70">112412</entry>
	    <entry value="71">122114</entry>
	    <entry value="72">122411</entry>
	    <entry value="73">142112</entry>
	    <entry value="74">142211</entry>
	    <entry value="75">241211</entry>
	    <entry value="76">221114</entry>
	    <entry value="77">413111</entry>
	    <entry value="78">241112</entry>
	    <entry value="79">134111</entry>
	    <entry value="80">111242</entry>
	    <entry value="81">121142</entry>
	    <entry value="82">121241</entry>
	    <entry value="83">114212</entry>
	    <entry value="84">124112</entry>
	    <entry value="85">124211</entry>
	    <entry value="86">411212</entry>
	    <entry value="87">421112</entry>
	    <entry value="88">421211</entry>
	    <entry value="89">212141</entry>
	    <entry value="90">214121</entry>
	    <entry value="91">412121</entry>
	    <entry value="92">111143</entry>
	    <entry value="93">111341</entry>
	    <entry value="94">131141</entry>
	    <entry value="95">114113</entry>
	    <entry value="96">114311</entry>
	    <entry value="97">411113</entry>
	    <entry value="98">411311</entry>
	    <entry value="99">113141</entry>
	    <entry value="100">114131</entry>
	    <entry value="101">311141</entry>
	    <entry value="102">411131</entry>
	    <entry value="103">211412</entry>
	    <entry value="104">211214</entry>
	    <entry value="105">211232</entry>
	    <entry value="106">2331112</entry>
	</my:value2bars>
	

</xsl:stylesheet>