module Gui.Seekbar exposing (render)

import Architecture exposing (Model, Message(..))
import Html exposing (Html, input, div)
import Html.Attributes as Attr
import Gui.Helper exposing (icon)
import Html.Events exposing (onInput)
import Action


render : Model -> Html Message
render model =
    div [ Attr.class "search-box" ]
        [ icon "search"
        , input
            [ Attr.id "search-input"
            , Attr.placeholder "search..."
            , Attr.value model.searchState
            , Attr.type_ "text"
            , onInput (\s -> Patch (Action.fillSearch s))
            ]
            []
        ]
