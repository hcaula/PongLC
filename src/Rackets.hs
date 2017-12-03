module Rackets where
  import Graphics.UI.GLUT
  racket :: String -> [(GLfloat,GLfloat,GLfloat)]
  racket side =
    if side == "Left" then
      [(0.8,0,0), (0.9,0,0),(0.9,0.5,0),(0.8,0.5,0)]
    else if side == "Right" then
      [(-0.8,0,0), (-0.9,0,0),(-0.9,-0.5,0),(-0.8,-0.5,0)]
    else
      [(0,0,0), (0,0,0),(0,0,0),(0,0,0)]
