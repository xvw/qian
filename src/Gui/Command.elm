module Gui.Command exposing (render)

import Architecture exposing (Model, Message(..))
import Html exposing (Html, div)


render : Model -> Html Message
render model =
    div []
        []
