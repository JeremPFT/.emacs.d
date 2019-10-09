REM shortcut.vbs --- Print the target of a Microsoft Explorer shortcut
REM
REM   Author:   Peter Breton
REM   Created:  Fri Sep 06 2002
REM   Version:  $Id: shortcut.vbs,v 1.2 2002/09/06 15:15:47 pbreton Exp $

REM This file is NOT part of GNU Emacs, but is distributed in
REM the same spirit.
REM
REM GNU Emacs is free software; you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published
REM by the Free Software Foundation; either version 2, or (at your
REM option) any later version.

REM Ensure that this script has at least one argument
If WScript.Arguments.length < 1 Then
  WScript.Quit
End If

linkFile = WScript.Arguments (0)
   
REM Open the shortcut (despite the name, this does not create it)
Set link = WScript.CreateObject("WScript.Shell").CreateShortcut(linkFile)

WScript.Echo link.TargetPath