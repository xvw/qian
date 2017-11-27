module Component.ToolBox exposing (render)

{-| Component for rendering the search bar
-}

import Model exposing (Model, State(..))
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
            , settingButton model.state
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
            [ onClick ToggleDisplayHiddenItem ]
            [ icon iconName ]


{-| Create the "open in finder Button"
-}
finderButton : Html Message
finderButton =
    a
        [ onClick OpenInFinder ]
        [ icon "folder-open" ]


{-| Create the "open in terminal Button"
-}
terminalButton : Html Message
terminalButton =
    a
        [ onClick OpenInTerminal ]
        [ icon "window-maximize" ]


{-| Create the "settings" button
-}
settingButton : State -> Html Message
settingButton state =
    a
        [ onClick GoToSettings ]
        [ icon "cog" ]
