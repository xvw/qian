module Component.ToolBox exposing (render)

{-| Component for rendering the search bar
-}

import Model exposing (Model)
import Message exposing (Message(..))
import File
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
            [ finderButton currentPath ]


{-| Create the "open in finder Button"
-}
finderButton : File.Path -> Html Message
finderButton currentPath =
    a
        [ Attr.href "#", onClick OpenInFinder ]
        [ icon "folder-open" ]
