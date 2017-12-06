module Inputs where

import Graphics.UI.Fungen
import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL (GLdouble)
import Settings

data GameAttribute = Score Int

movement = [
    (Char 'W', StillDown, moveBar),
    (Char 'w', StillDown, moveBar),
    (Char 'S', StillDown, moveBar),
    (Char 's', StillDown, moveBar),
    (SpecialKey KeyUp, StillDown, moveBar),
    (SpecialKey KeyDown,  StillDown, moveBar)
    ]

moveBar :: Modifiers -> Position -> IOGame GameAttribute () () () ()
moveBar _ _ = do
  obj     <- findObject "P1" "playerGroup"
  (pX,pY) <- getObjectPosition obj
  (sX,_)  <- getObjectSize obj
  if (pX + (sX/2) + 5 <= w)
   then (setObjectPosition ((pX + 5),pY) obj)
   else (setObjectPosition ((w - (sX/2)),pY) obj)
