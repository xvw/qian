module Gui.Command exposing (render)

import Architecture exposing (Model, Message(..))
import Html exposing (Html, input)
import Html.Attributes as Attr


render : Model -> Html Message
render model =
    input
        [ Attr.placeholder "command"
        , Attr.type_ "text"
        ]
        []
