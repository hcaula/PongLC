module Bindings (idle,display, reshape, keyboardMouse) where

import Graphics.UI.GLUT
import Data.IORef
import Display

reshape :: ReshapeCallback
reshape size = do
  viewport $= (Position 0 0, size)

keyboardMouse :: IORef GLfloat -> IORef (GLfloat, GLfloat) -> KeyboardMouseCallback
keyboardMouse a right key Down _ _ = case key of
  -- (Char ' ') -> a $~! negate
  -- (Char '+') -> a $~! (* 2)
  -- (Char '-') -> a $~! (/ 2)
  (SpecialKey KeyUp   ) -> right $~! \(x,y) -> (x,y+0.1)
  (SpecialKey KeyDown   ) -> right $~! \(x,y) -> (x,y-0.1)
  _ -> return ()
keyboardMouse _ _ _ _ _ _ = return ()
