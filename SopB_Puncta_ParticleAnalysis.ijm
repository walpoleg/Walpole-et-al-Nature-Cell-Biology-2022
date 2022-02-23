//Calculates A Trous Algorithm wavelet product
	run("Clear Results")
	roiManager("reset");
	run("ATrousJ_Filter", "scales=3 wavelet=0.30");
	
//User-generated transfected cell ROI
  	title ="WaitForUserDemo";
  	msg1 = "Select transfected cell ROI, then click \"OK\".";
  	msg2 = "Please select transfected image, then click \"OK\".";
  		setTool("freehand");
  		waitForUser(title, msg1);
  		roiManager("add");
  		run("Select None");
  		selectWindow("Output");
  		roiManager("Select", 0);
  		setBackgroundColor(0, 0, 0);
		run("Clear Outside");
		setOption("ScaleConversions", true);
		run("8-bit");
		run("Auto Local Threshold", "method=Bernsen radius=3 parameter_1=0 parameter_2=0 white");

//Analyze particles, add to ROI manager
		run("Analyze Particles...", "size=0-200 circularity=0.50-1.00 show=Nothing summarize add");

//Apply particle masks to raw image file
		waitForUser(title, msg2);
		close("\\Others")
	imageTitle = getTitle();//returns a string with the image title

//Measures binary image particles
		selectWindow(imageTitle);
		roiManager("Measure");

//Copy for pasting in excel
String.copyResults();
