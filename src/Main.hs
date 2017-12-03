import Graphics.UI.GLUT
import Data.IORef
import Bindings
import Display

main :: IO ()
main = do
  (_progName, _args) <- getArgsAndInitialize
  _window <- createWindow "PongLC"
  angle <- newIORef 0
  delta <- newIORef 0.1
  rightRacketPos <- newIORef (0, 0)
  keyboardMouseCallback $= Just (keyboardMouse delta rightRacketPos)
  idleCallback $= Just (idle angle delta)
  displayCallback $= display rightRacketPos
  mainLoop
