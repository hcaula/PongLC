module Main where

import Inputs
import Globals
import Objects
import Graphics.UI.Fungen
import Graphics.Rendering.OpenGL (GLdouble)

main :: IO ()
main = do
  -- texbmp <- getDataFileName "examples/pong/tex.bmp"
  let winConfig = ((100,80),(width,height), "PongLC")
      bmpList = imageList
      gameMap = textureMap 0 30 30 w h
      players = objectGroup "playerGroup"  [createPlayer "P1", createPlayer "P2"]
      ball = objectGroup "ballGroup" [createBall]
      score = objectGroup "scoreGroup" [createScore "ScoreP1", createScore "ScoreP2"]
      initElements = Elements (0,0,0)
      input = movement
  funInit winConfig gameMap [players,ball,score] () initElements input gameCycle (Timer 30) bmpList

gameCycle :: IOGame GameAttribute () () () ()
gameCycle = do
  (Elements (p1Score, p2Score, hits)) <- getGameAttribute

  ball <- findObject "ball" "ballGroup"
  p1 <- findObject "P1" "playerGroup"
  p2 <- findObject "P2" "playerGroup"
  p1ScoreDisplay <- findObject "ScoreP1" "scoreGroup"
  p2ScoreDisplay <- findObject "ScoreP2" "scoreGroup"

  when (p1Score == 9 || p2Score == 9) (do
                                        setObjectSpeed (0,0) ball
                                        setGameAttribute (Elements (11,11,0)))


  printOnScreen (show p1Score) TimesRoman24 (0,0) 1.0 1.0 1.0
  printOnScreen (show p2Score) TimesRoman24 (50,0) 1.0 1.0 1.0
  printOnScreen (show hits) TimesRoman24 (100,0) 1.0 1.0 1.0

  let (vx,vy) = getGameObjectSpeed ball
  printOnScreen (show vx) TimesRoman24 (150,0) 1.0 1.0 1.0

  col1 <- objectsCollision ball p1
  col2 <- objectsCollision ball p2
  when (col1 || col2) (do
                      if (vx < 0) then setObjectSpeed (-vx+ballIncrement, getRandomY hits) ball
                      else setObjectSpeed (-vx-ballIncrement, getRandomY hits) ball

                      (setGameAttribute (Elements (p1Score, p2Score, hits+1)))
                      )

  col3 <- objectTopMapCollision ball
  col4 <- objectBottomMapCollision ball
  when (col3 || col4) (reverseYSpeed ball)

  col5 <- objectLeftMapCollision ball
  col6 <- objectRightMapCollision ball
  when (col5) (do
              setGameAttribute (Elements (p1Score, p2Score + 1, hits))
              (setObjectCurrentPicture (p2Score+2) p2ScoreDisplay))
  when (col6) (do
              setGameAttribute (Elements (p1Score + 1, p2Score, hits))
              (setObjectCurrentPicture (p1Score+2) p1ScoreDisplay))
  when (col5 || col6) (do
                      (setObjectPosition middleScreen ball)
                      (Elements (points1, points2, hits)) <- getGameAttribute
                      setObjectSpeed (ballInitialSpeed, 0) ball)

  showFPS TimesRoman24 (w-40,0) 1.0 0.0 0.0
