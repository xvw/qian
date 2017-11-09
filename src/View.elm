module View exposing (global)

import Architecture exposing (Model, Message(..), Pwd)
import Html
    exposing
        ( Html
        , Attribute
        , i
        , text
        , div
        , main_
        , footer
        , header
        , ul
        , li
        , span
        , input
        , a
        )
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Zipper.History as History


fa : String -> List String -> List (Attribute msg)
fa icon otherClasses =
    let
        classes =
            [ "fa", "fa-" ++ icon ]
                ++ otherClasses
                |> String.join " "
    in
        [ Attr.class classes
        , Attr.attribute "aria-hidden" "true"
        ]


global : Model -> Html Message
global model =
    div []
        [ header [] (makeHeader model)
        , main_ [] [ text "content" ]
        , footer [] (makeFooter model)
        ]


makeHeader : Model -> List (Html Message)
makeHeader model =
    [ ul
        [ Attr.class "breadcrumb" ]
        ((makeBreadcrumb model model.pwd [] [])
            |> List.reverse
        )
    ]


makeBreadcrumb : Model -> Pwd -> Pwd -> List (Html Message) -> List (Html Message)
makeBreadcrumb model pwd marked acc =
    case pwd of
        [] ->
            acc

        [ elt ] ->
            (li [] [ (renderCrumb elt) ]) :: acc

        x :: xs ->
            let
                path =
                    marked ++ [ x ]
            in
                makeBreadcrumb
                    model
                    xs
                    path
                    ((clickableCrumb path x) :: acc)


renderCrumb : String -> Html Message
renderCrumb folder =
    if String.isEmpty folder then
        i (fa "hdd-o" []) []
    else
        text folder


clickableCrumb : Pwd -> String -> Html Message
clickableCrumb pwd folder =
    li
        []
        [ a [ onClick (Cd pwd) ] [ renderCrumb folder ] ]


backButton : Model -> Html Message
backButton model =
    let
        class =
            if History.hasPast model.history then
                [ "enabled" ]
            else
                [ "disabled" ]
    in
        i (fa "arrow-circle-left" class) []


nextButton : Model -> Html Message
nextButton model =
    let
        class =
            if History.hasFuture model.history then
                [ "enabled" ]
            else
                [ "disabled" ]
    in
        i (fa "arrow-circle-right" class) []


makeFooter : Model -> List (Html Message)
makeFooter model =
    [ input
        [ Attr.placeholder "command"
        , Attr.type_ "text"
        ]
        []
    , div [] [ backButton model, nextButton model ]
    ]
