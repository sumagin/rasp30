// clear the console window
clc 

//Turn off the warning messages in the console
previousprot = funcprot(1) //integer with possible values 0, 1, 2 returns previous value
funcprot(0) //allows the user to specify what scilab will do when such variables are redefined. 0=nothing, 1=warning, 2=error

// Import some useful Xcos macros into Scilab.
loadXcosLibs(); 

//Loads all .sci files (containing Scilab functions) defined in the path directory.
//Location of all block files
getd('/home/ubuntu/RASP_Workspace/block_files/') ;

//////////////////////////////////////////////////////////////////////
////////////////////Commands for Block Appearance/////////////////////
//////////////////////////////////////////////////////////////////////

//Create custom palette(s) for all blocks 

// Reference Websites:
//                    https://help.scilab.org/docs/5.5.1/ru_RU/xcosPal.html
//                    https://help.scilab.org/docs/5.5.1/ru_RU/xcosPalAddBlock.html
//                    https://help.scilab.org/docs/5.5.1/ru_RU/xcosPalAdd.html


pal = xcosPal("My Block"); //Instanciate a new xcos palette [Can be a ubcategory]


// Add blocks to the palette

//Create block icon

//Set the style of each icon
style= struct();
style.noLabel=0;
style.align="center";
style.fontSize=16;
style.overflow="fill";

style.displayedLabel="Sample";
pal = xcosPalAddBlock(pal,"newblock",[],style);



//Add palettes to Palette Browser
xcosPalAdd(pal,["ECE6435"]); //You can change this top level palette name

//Turn the warning messages back on to be displayed in console
funcprot(previousprot)
