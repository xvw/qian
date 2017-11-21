module View exposing (global)

{-| The entry point for the views
-}

import Model exposing (Model)
import Message exposing (Message)
import Html
    exposing
        ( Html
        , text
        , div
        , header
        , footer
        , main_
        )
import Html.Attributes as Attr


{-| The global view
-}
global : Model -> Html Message
global model =
    div
        [ Attr.class "inner-app" ]
        [ header []
            [ text "h"
            ]
        , main_ []
            [ text "m"
            ]
        , footer []
            [ text "f"
            ]
        ]
