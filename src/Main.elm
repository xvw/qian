module Main exposing (..)

import Html exposing (program)
import Dispatcher exposing (Message(..), Model)
import View exposing (global)


main : Platform.Program Never Model Message
main =
    program
        { init = ( Nothing, Cmd.none )
        , update = (\m x -> ( x, Cmd.none ))
        , view = global
        , subscriptions = (\_ -> Sub.none)
        }
