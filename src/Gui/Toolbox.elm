module Gui.Toolbox exposing (render)

import Architecture exposing (Model, Message(..))
import Gui.Helper exposing (icon, iconCustom, boolToClass)
import Html exposing (Html, a, div, text)
import Html.Events exposing (onClick)
import Html.Attributes as Attr
import Zipper.History as History


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


historyButton : Model -> Message -> Html Message
historyButton model message =
    let
        ( f, iconName ) =
            case message of
                Backward ->
                    ( History.hasPast, "arrow-circle-left" )

                Forward ->
                    ( History.hasFuture, "arrow-circle-right" )

                _ ->
                    ( \_ -> False, "nothing" )

        enabled =
            f model.history

        iconArrow =
            iconCustom iconName [ boolToClass enabled ] []
    in
        if enabled then
            a [ onClick message ] [ iconArrow ]
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
        a [ onClick ToggleHidden, class ] [ icon iconName ]


finderButton : Model -> Html Message
finderButton model =
    a
        [ onClick (OpenInFinder model.history.present) ]
        [ icon "external-link-square " ]


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
                [ activeButton (ChangeDirectory [ "" ]) "hdd-o" (present /= [ "" ])
                , activeButton (ChangeDirectory home) "home" (present /= home)
                ]
            , div
                [ Attr.class "history-buttons" ]
                [ historyButton model Backward
                , historyButton model Forward
                , finderButton model
                , hiddenButton model
                ]
            ]
