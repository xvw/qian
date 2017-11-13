module Interactive exposing (update)

import Architecture exposing (Message(..), Model)
import Keyboard exposing (KeyCode)


-- Ignored ATM


update : Model -> KeyCode -> ( Model, Cmd Message )
update model keycode =
    ( model, Cmd.none )
