module Main where

import Inputs
import Settings
import Objects
import Graphics.UI.Fungen
import Graphics.Rendering.OpenGL (GLdouble)

main :: IO ()
main = do
  -- texbmp <- getDataFileName "examples/pong/tex.bmp"
  let winConfig = ((100,80),(width,height), "PongLC")
      bmpList = [("../assets/imgs/black.bmp", Nothing)]
      gameMap = textureMap 0 30 30 w h
      players = objectGroup "playerGroup"  [createPlayer "P1", createPlayer "P2"]
      ball = objectGroup "ballGroup" [createBall]
      initElements = Elements (0,0,0)
      input = movement
  funInit winConfig gameMap [players,ball] () initElements input gameCycle (Timer 15) bmpList

gameCycle :: IOGame GameAttribute () () () ()
gameCycle = do
  (Elements (p1Score, p2Score, hits)) <- getGameAttribute
  printOnScreen (show p1Score) TimesRoman24 (0,0) 1.0 1.0 1.0
  printOnScreen (show p2Score) TimesRoman24 (50,0) 1.0 1.0 1.0
  printOnScreen (show hits) TimesRoman24 (100,0) 1.0 1.0 1.0

  ball <- findObject "ball" "ballGroup"
  p1 <- findObject "P1" "playerGroup"
  p2 <- findObject "P2" "playerGroup"

  let (vx,vy) = getGameObjectSpeed ball
  printOnScreen (show vx) TimesRoman24 (150,0) 1.0 1.0 1.0

  col1 <- objectsCollision ball p1
  col2 <- objectsCollision ball p2
  when (col1 || col2) (do
                      (reverseXSpeed ball)
                      (setGameAttribute (Elements (p1Score, p2Score, hits+1)))
                      if ((mod hits 2) == 0) then
                        setObjectSpeed (-vx+ballIncrement, vy) ball
                      else printOnScreen ("") TimesRoman24 (100,0) 1.0 1.0 1.0
                      )

  col3 <- objectTopMapCollision ball
  col4 <- objectBottomMapCollision ball
  when (col3 || col4) (reverseYSpeed ball)

  col5 <- objectLeftMapCollision ball
  col6 <- objectRightMapCollision ball
  when (col5) (do setGameAttribute (Elements (p1Score, p2Score + 1, hits)))
  when (col6) (do setGameAttribute (Elements (p1Score + 1, p2Score, hits)))
  when (col5 || col6) (do
                      (setObjectPosition middleScreen ball)
                      (Elements (points1, points2, hits)) <- getGameAttribute
                      setGameAttribute (Elements (points1, points2, 0))
                      setObjectSpeed (ballInitialSpeed, vy) ball)

  showFPS TimesRoman24 (w-40,0) 1.0 0.0 0.0
