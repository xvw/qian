module View exposing (global)

import Dispatcher exposing (Model, Message(..))
import Html exposing (Html, text)


global : Model -> Html Message
global model =
    text "yo"
