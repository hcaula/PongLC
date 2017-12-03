import Graphics.UI.GLUT
import Data.IORef
import Bindings
import Display

main :: IO ()
main = do
  -- Initialize OpenGL libraries
  (_progName, _args) <- getArgsAndInitialize

  -- Create the Window
  _window <- createWindow "PongLC"

  -- Initialize left and right paddles
  rightRacketPos <- newIORef (0, 0)
  leftRacketPos <- newIORef (0, 0)

  -- Call the keyboard event
  keyboardMouseCallback $= Just (keyboardMouse rightRacketPos leftRacketPos)

  -- Call idle event (responsible for animations)
  idleCallback $= Just (idle)

  -- Call display events (we do stuff here)
  -- rightRacketPos and leftRacketPos are parameters that
  -- are updated in the keyboardMouse function (defined on
  -- Bindings.hs file)
  displayCallback $= display rightRacketPos leftRacketPos

  -- Loop
  mainLoop
