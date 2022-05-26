# LEGO.scad

An OpenSCAD LEGO-compatible brick generator.

## Refactor

The original scad file was one big massive file that was hard to change without breaking something in-advertantly. I have broken these files down into moduels which should be easier for you to take and compose and build your own brick styles. 

+ block.scad - Will generate a rectangular block with no studs
+ brick.scad - The most basic lego brick you can make. 
+ common.scad - Contains common dimensions that make the bricks compatible. This would be the file you would adjust for your own printer variances. 
+ posts.scad - This will generate pins or posts for the underside of the bricks. 
+ 

## Recognition 

+ http://www.thingiverse.com/thing:5699
+ http://www.chrisfinke.com/2015/01/27/3d-printed-lego-compatible-bricks/

These blocks are not strictly identical to LEGO bricks, but they should be compatible in most every way.
