module Display (idle, display) where

import Graphics.UI.GLUT
import Data.IORef

import Elements

display :: IORef (GLfloat, GLfloat) -> IORef (GLfloat, GLfloat) -> DisplayCallback
display rightRacketPos leftRacketPos = do
  clear [ColorBuffer]
  loadIdentity
  (rightX,rightY) <- get rightRacketPos
  (leftX,leftY) <- get leftRacketPos
  let racketRight = racket "Right" rightY
  let racketLeft = racket "Left" leftY

  -- Calls for the render rackets function
  preservingMatrix $ do
    racketLeft
    racketRight
  flush

idle :: IdleCallback
idle = do
  postRedisplay Nothing
