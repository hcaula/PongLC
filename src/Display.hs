module Display (idle, display) where

import Graphics.UI.GLUT
import Data.IORef
import Elements

-- Receive right and left paddle position from main
display :: IORef (GLfloat, GLfloat) -> IORef (GLfloat, GLfloat) -> IORef (GLfloat, GLfloat) -> DisplayCallback
display rightRacketPos leftRacketPos ballPos = do

  -- Clears the screen
  clear [ColorBuffer]
  loadIdentity

  (ballX, ballY) <- get ballPos
  -- Sets left and right position - in here, we get keyboard input
  -- to see if we should elevate the paddles
  let racketRight = getPaddleRight rightRacketPos
  let racketLeft = getPaddleLeft leftRacketPos
  let bally = ball ballX ballY

  -- Calls for the render rackets function
  preservingMatrix $ do
    racketLeft
    racketRight
    bally
  flush

-- Idle function - standard from OpenGl
-- Responsible for animations
idle :: IORef (GLfloat, GLfloat) -> IORef (GLfloat, GLfloat) ->  IdleCallback
idle ballPos ballSpeed  = do
  (ballX, ballY) <- get ballPos

  if (hitPaddle (ballX, ballY)) then
    ballSpeed $~! \(x,y) -> (x*(-1),y)
  else ballSpeed $~! \(x,y) -> (x,y)

  (speedX, speedY) <- get ballSpeed

  ballPos $~! \(x,y) -> (x+speedX,y+speedY)
  postRedisplay Nothing

hitPaddle :: (Float, Float) -> Bool
hitPaddle ball = do
  -- putStrLn "hello, world"
  if(ballX <= -0.8) then True
  else if(ballX >= 0.7) then True
  else False
  where ballX = fst ball
        ballY = snd ball

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
