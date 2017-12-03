import Graphics.UI.GLUT
import Data.IORef
import Bindings
import Display

main :: IO ()
main = do
  (_progName, _args) <- getArgsAndInitialize
  _window <- createWindow "PongLC"
  rightRacketPos <- newIORef (0, 0)
  keyboardMouseCallback $= Just (keyboardMouse rightRacketPos)
  -- idleCallback $= Just (idle angle delta)
  displayCallback $= display rightRacketPos
  mainLoop
