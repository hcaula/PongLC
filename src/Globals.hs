module Globals where
import Graphics.Rendering.OpenGL (GLdouble)

-- In order: P1Score, P2Score, amount of hits
data GameAttribute = Elements (Int, Int, Integer)

-- Screen resolution in pixels
width = 800 :: Int
height = 600 :: Int

-- Screen resolution converted to double
w = fromIntegral width :: GLdouble
h = fromIntegral height :: GLdouble

-- Middle of the screen
middleScreen :: (GLdouble, GLdouble)
middleScreen = (w/2, h/2)

imageList = [("../assets/imgs/black.bmp", Nothing),
            ("../assets/imgs/0.bmp", Nothing)]

-- Bars sprites measures
bar :: [(Double, Double)]
bar = [(-barWidth, -barHeight), (barWidth, -barHeight),(barWidth, barHeight),(-barWidth, barHeight)]

-- Ball sprite measures
ball :: [(Double, Double)]
ball = [(-ballSize, -ballSize), (ballSize, -ballSize), (ballSize, ballSize), (-ballSize, ballSize)]

-- Width of the bar: 2.5% of screen width
barWidth = w/50

-- Height of the bar: 12.5% of screen height
barHeight = h/8

-- Offset (distance between bar and screen horizontal border)
offset = barWidth*2

-- Bar speed
barSpeed = 20 :: GLdouble

-- Ball size
ballSize = barWidth

-- Ball increment speed for each beat
ballIncrement = 2 :: GLdouble

-- Initial Ball Speed (this value is not changeable)
ballInitialSpeed = 12 :: GLdouble
