<?php

/**
 * Example use of the queXMLPDF class
 * Create a PDF and queXF banding XML file from the test_questionnaire file
 * and output it in a ZIP archive
 *
 * Currently available for use online at:
 * https://surveys.acspri.org.au/quexmltools/
 *
 */

require_once('quexmlpdf.php');

// create new queXMLPDF document
$quexmlpdf = new queXMLPDF(PDF_PAGE_ORIENTATION, 'mm', PDF_PAGE_FORMAT, true, 'UTF-8', false);

set_time_limit(120);

$quexmlpdf->create($quexmlpdf->createqueXML(file_get_contents("test_questionnaire.xml")));

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
