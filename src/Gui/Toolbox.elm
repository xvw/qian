module Gui.Toolbox exposing (render)

import Architecture exposing (Model, Message(..))
import Gui.Helper exposing (icon, iconCustom, boolToClass)
import Html exposing (Html, a, div, text)
import Html.Events exposing (onClick)
import Html.Attributes as Attr
import Zipper.History as History exposing (Direction(..))
import Action


activeButton : Message -> String -> Bool -> Html Message
activeButton message iconName enabled =
    let
        buttonIcon =
            iconCustom iconName [ boolToClass enabled ] []
    in
        if enabled then
            a
                [ onClick message ]
                [ buttonIcon ]
        else
            buttonIcon


historyButton : Model -> Direction -> Html Message
historyButton model message =
    let
        ( f, iconName, patch ) =
            case message of
                Past ->
                    ( History.hasPast, "arrow-circle-left", Action.backward )

                Future ->
                    ( History.hasFuture, "arrow-circle-right", Action.forward )

        enabled =
            f model.history

        iconArrow =
            iconCustom iconName [ boolToClass enabled ] []
    in
        if enabled then
            a [ onClick (Patch patch) ] [ iconArrow ]
        else
            iconArrow


hiddenButton : Model -> Html Message
hiddenButton model =
    let
        ( iconName, class ) =
            if model.showHidden then
                ( "eye-slash", Attr.class "deactivate" )
            else
                ( "eye", Attr.class "activate" )
    in
        a [ onClick (Patch Action.toggleHidden), class ] [ icon iconName ]


finderButton : Model -> Html Message
finderButton model =
    let
        message =
            Patch (Action.openInExplorer model.history.present)
    in
        a
            [ onClick message ]
            [ icon "external-link-square" ]


terminalButton : Model -> Html Message
terminalButton model =
    let
        message =
            Patch (Action.openTerminal model.history.present)
    in
        a
            [ onClick message ]
            [ icon "terminal" ]


render : Model -> Html Message
render model =
    let
        present =
            model.history.present

        home =
            model.home
    in
        div
            [ Attr.class "toolbox" ]
            [ div
                []
                [ activeButton (Patch (Action.changeDir "")) "hdd-o" (present /= "")
                , activeButton (Patch (Action.changeDir home)) "home" (present /= home)
                ]
            , div
                [ Attr.class "history-buttons" ]
                [ historyButton model Past
                , historyButton model Future
                , finderButton model
                , terminalButton model
                , hiddenButton model
                ]
            ]
