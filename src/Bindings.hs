module Bindings (idle,display, reshape, keyboardMouse) where

import Graphics.UI.GLUT
import Data.IORef
import Display

reshape :: ReshapeCallback
reshape size = do
  viewport $= (Position 0 0, size)

keyboardMouse :: IORef (GLfloat, GLfloat) -> IORef (GLfloat, GLfloat) -> KeyboardMouseCallback
keyboardMouse right left key Down _ _ = case key of
  (SpecialKey KeyUp   ) -> right $~! \(x,y) -> (x,y+0.1)
  (SpecialKey KeyDown   ) -> right $~! \(x,y) -> (x,y-0.1)
  (Char 'w') -> left $~! \(x,y) -> (x,y+0.1)
  (Char 'W') -> left $~! \(x,y) -> (x,y+0.1)
  (Char 's') -> left $~! \(x,y) -> (x,y-0.1)
  (Char 'S') -> left $~! \(x,y) -> (x,y-0.1)
  _-> return ()
keyboardMouse _ _ _ _ _ _ = return ()
