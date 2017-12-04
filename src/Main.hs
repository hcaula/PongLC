import Bindings
import Control.Concurrent
import Graphics.UI.Fungen

data GameAttribute = GA Int Int

scoreLeftPlayer = 0
scoreRightPlayer = 0

main :: IO ()
main = do
  let winConfig     = ((0, 0), (250, 250), "PongLC")
      leftRacket    = objectGroup "racketGroup" [createRacket]
      rightRacket   = objectGroup "racketGroup" [createRacket]
      ball          = objectGroup "ballGroup" [createBall]
      gameMap       = colorMap 0 0 0 250 250
      gameAttribute = GA scoreLeftPlayer scoreRightPlayer
      bindings      = [(SpecialKey KeyUp, StillDown, moveRacketUp), (SpacialKey, StillDown, moveRacketDown)]
  funInit winConfig gameMap [leftRacket, rightRacket, ball] () gameAttribute bindings ()
