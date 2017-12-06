module Objects where
import Globals
import Graphics.UI.Fungen
import Graphics.Rendering.OpenGL (GLdouble)

createBall :: GameObject ()
createBall =
  -- The ballBound is set on Globals.hs
  let ballBound = ball
      ballPic = Basic (Polyg ballBound 1.0 1.0 1.0 Filled)
  in object "ball" ballPic False (w/2,h/2) (ballInitialSpeed,ballInitialSpeed) ()

createPlayer :: String -> GameObject ()
createPlayer player =
  -- The barBound is set on Globals.hs
  let barBound = bar
      barPic   = Basic (Polyg barBound 1.0 1.0 1.0 Filled)
  in object player barPic False (initialPosition player) (0,0) ()

-- Auxiliar function to get each player initial position
initialPosition :: String -> (GLdouble, GLdouble)
initialPosition player =
  if player == "P1" then (offset, h/2)
  else if player == "P2" then (w-offset, h/2);
  else (0,0)
