// Code to generate binary mask of PE-Rhodamine for Intensity analysis
setTool("oval");
run("Clear Results");
roiManager("reset");
title = "WaitForUserDemo";
  msg = "Manually select liposome ROI, then click \"OK\".";
  waitForUser(title, msg);
  roiManager("Add");
  
//binary annular mask of liposome surface
setAutoThreshold("Otsu dark no-reset");
setOption("BlackBackground", true);
run("Convert to Mask");
roiManager("Select", 0);
setBackgroundColor(0, 0, 0);
run("Clear Outside");
run("Fill Holes");
run("Erode");
run("Erode");
run("Outline");
run("Dilate");
run("Create Selection");
roiManager("Add");
close();

//binary mask of medium in annulus outside liposome surface
newImage("Mask", "8-bit black", 512, 512, 1);
roiManager("Select", 1);
setForegroundColor(255, 255, 255);
run("Fill", "slice");
run("Select None");
run("Fill Holes");
setOption("BlackBackground", true);
run("Dilate");
run("Dilate");
run("Dilate");
run("Dilate");
run("Dilate");
run("Dilate");
run("Dilate");
run("Dilate");
run("Outline");
run("Dilate");
run("Create Selection");
roiManager("Add");
close();	
