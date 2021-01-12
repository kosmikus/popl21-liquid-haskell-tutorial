# Liquid Haskell: Refinement Type Checker for Haskell

## POPL '21 Tutorial

If you want to follow allong with the workshop, please clone this repository and try to build it:

- **You need the [`z3`](https://github.com/Z3Prover/z3) theorem prover
  installed and in your PATH. (This is a non-Haskell dependency, so you
  have to install it separately.)**

- If you can, use GHC 8.10.3. In principle, GHC 8.10.2 should also work.

- The package can be built using both `cabal` and `stack`.

  For building with
  `cabal`, you need to have GHC installed already, and then type `cabal v2-build`
  to trigger the build.

  For building with
  `stack`, you have to type `stack build` to trigger the build.

  On a successful build, you should see no error messages and an output similar
  to the following for the final part of the build:
  ```
  Building library for popl21-liquid-haskell-tutorial-0.1..
  [1 of 3] Compiling Lists            ( Lists.hs, /home/andres/repos/popl21-liquid-haskell-tutorial/dist-newstyle/build/x86_64-linux/ghc-8.10.3/popl21-liquid-haskell-tutorial-0.1/build/Lists.o, /home/andres/repos/popl21-liquid-haskell-tutorial/dist-newstyle/build/x86_64-linux/ghc-8.10.3/popl21-liquid-haskell-tutorial-0.1/build/Lists.dyn_o )

  **** LIQUID: SAFE (1 constraints checked) **************************************
  [2 of 3] Compiling Memory           ( Memory.hs, /home/andres/repos/popl21-liquid-haskell-tutorial/dist-newstyle/build/x86_64-linux/ghc-8.10.3/popl21-liquid-haskell-tutorial-0.1/build/Memory.o, /home/andres/repos/popl21-liquid-haskell-tutorial/dist-newstyle/build/x86_64-linux/ghc-8.10.3/popl21-liquid-haskell-tutorial-0.1/build/Memory.dyn_o )

  **** LIQUID: SAFE (0 constraints checked) **************************************
  [3 of 3] Compiling SExec            ( SExec.hs, /home/andres/repos/popl21-liquid-haskell-tutorial/dist-newstyle/build/x86_64-linux/ghc-8.10.3/popl21-liquid-haskell-tutorial-0.1/build/SExec.o, /home/andres/repos/popl21-liquid-haskell-tutorial/dist-newstyle/build/x86_64-linux/ghc-8.10.3/popl21-liquid-haskell-tutorial-0.1/build/SExec.dyn_o )

  **** LIQUID: SAFE (0 constraints checked) **************************************
  ```

  Note in particular the lines with `LIQUID` in them. They indicate that
  the plugin is successfully running, and if you see `1 constraints checked`
  for the `Lists` module, it also indicates that `z3` has been succesfully
  invoked.

- For a better interactive development experience, we recommend the use of
  [`ghcid`](https://hackage.haskell.org/package/ghcid). You can install this
  program on your system via `cabal install` or `stack install`.

  Once `ghcid` is in your PATH, you can invoke it for this project with
  `ghcid -c "cabal v2-repl"` (when using cabal) or `ghcid -c "stack ghci"`
  (when using stack). This should load the source files into `ghci`, run
  the Liquid Haskell plugin on the way, and report that everything is good.
  These results then update automatically once the source files are changes.

  (In principle, Liquid Haskell should also work with `haskell-language-server`
  or `ghcide`, which provide a more IDE-like experience. Unfortunately, that
  support is still somewhat fragile and has some known issues, so while you're
  welcome to try it, we will not use it in this tutorial.)

- Unfortunately, Windows support for GHC plugins is known to be unreliable.
  If you are on Windows, the above may just not work. You may still have the
  option to install the `liquidhaskell` package on your system, giving you
  an executable called `liquid`, and running `liquid` on `` via
  the command line.
