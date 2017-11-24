module Component.ToolBox exposing (render)

{-| Component for rendering the search bar
-}

import Model exposing (Model)
import Message exposing (Message(..))
import Component.Helper exposing (icon)
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Html
    exposing
        ( Html
        , text
        , div
        , a
        )


{-| Render the search bar
-}
render : Model -> Html Message
render model =
    let
        currentPath =
            Model.now model
    in
        div
            [ Attr.class "tool-box" ]
            [ hiddenButton model.displayHiddenItem
            , finderButton
            , terminalButton
            ]


{-| Create the "display/hide" button
-}
hiddenButton : Bool -> Html Message
hiddenButton toggler =
    let
        iconName =
            if toggler then
                "eye-slash"
            else
                "eye"
    in
        a
            [ Attr.href "#", onClick ToggleDisplayHiddenItem ]
            [ icon iconName ]


{-| Create the "open in finder Button"
-}
finderButton : Html Message
finderButton =
    a
        [ Attr.href "#", onClick OpenInFinder ]
        [ icon "folder-open" ]


{-| Create the "open in terminal Button"
-}
terminalButton : Html Message
terminalButton =
    a
        [ Attr.href "#", onClick OpenInTerminal ]
        [ icon "window-maximize" ]
