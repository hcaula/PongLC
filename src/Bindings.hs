module Bindings (idle,display, reshape, keyboardMouseRight, keyboardMouseLeft) where

import Graphics.UI.GLUT
import Data.IORef
import Display

reshape :: ReshapeCallback
reshape size = do
  viewport $= (Position 0 0, size)

keyboardMouseRight :: IORef (GLfloat, GLfloat) -> KeyboardMouseCallback
keyboardMouseRight right key Down _ _ = case key of
  (SpecialKey KeyUp   ) -> right $~! \(x,y) -> (x,y+0.1)
  (SpecialKey KeyDown   ) -> right $~! \(x,y) -> (x,y-0.1)
  _-> return ()
keyboardMouseRight _ _ _ _ _ = return ()

keyboardMouseLeft :: IORef (GLfloat, GLfloat) -> KeyboardMouseCallback
keyboardMouseLeft left key Down _ _ = case key of
  (Char 'w') -> left $~! \(x,y) -> (x,y+0.1)
  (Char 'W') -> left $~! \(x,y) -> (x,y+0.1)
  (Char 's') -> left $~! \(x,y) -> (x,y-0.1)
  (Char 'S') -> left $~! \(x,y) -> (x,y-0.1)
  _-> return ()
keyboardMouseLeft _ _ _ _ _ = return ()
