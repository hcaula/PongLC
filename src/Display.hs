module Display (idle, display) where

import Graphics.UI.GLUT
import Data.IORef
import Elements

-- Receive right and left paddle position from main
display :: IORef (GLfloat, GLfloat) -> IORef (GLfloat, GLfloat) -> DisplayCallback
display rightRacketPos leftRacketPos = do

  -- Clears the screen
  clear [ColorBuffer]
  loadIdentity

  -- Sets left and right position - in here, we get keyboard input
  -- to see if we should elevate the paddles
  let racketRight = getPaddleRight rightRacketPos
  let racketLeft = getPaddleLeft leftRacketPos

  -- Calls for the render rackets function
  preservingMatrix $ do
    racketLeft
    racketRight
  flush

-- Idle function - standard from OpenGl
-- Responsible for animations
idle :: IdleCallback
idle = do
  postRedisplay Nothing


-- RACKETS THREADS GO HERE!
-- Each thread should run one of those two functions
getPaddleRight :: IORef (GLfloat, GLfloat) -> IO()
getPaddleRight right = do
  (x, y) <- get right
  racket "Right" y

getPaddleLeft :: IORef (GLfloat, GLfloat) -> IO()
getPaddleLeft left = do
  (x, y) <- get left
  racket "Left" y
