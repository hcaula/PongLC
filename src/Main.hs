module Main where

-- Our modules
import Inputs
import Globals
import Objects

-- External libraries
import Graphics.UI.Fungen

main :: IO ()
main = do
  -- Window options
  let winConfig = ((100,80),(width,height), "PongLC")

      -- List of images (black tile and score images)
      bmpList = imageList

      -- Sets the tilles
      gameMap = textureMap 0 30 30 w h

      -- Initiates objects groups (the functions are defined in Objects.hs)
      players = objectGroup "playerGroup"  [createPlayer "P1", createPlayer "P2"]
      ball = objectGroup "ballGroup" [createBall]
      score = objectGroup "scoreGroup" [createScore "ScoreP1", createScore "ScoreP2"]
      middleLine = objectGroup "middleLine" [createMiddleLine x | x <- [0..5]]

      -- Initiates P1Score, P2Score and Hits (amount of times the ball has hit a paddle)
      initElements = Elements (0,0,0)

      -- Defines inputs (movement is defined in Inputs.hs)
      input = movement

  -- Initiates the game itself
  funInit winConfig gameMap [players,ball,score,middleLine] () initElements input gameCycle (Timer 30) bmpList


-- Game loop
gameCycle :: IOGame GameAttribute () () () ()
gameCycle = do

  -- Gets the current value for this frame for the players' scores
  -- and the hits and puts them in p1Score, p2Score and hits
  (Elements (p1Score, p2Score, hits)) <- getGameAttribute

  -- Gets the objects for this frame
  ball <- findObject "ball" "ballGroup"
  p1 <- findObject "P1" "playerGroup"
  p2 <- findObject "P2" "playerGroup"
  p1ScoreDisplay <- findObject "ScoreP1" "scoreGroup"
  p2ScoreDisplay <- findObject "ScoreP2" "scoreGroup"

  -- If one of the players reaches nine points, stop the ball in the center
  when (p1Score == 9 || p2Score == 9) (do
                                        setObjectSpeed (0,0) ball
                                        setObjectPosition (w/2,h/2) ball
                                        -- Set the points to 11 so that it doesn't enter
                                        -- this "if" on the next loop
                                        setGameAttribute (Elements (11,11,0)))


  -- Debug values
  printOnScreen (show p1Score) TimesRoman24 (0,0) 1.0 1.0 1.0
  printOnScreen (show p2Score) TimesRoman24 (50,0) 1.0 1.0 1.0
  printOnScreen (show hits) TimesRoman24 (100,0) 1.0 1.0 1.0
  showFPS TimesRoman24 (w-40,0) 1.0 0.0 0.0

  -- Debug the ball's horizontal speed
  let (vx,vy) = getGameObjectSpeed ball
  printOnScreen (show vx) TimesRoman24 (150,0) 1.0 1.0 1.0

  -- Collisions: ball-player
  col1 <- objectsCollision ball p1
  col2 <- objectsCollision ball p2
  when (col1 || col2) (do

                      -- If the ball's horizontal speed is negative, reflect and ADD the increment
                      if (vx < 0) then setObjectSpeed (-vx+ballIncrement, getRandomY hits) ball

                      -- Otherwise, reflect and SUBTRACT the increment
                      else setObjectSpeed (-vx-ballIncrement, getRandomY hits) ball

                      -- Increment the hits value by one
                      (setGameAttribute (Elements (p1Score, p2Score, hits+1)))
                      )

  -- Collisions: ball-walls
  col3 <- objectTopMapCollision ball
  col4 <- objectBottomMapCollision ball
  -- Reverse the vertical speed
  when (col3 || col4) (reverseYSpeed ball)


  -- Collisions: ball-goals
  col5 <- objectLeftMapCollision ball
  col6 <- objectRightMapCollision ball
  when (col5) (do
              -- If the ball hit the left wall, point to player 2
              setGameAttribute (Elements (p1Score, p2Score + 1, hits))

              -- Change the score to correspondent image
              (setObjectCurrentPicture (p2Score+2) p2ScoreDisplay))
  when (col6) (do
              -- Same thing for right goal
              setGameAttribute (Elements (p1Score + 1, p2Score, hits))
              (setObjectCurrentPicture (p1Score+2) p1ScoreDisplay))

  when (col5 || col6) (do
                      -- For both cases, reset the ball in the middle;
                      (setObjectPosition middleScreen ball)
                      -- and reset its horizontal speed to initial
                      setObjectSpeed (ballInitialSpeed, 0) ball

                      )
