module Gui.Seekbar exposing (render, filter)

import Architecture exposing (Model, Message(..))
import Html exposing (Html, input, div)
import Html.Attributes as Attr
import Gui.Helper exposing (icon)
import File exposing (Tree, File)
import Html.Events exposing (onInput)
import Action


entryFilter : Model -> File -> Bool
entryFilter model file =
    let
        lowerSearch =
            String.toLower model.searchState

        lowerName =
            String.toLower file.name
    in
        String.contains lowerSearch lowerName


filter : Model -> Tree -> Tree
filter model tree =
    if String.isEmpty model.searchState then
        tree
    else
        List.filter (entryFilter model) tree


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
