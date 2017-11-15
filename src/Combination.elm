module Combination
    exposing
        ( Combination
        , handle
        )

import Keyboard exposing (KeyCode)
import Architecture exposing (Model)
import Set exposing (Set)


type alias Combination =
    Set KeyCode


handle : Model -> ( Model, Cmd msg )
handle model =
    ( model, Cmd.none )
