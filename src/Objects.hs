module Objects where

-- Our modules
import Globals

-- External libraries
import Graphics.UI.Fungen
import Graphics.Rendering.OpenGL (GLdouble)

createBall :: GameObject ()
createBall =
  -- The ballBound is set on Globals.hs
  let ballBound = ball
      -- Creates the for sided poligon
      ballPic = Basic (Polyg ballBound 1.0 1.0 1.0 Filled)
  in object "ball" ballPic False (w/2,h/2) (-ballInitialSpeed,0) ()

createPlayer :: String -> GameObject ()
createPlayer player =
  -- The barBound is set on Globals.hs
  let barBound = bar
      barPic   = Basic (Polyg barBound 1.0 1.0 1.0 Filled)
  in object player barPic False (initialPosition player) (0,0) ()

createScore :: String -> GameObject ()
createScore player =
  let scorePic = Tex fontSize 1
  in object player scorePic False (scorePosition player) (0,0) ()

createMiddleLine :: Integer -> GameObject ()
createMiddleLine line =
  let mlBound = middleLine
      mlPic   = Basic (Polyg mlBound 1.0 1.0 1.0 Filled)
  in object "Line #" mlPic False (middleLinePosition line) (0,0) ()

-- Auxiliar function to get each player initial position
initialPosition :: String -> (GLdouble, GLdouble)
initialPosition player =
  if player == "P1" then (offset, h/2)
  else if player == "P2" then (w-offset, h/2);
  else (0,0)


scorePosition :: String -> (GLdouble, GLdouble)
scorePosition player =
  if player == "ScoreP1" then (w/2 - (fst fontSize)*2, h - 80)
  else if player == "ScoreP2" then (w/2 + (fst fontSize)*2, h - 80);
  else (0,0)

middleLinePosition :: Integer -> (GLdouble, GLdouble)
middleLinePosition line = (w/2, h/10 * (fromIntegral line) * 2)
