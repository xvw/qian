module Gui.Breadcrumb exposing (render)

import Action
import Path exposing (Path)
import Architecture exposing (Model, Message(..))
import Html exposing (Html, ul, li, a, text, span)
import Html.Events exposing (onClick)
import Html.Attributes as Attr


make : Model -> List (Html Message)
make model =
    model.history.present
        |> Path.unroll
        |> List.map (\( path, filename ) -> clickableCrumb model path filename)


clickableCrumb : Model -> Path -> String -> Html Message
clickableCrumb model path filename =
    let
        content =
            if model.history.present == path then
                [ span [ Attr.class "current" ] [ text filename ] ]
            else
                [ a [ onClick (Patch (Action.changeDir path)) ] [ text filename ]
                , span [ Attr.class "crumb-separator" ] [ text "/" ]
                ]
    in
        li [] content


render : Model -> Html Message
render model =
    ul
        [ Attr.class "breadcrumb" ]
        (make model)
