import Graphics.UI.GLUT
import Rackets

main :: IO ()
main = do
  (_progName, _args) <- getArgsAndInitialize
  _window <- createWindow "PongLC"
  displayCallback $= display
  mainLoop

display :: DisplayCallback
display = do
  let color3f r g b = color $ Color3 r g (b :: GLfloat)
      vertex3f x y z = vertex $ Vertex3 x y (z :: GLfloat)
  clear [ColorBuffer]
  renderPrimitive Quads $ do
    mapM_ (\(x, y, z) -> vertex $ Vertex3 x y z) (racket "Left")
    mapM_ (\(x, y, z) -> vertex $ Vertex3 x y z) (racket "Right")
  flush
