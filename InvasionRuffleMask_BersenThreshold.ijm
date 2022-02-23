//Calculates Auto Local Threshold and crops to ROI
macro "Bernsen Local Threshold PM (invasion site) " {
	run("Clear Results");
	print("\\Clear");
	roiManager("reset");
		CellMask = getImageID();
		run("Smooth");
		setOption("ScaleConversions", true);
		run("8-bit");
		run("Auto Local Threshold", "method=Bernsen radius=3 parameter_1=0 parameter_2=0 white");
		run("Despeckle");
		
//User opens file and inputs ROI of transfected cell
  	title ="WaitForUserDemo";
  	msg1 = "Select transfected cell ROI, then click \"OK\".";
  	msg15 = "Select invasion site ROI, then click \"OK\".";
  	msg2 = "Select transfected cytosol ROI, then click \"OK\".";
  	msg3 = "Select background intensity, then click \"OK\".";
  	msg4 = "Please select transfected image, then click \"OK\".";
  		waitForUser(title, msg1);
  		roiManager("add");
  		run("Select None");
			setTool("oval");
			makeOval(221, 194, 100, 100);
			waitForUser(title, msg15);
			roiManager("add");
			run("Select None");
  		  		setTool("freehand");
  		  		waitForUser(title, msg2);
  				roiManager("add");
  				run("Select None");
  					waitForUser(title, msg3);
  					roiManager("add");
  					run("Select None");
  		selectImage(CellMask);
  		roiManager("Select", 0);
  		setBackgroundColor(0, 0, 0);
		run("Clear Outside");
			roiManager("Select", 1);
			run("Clear Outside");
			run("Create Selection");
			roiManager("Add");
				waitForUser(title, msg4);
				close("\\Others")
	imageTitle = getTitle();//returns a string with the image title

//Measures thresholded intensity, cytosolic intensity, and background intensity
		selectWindow(imageTitle);
		roiManager("Select", 4);
		roiManager("Measure");
		roiManager("Select", 2);
		roiManager("Measure");
		roiManager("Select", 3);
		roiManager("Measure");		
		close();
}
