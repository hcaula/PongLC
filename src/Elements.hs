module Elements where
import Graphics.UI.GLUT

-- Converts our entries to OpenGL usable format
vertex3f :: (GLfloat, GLfloat, GLfloat) -> IO ()
vertex3f (x, y, z) = vertex $ Vertex3 x y z

-- Renders the rackets, taking which side to render as parameter
racket :: String -> Float -> IO()
racket side y' =
  if side == "Left" then
    renderPrimitive Quads $ mapM_ vertex3f [(0.8,y',0), (0.9,y',0),(0.9,(0.5+y'),0),(0.8,(0.5+y'),0)]
  else if side == "Right" then
    renderPrimitive Quads $ mapM_ vertex3f [(-0.8,0,0), (-0.9,0,0),(-0.9,-0.5,0),(-0.8,-0.5,0)]
  else
    renderPrimitive Quads $ mapM_ vertex3f [(0,0,0), (0,0,0),(0,0,0),(0,0,0)]
