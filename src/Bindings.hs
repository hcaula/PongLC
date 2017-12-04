module Bindings (idle,display, reshape, keyboardMouseRight, keyboardMouseLeft) where

import Graphics.UI.GLUT
import Data.IORef
import Display

-- Makes sure the resize of the windows is functional
reshape :: ReshapeCallback
reshape size = do
  viewport $= (Position 0 0, size)

-- Gets the keyboard inputs and appropriately elevates the y value passed
keyboardMouseRight :: IORef (GLfloat, GLfloat) -> KeyboardMouseCallback
keyboardMouseRight right key Down _ _ = case key of
  (SpecialKey KeyUp   ) -> right $~! \(x,y) -> (x,y+0.1)
  (SpecialKey KeyDown   ) -> right $~! \(x,y) -> (x,y-0.1)
  _-> return ()
keyboardMouseRight _ _ _ _ _ = return ()

keyboardMouseLeft :: IORef (GLfloat, GLfloat) -> KeyboardMouseCallback
keyboardMouseLeft left key Down _ _ = case key of

  -- Repeat for lower and uppercase, because Haskell
  -- actually takes input from a string that the user
  -- types (I know, don't look at me, Haskell is crazy)
  (Char 'w') -> left $~! \(x,y) -> (x,y+0.1)
  (Char 'W') -> left $~! \(x,y) -> (x,y+0.1)
  (Char 's') -> left $~! \(x,y) -> (x,y-0.1)
  (Char 'S') -> left $~! \(x,y) -> (x,y-0.1)
  _-> return ()
keyboardMouseLeft _ _ _ _ _ = return()
