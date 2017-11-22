module Component.HistoryButtons exposing (render)

{-| This module is a component to display the pred and next buttons
-}

import Zipper.History as History exposing (History)
import File
import Component.Helper exposing (iconCustom)
import Model exposing (Model)
import Message exposing (Message(..))
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Html
    exposing
        ( Html
        , text
        , div
        )


{-| Render the two buttons.
-}
render : History File.Path -> Html Message
render history =
    div
        [ Attr.class "history-buttons" ]
        [ iconButton "arrow-left" (History.backward history)
        , iconButton "arrow-right" (History.forward history)
        ]


{-| Render a specific Icon according to an History
-}
iconButton : String -> Maybe (History File.Path) -> Html Message
iconButton iconName potentialHistory =
    case potentialHistory of
        Nothing ->
            iconCustom iconName [ "disabled" ] []

        Just history ->
            iconCustom
                iconName
                [ "enabled" ]
                [ onClick (NavigateHistory history) ]
