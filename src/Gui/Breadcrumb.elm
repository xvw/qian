module Gui.Breadcrumb exposing (render)

import Action
import File exposing (Path)
import Architecture exposing (Model, Message(..))
import Html exposing (Html, ul, li, a, text, span)
import Html.Events exposing (onClick)
import Html.Attributes as Attr


make : Model -> Path -> Path -> List (Html Message) -> List (Html Message)
make model pwd visited result =
    case pwd of
        [] ->
            result

        [ x ] ->
            (li [ Attr.class "current" ] [ crumb x ]) :: result

        x :: xs ->
            let
                path =
                    visited ++ [ x ]

                aCrumb =
                    (clickableCrumb path x)
            in
                make model xs path (aCrumb :: result)


crumb : String -> Html Message
crumb fileName =
    let
        content =
            if String.isEmpty fileName then
                "Root"
            else
                fileName
    in
        text content


clickableCrumb : Path -> String -> Html Message
clickableCrumb path filename =
    li
        []
        [ a [ onClick (Patch (Action.changeDir path)) ] [ crumb filename ]
        , span [ Attr.class "crumb-separator" ] [ text "/" ]
        ]


render : Model -> Html Message
render model =
    ul
        [ Attr.class "breadcrumb" ]
        ((make model model.history.present [] [])
            |> List.reverse
        )
