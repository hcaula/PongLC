module Main where

import Inputs
import Settings
import Elements
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
      initScore = Score 0
      input = movement
  funInit winConfig gameMap [players,ball] () initScore input gameCycle (Timer 30) bmpList

gameCycle :: IOGame GameAttribute () () () ()
gameCycle = do
  (Score n) <- getGameAttribute
  printOnScreen (show n) TimesRoman24 (0,0) 1.0 1.0 1.0

  ball <- findObject "ball" "ballGroup"
  col1 <- objectLeftMapCollision ball
  col2 <- objectRightMapCollision ball
  when (col1 || col2) (reverseXSpeed ball)
  col3 <- objectTopMapCollision ball
  when col3 (reverseYSpeed ball)
  col4 <- objectBottomMapCollision ball
  when col4 $ do
    -- funExit
    setGameAttribute (Score 0)
    reverseYSpeed ball

  bar <- findObject "P1" "playerGroup"
  col5 <- objectsCollision ball bar
  let (_,vy) = getGameObjectSpeed ball
  when (and [col5, vy < 0])  (do reverseYSpeed ball
                                 setGameAttribute (Score (n + 10)))
  showFPS TimesRoman24 (w-40,0) 1.0 0.0 0.0
