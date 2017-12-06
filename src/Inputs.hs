module Inputs where

import Graphics.UI.Fungen
import Graphics.UI.GLUT
import Graphics.Rendering.OpenGL (GLdouble)
import Settings

movement = [
    (Char 'W', StillDown, moveP1Up),
    (Char 'w', StillDown, moveP1Up),
    (Char 'S', StillDown, moveP1Down),
    (Char 's', StillDown, moveP1Down),
    (SpecialKey KeyUp, StillDown, moveP2Up),
    (SpecialKey KeyDown,  StillDown, moveP2Down)
    ]

moveP1Up :: Modifiers -> Position -> IOGame GameAttribute () () () ()
moveP1Up _ _ = do
  obj     <- findObject "P1" "playerGroup"
  (pX,pY) <- getObjectPosition obj
  (_,sY)  <- getObjectSize obj
  if (pY + (sY/2) + barSpeed <= h)
   then (setObjectPosition (pX,(pY + barSpeed)) obj)
   else (setObjectPosition (pX,(h - (sY/2))) obj)

moveP1Down :: Modifiers -> Position -> IOGame GameAttribute () () () ()
moveP1Down _ _ = do
  obj <- findObject "P1" "playerGroup"
  (pX,pY) <- getObjectPosition obj
  (_,sY)  <- getObjectSize obj
  if (pY - (sY/2) - barSpeed >= 0)
    then (setObjectPosition (pX, (pY - barSpeed)) obj)
    else (setObjectPosition (pX,sY/2) obj)

moveP2Up :: Modifiers -> Position -> IOGame GameAttribute () () () ()
moveP2Up _ _ = do
  obj     <- findObject "P2" "playerGroup"
  (pX,pY) <- getObjectPosition obj
  (_,sY)  <- getObjectSize obj
  if (pY + (sY/2) + barSpeed <= h)
   then (setObjectPosition (pX,(pY + barSpeed)) obj)
   else (setObjectPosition (pX,(h - (sY/2))) obj)

moveP2Down :: Modifiers -> Position -> IOGame GameAttribute () () () ()
moveP2Down _ _ = do
  obj <- findObject "P2" "playerGroup"
  (pX,pY) <- getObjectPosition obj
  (_,sY)  <- getObjectSize obj
  if (pY - (sY/2) - barSpeed >= 0)
    then (setObjectPosition (pX, (pY - barSpeed)) obj)
    else (setObjectPosition (pX,sY/2) obj)
