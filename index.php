<?php
function print_header($title)
{
	print "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">
<head>
<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"></meta>
<title>$title</title>
</head>
<body>";
}


include "quexmlpdf.php";

$splitting = array("AllowSplittingSingleChoiceVertical","AllowSplittingSingleChoiceHorizontal","AllowSplittingVas","AllowSplittingMatrixText","AllowSplittingResponses","EmbedFonts");

if(isset($_FILES['userfile']))
{
	if((!is_uploaded_file($_FILES['userfile']['tmp_name']))) {
		print "Error: Incorrectly formatted file uploaded.<br />";
		exit;
	}

	$filename = $_FILES['userfile']['tmp_name'];


  if (is_uploaded_file($_FILES['stylefile']['tmp_name']))
  {
    //need to extract orientation and format from the XML file
    $xml = new SimpleXMLElement(file_get_contents($_FILES['stylefile']['tmp_name']));
    $orientation = $xml->PageOrientation;
    $format = $xml->PageFormat;
  } else {
    $orientation = $_POST['orientation'];
    $format = $_POST['format'];
  }
 
 	// create new queXMLPDF document
  $quexmlpdf = new queXMLPDF($orientation, 'mm', $format, true, 'UTF-8', false); 
  set_time_limit(120);

  if (is_uploaded_file($_FILES['stylefile']['tmp_name']))
  {
    $quexmlpdf->importStyleXML(file_get_contents($_FILES['stylefile']['tmp_name']));
  }
  else
  {
    $quexmlpdf->setEdgeDetectionFormat($_POST['eformat']); 
  	$quexmlpdf->setStyle($_POST['style']);
  	$quexmlpdf->setResponseTextFontSize($_POST['responseTextFontSize']);
  	$quexmlpdf->setSectionHeight($_POST['sectionHeight']);
  	$quexmlpdf->setBackgroundColourQuestion($_POST['backgroundColourQuestion']);
  	$quexmlpdf->setBackgroundColourSection($_POST['backgroundColourSection']);
  	$quexmlpdf->setSingleResponseAreaHeight($_POST['singleResponseAreaHeight']);
  	$quexmlpdf->setSingleResponseHorizontalHeight($_POST['singleResponseHorizontalHeight']);
    $quexmlpdf->setQuestionnaireInfoMargin($_POST['questionnaireInfoMargin']);
    $quexmlpdf->setTextResponseWidth($_POST['textResponseWidth']);
    $quexmlpdf->setColumns($_POST['columns']);
    if ($_POST['displayCodeValues'] == "true")
      $quexmlpdf->setDisplayCodeValues(true);
    if ($_POST['RTL'] == "true")
      $quexmlpdf->setColumnRTL(true);

    foreach ($splitting as $s)
    {
      $f = "set" . $s;
      if ($_POST[$s] == "true")
        $quexmlpdf->$f(true);
      else
        $quexmlpdf->$f(false);
    }

    $quexmlpdf->setResponseLabelFontSize(array($_POST['responseLabelFontSize'],$_POST['responseLabelFontSizeSmall']));
    $quexmlpdf->setCodeValuesFontSize($_POST['codeValuesFontSize']);
    $quexmlpdf->setQuestionTextRightMargin($_POST['questionTextRightMargin']);
    $quexmlpdf->setSingleResponseVerticalAreaWidth($_POST['singleResponseVerticalAreaWidth']);
    $quexmlpdf->setSingleResponseVerticalAreaWidthSmall($_POST['singleResponseVerticalAreaWidthSmall']);
    $quexmlpdf->setSingleResponseHorizontalMax($_POST['singleResponseHorizontalMax']);
    $quexmlpdf->setMainFont($_POST['mainFont']);
  }

	$quexmlpdf->create($quexmlpdf->createqueXML(file_get_contents($filename)));
  $quexmlpdf->savePageFormat($format);

	//NEED TO GET QID from $quexmlpdf
	$qid = intval($quexmlpdf->getQuestionnaireId());

	$zip = new ZipArchive();
	$filename = tempnam("/tmp", "queXMLPDF") . ".zip";
	
	if ($zip->open($filename, ZIPARCHIVE::CREATE)!==TRUE) {
	    exit("cannot open temporary file\n");
	}
	
	$zip->addFromString("quexf_banding_$qid.xml", $quexmlpdf->getLayout());
	$zip->addFromString("quexmlpdf_style_$qid.xml", $quexmlpdf->exportStyleXML());
	$zip->addFromString("quexmlpdf_$qid.pdf", $quexmlpdf->Output("quexml_$qid.pdf", 'S'));
	$zip->close();
	
	header('Content-Type: application/octet-stream');
	header('Content-Disposition: attachment; filename="quexmlpdf_' . $qid . '.zip"'); 
	header('Content-Transfer-Encoding: binary');
	// load the file to send:
	readfile($filename);
	unlink($filename);

}
else
{

	print_header("queXML Tools: Create PDF with banding XML for queXF from queXML");

	$quexmlpdf = new queXMLPDF(PDF_PAGE_ORIENTATION, 'mm', PDF_PAGE_FORMAT, true, 'UTF-8', false);

	?>
	<h1>queXML to PDF and banding XML for queXF</h1>
	<p>If the file is valid queXML: a ZIP file containing a PDF and an XML file for banding using <a href='http://quexf.sourceforge.net'>queXF</a> will be returned</p>
	<br>
		<form enctype="multipart/form-data" action="?" method="post">
			<input type="hidden" name="MAX_FILE_SIZE" value="1000000000" />
			<label for="userfile">Choose a queXML file to upload: </label><input name="userfile" type="file" /><br/>
			<label for="stylefile">(Optional otherwise set below) Choose a queXML style settings file to upload: </label><input name="stylefile" type="file" /><br/>
			<div><label for="style">Style:</label><textarea name="style" id="style" cols="120" rows="14"><?php echo $quexmlpdf->getStyle(); ?></textarea></div>
			<div><label for="responseTextFontSize">Response text / sub question font size</label><input name="responseTextFontSize" type="text" value="<?php echo $quexmlpdf->getResponseTextFontSize();?>"/></div>
			<div><label for="responseLabelFontSize">Response label font size (normal)</label><input name="responseLabelFontSize" type="text" value="<?php $t = $quexmlpdf->getResponseLabelFontSize(); echo $t[0];?>"/></div>
			<div><label for="responseLabelFontSizeSmall">Response label font size (small)</label><input name="responseLabelFontSizeSmall" type="text" value="<?php $t = $quexmlpdf->getResponseLabelFontSize(); echo $t[1];?>"/></div>
      <div><label for="sectionHeight">Minimum section height (mm)</label><input name="sectionHeight" type="text" value="<?php echo $quexmlpdf->getSectionHeight();?>"/></div>
      <div><label for="questionnaireInfoMargin">Margin before questionnaireInfo element (mm)</label><input name="questionnaireInfoMargin" type="text" value="<?php echo $quexmlpdf->getQuestionnaireInfoMargin();?>"/></div>
      <div><label for="questionTextRightMargin">Right hand margin of question text (mm)</label><input name="questionTextRightMargin" type="text" value="<?php echo $quexmlpdf->getQuestionTextRightMargin();?>"/></div>
      <div><label for="singleResponseAreaHeight">Minimum height of single choice response boxes</label><input name="singleResponseAreaHeight" type="text" value="<?php echo $quexmlpdf->getSingleResponseAreaHeight();?>"/></div>
      <div><label for="singleResponseHorizontalHeight">Minimum height of sub question items</label><input name="singleResponseHorizontalHeight" type="text" value="<?php echo $quexmlpdf->getSingleResponseHorizontalHeight();?>"/></div>
      <div><label for="singleResponseVerticalAreaWidth">Gap between horizontally displayed single choice response boxes (where less than number to display before shrinking)</label><input name="singleResponseVerticalAreaWidth" type="text" value="<?php echo $quexmlpdf->getSingleResponseVerticalAreaWidth();?>"/></div>
      <div><label for="singleResponseVerticalAreaWidthSmall">Gap between horizontally displayed single choice response boxes (when should shrink)</label><input name="singleResponseVerticalAreaWidthSmall" type="text" value="<?php echo $quexmlpdf->getSingleResponseVerticalAreaWidthSmall();?>"/></div>
      <div><label for="singleResponseHorizontalMax">Number of horizontally displayed single choice items before shrinking gap between them</label><input name="singleResponseHorizontalMax" type="text" value="<?php echo $quexmlpdf->getSingleResponseHorizontalMax();?>"/></div>
      <div><label for="textResponseWidth">Width of a text response box (single character) in mm</label><input name="textResponseWidth" type="text" value="<?php echo $quexmlpdf->getTextResponseWidth();?>"/></div>
      <div><label for="backgroundColourQuestion">Background colour for question (0 black - 255 white)</label><input name="backgroundColourQuestion" type="text" value="<?php echo $quexmlpdf->getBackgroundColourQuestion();?>"/></div>
      <div><label for="backgroundColourSection">Background colour for section (0 black - 255 white)</label><input name="backgroundColourSection" type="text" value="<?php echo $quexmlpdf->getBackgroundColourSection();?>"/></div>
      <div><label for="orientation">Page orientation</label><select name="orientation"><option value="P">Portrait</option><option value="L">Landscape</option></select></div>
      <div><label for="format">Page format</label><select name="format"><option value="A4">A4</option><option value="A3">A3</option><option value="USLETTER">USLETTER</option></select></div>
      <div><label for="eformat">Edge detection format</label><select name="eformat"><option value="lines">Corner lines</option><option value="boxes">Corner boxes</option></select></div>
      <div><label for="displayCodeValues">Display code values and variable names?</label><select name="displayCodeValues"><option value="false">No</option><option value="true">Yes</option></select></div>
      <div><label for="codeValuesFontSize">Code value font size</label><input name="codeValuesFontSize" type="text" value="<?php echo $quexmlpdf->getCodeValuesFontSize();?>"/></div>
      <div><label for="columns">Number of columns to display</label><select name="columns"><option value="1">1</option><option value="2">2</option><option value="3">3</option></select></div>
      <div><label for="RTL">Make columns display RTL?</label><select name="RTL"><option value="false" selected="selected">No</option><option value="true">Yes</option></select></div>
      <div><label for="mainFont">Default font</label><select name="mainFont"><?php $fonts = $quexmlpdf->listFonts(); $fonts = array_unique($fonts); sort($fonts); foreach($fonts as $f) { $sel = ""; if($f == "freeserif") {$sel = "selected='selected'";} print "<option $sel value='$f'>$f</option>"; }?></select></div>
<?php 
      foreach($splitting as $s)
      {
        $f = "get" . $s;
        $sn = $sy = "";
        if ($quexmlpdf->$f())
          $sy = "selected='selected'";
        else
          $sn = "selected='selected'";

        print "<div><label for='$s'>$s</label><select name='$s'><option $sn value='false'>No</option><option $sy value='true'>Yes</option></select></div>";
      }
      ?>
      <input type="submit" value="Upload File" />
		</form>
	</body>
	</html>
	<?php
}
?>
