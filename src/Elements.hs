module Elements where
import Settings
import Graphics.UI.Fungen

createBall :: GameObject ()
createBall =
  let ballPic = Basic (Circle 6.0 0.0 1.0 0.0 Filled)
  in object "ball" ballPic False (w/2,h/2) (-8,8) ()

createPlayer :: String -> GameObject ()
createPlayer player =
  let barBound = [(-25,-6),(25,-6),(25,6),(-25,6)]
      barPic   = Basic (Polyg barBound 1.0 1.0 1.0 Filled)
  in object player barPic False (w/2,30) (0,0) ()
