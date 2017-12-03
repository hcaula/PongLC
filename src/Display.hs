module Display (idle, display) where

import Graphics.UI.GLUT
import Data.IORef

import Elements

display :: IORef (GLfloat, GLfloat) -> IORef (GLfloat, GLfloat) -> DisplayCallback
display rightRacketPos leftRacketPos = do
  clear [ColorBuffer]
  loadIdentity

  let racketRight = getPaddleRight rightRacketPos
  let racketLeft = getPaddleLeft leftRacketPos

  -- Calls for the render rackets function
  preservingMatrix $ do
    racketLeft
    racketRight
  flush

idle :: IdleCallback
idle = do
  postRedisplay Nothing

getPaddleRight :: IORef (GLfloat, GLfloat) -> IO()
getPaddleRight right = do
  (x, y) <- get right
  racket "Right" y

getPaddleLeft :: IORef (GLfloat, GLfloat) -> IO()
getPaddleLeft left = do
  (x, y) <- get left
  racket "Left" y
