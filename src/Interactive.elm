module Interactive exposing (updateDown, updatePress, updateUp)

import Architecture exposing (Message(..), Model)
import Keyboard exposing (KeyCode)


updateUp : Model -> KeyCode -> ( Model, Cmd Message )
updateUp model keyCode =
    ( model, Cmd.none )


updatePress : Model -> KeyCode -> ( Model, Cmd Message )
updatePress model keyCode =
    ( model, Cmd.none )


updateDown : Model -> KeyCode -> ( Model, Cmd Message )
updateDown model keycode =
    ( model, Cmd.none )
