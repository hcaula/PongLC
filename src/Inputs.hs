module Inputs where

-- Our modules
import Globals

-- External libraries
import Graphics.UI.Fungen

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

  -- Gets the player object
  obj <- findObject "P1" "playerGroup"

  -- Sets its position to the pX and pY attrs
  (pX,pY) <- getObjectPosition obj

  -- Sets its Y size to the sY size
  (_,sY)  <- getObjectSize obj

  -- If the object won't pass the screen after adding the movement
  if (pY + (sY/2) + barSpeed <= h)
    -- Sum its y position to the barSpeed (established in Globals.hs)
   then (setObjectPosition (pX,(pY + barSpeed)) obj)
   -- Else, lock it to the maximum height position
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
  obj <- findObject "P2" "playerGroup"
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
