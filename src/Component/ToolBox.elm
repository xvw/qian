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
            [ finderButton
            , terminalButton
            ]


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
