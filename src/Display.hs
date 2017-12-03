module Display (idle, display) where

import Graphics.UI.GLUT
import Data.IORef

import Elements

display :: IORef (GLfloat, GLfloat) -> DisplayCallback
display rightRacketPos = do
  clear [ColorBuffer]
  loadIdentity
  (x',rightY) <- get rightRacketPos
  let racketLeft = racket "Left" rightY

  -- let color3f r g b = color $ Color3 r g (b :: GLfloat)
  --     vertex3f x y z = vertex $ Vertex3 x y (z :: GLfloat)

  -- Calls for the render rackets function
  preservingMatrix $ do
    racketLeft
    racket "Right" 1
  flush

idle :: IORef GLfloat -> IORef GLfloat -> IdleCallback
idle angle delta = do
  d <- get delta
  angle $~! (+ d)
  postRedisplay Nothing
