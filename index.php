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

if(isset($_FILES['userfile']))
{
	if((!is_uploaded_file($_FILES['userfile']['tmp_name']))) {
		print "Error: Incorrectly formatted file uploaded.<br />";
		exit;
	}

	$filename = $_FILES['userfile']['tmp_name'];
	
	// create new queXMLPDF document
	$quexmlpdf = new queXMLPDF(PDF_PAGE_ORIENTATION, 'mm', PDF_PAGE_FORMAT, true, 'UTF-8', false);

	set_time_limit(120);

	$quexmlpdf->setStyle($_POST['style']);
	$quexmlpdf->setResponseTextFontSize($_POST['responseTextFontSize']);
	$quexmlpdf->setSectionHeight($_POST['sectionHeight']);
	$quexmlpdf->setResponseLabelFontSize(array($_POST['responseLabelFontSize'],$_POST['responseLabelFontSizeSmall']));

	$quexmlpdf->create($quexmlpdf->createqueXML(file_get_contents($filename)));

	//NEED TO GET QID from $quexmlpdf
	$qid = intval($quexmlpdf->getQuestionnaireId());

	$zip = new ZipArchive();
	$filename = tempnam("/tmp", "queXMLPDF") . ".zip";
	
	if ($zip->open($filename, ZIPARCHIVE::CREATE)!==TRUE) {
	    exit("cannot open temporary file\n");
	}
	
	$zip->addFromString("quexf_banding_$qid.xml", $quexmlpdf->getLayout());
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
			Choose a queXML file to upload: <input name="userfile" type="file" /><br/>
			<div><label for="style">Style:</label><textarea name="style" id="style" cols="120" rows="14"><?php echo $quexmlpdf->getStyle(); ?></textarea></div>
			<div><label for="responseTextFontSize">Response text / sub question font size</label><input name="responseTextFontSize" type="text" value="<?php echo $quexmlpdf->getResponseTextFontSize();?>"/></div>
			<div><label for="responseLabelFontSize">Response label font size (normal)</label><input name="responseLabelFontSize" type="text" value="<?php $t = $quexmlpdf->getResponseLabelFontSize(); echo $t[0];?>"/></div>
			<div><label for="responseLabelFontSizeSmall">Response label font size (small)</label><input name="responseLabelFontSizeSmall" type="text" value="<?php $t = $quexmlpdf->getResponseLabelFontSize(); echo $t[1];?>"/></div>
			<div><label for="sectionHeight">Minimum section height (mm)</label><input name="sectionHeight" type="text" value="<?php echo $quexmlpdf->getSectionHeight();?>"/></div>
			<input type="submit" value="Upload File" />
		</form>
	</body>
	</html>
	<?php
}
?>