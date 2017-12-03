import Graphics.UI.GLUT
import Data.IORef
import Bindings
import Display

main :: IO ()
main = do
  (_progName, _args) <- getArgsAndInitialize
  _window <- createWindow "PongLC"

  rightRacketPos <- newIORef (0, 0)
  leftRacketPos <- newIORef (0, 0)

  keyboardMouseCallback $= Just (keyboardMouse rightRacketPos leftRacketPos)

  idleCallback $= Just (idle)
  displayCallback $= display rightRacketPos leftRacketPos

  mainLoop
