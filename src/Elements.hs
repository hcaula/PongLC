module Elements where
import Settings
import Graphics.UI.Fungen
import Graphics.Rendering.OpenGL (GLdouble)

createBall :: GameObject ()
createBall =
  let ballBound = ball
      ballPic = Basic (Polyg ballBound 1.0 1.0 1.0 Filled)
  in object "ball" ballPic False (w/2,h/2) (-8,8) ()

createPlayer :: String -> GameObject ()
createPlayer player =
  let barBound = bar
      barPic   = Basic (Polyg barBound 1.0 1.0 1.0 Filled)
  in object player barPic False (initialPosition player) (0,0) ()

initialPosition :: String -> (GLdouble, GLdouble)
initialPosition player =
  if player == "P1" then (offset, h/2)
  else if player == "P2" then (w-offset, h/2);
  else (0,0)
