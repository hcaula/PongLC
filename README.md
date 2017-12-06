# PongLC
A multithread implementation of Pong in Haskell.

## Libraries used
- [FuGEn](https://github.com/haskell-game/fungen) for game logic, sprite rendering, sounds, inputs and collision detection;
- [GLUT](http://hackage.haskell.org/package/GLUT) for OpenGL friendly number formats.

## How to run

Make sure you have the full Haskel Platform installed, available [here](https://www.haskell.org/platform/).</br>
This project **must run on GHC version 8.2.1 or above**, as it already includes OpenGL libraries. If you're a Linux user, **do not** just run ``apt-get install haskell-platform``, as it won't provide the most recent version. Instead, [download the full generic version](https://www.haskell.org/platform/#linux-generic) corresponding to your computer architecture.</br></br>
Verify your GHC version running:

````
ghc -V
````

To install FunGEn, run:

```
sudo cabal update
sudo cabal install fungen
```

Finally, to compile and play the game, run:

````
cd [Project_Path]/src
ghc Main.hs
./Main
````

## Authors
- Henrique Caúla | lhtc@cin.ufpe.br
- João Filipe Moura | jfmrm@cin.ufpe.br
