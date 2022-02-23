//Calculates A Trous Algorithm wavelet product, thresholds, and crops to ROI
macro "A Trous Wavelet Decomposition and Binary Threshold" {
		run("Clear Results")
		roiManager("reset");
		run("ATrousJ_Filter", "scales=3 wavelet=0.10");
		
//Calculates standard deviation of A Trous filtered image		
	StdDev = getValue("StdDev raw");
	Factor = 1.5;
	Threshold = StdDev*Factor;
		print(Threshold);
		setAutoThreshold("Default dark no-reset");
		
//Thresholds filtered image
		setThreshold(Threshold, 1000000000000000000000000000000.0000);
		setOption("BlackBackground", true);
		run("Convert to Mask");

//User opens file and inputs ROI of transfected cell
  	title ="WaitForUserDemo";
  	msg1 = "Select transfected cell ROI, then click \"OK\".";
  	msg2 = "Select transfected cytosol ROI, then click \"OK\".";
  	msg3 = "Select background intensity, then click \"OK\".";
  	msg4 = "Please select transfected image, then click \"OK\".";
  		waitForUser(title, msg1);
  		roiManager("add");
  		run("Select None");
  		waitForUser(title, msg2);
  		roiManager("add");
  		run("Select None");
  		waitForUser(title, msg3);
  		roiManager("add");
  		run("Select None");
  		selectWindow("Output");
  		roiManager("Select", 0);
  		setBackgroundColor(0, 0, 0);
		run("Clear Outside");
		run("Create Selection");
		roiManager("Add");
		waitForUser(title, msg4);
		close("\\Others")
	imageTitle = getTitle();//returns a string with the image title

//Measures thresholded intensity, cytosolic intensity, and background intensity
		selectWindow(imageTitle);
		roiManager("Select", 3);
		roiManager("Measure");
		roiManager("Select", 1);
		roiManager("Measure");
		roiManager("Select", 2);
		roiManager("Measure");		
		close();
}
