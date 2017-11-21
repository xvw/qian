module View exposing (global)

{-| The entry point for the views
-}

import Model exposing (Model)
import Message exposing (Message)
import Html
    exposing
        ( Html
        , text
        )


{-| The global view
-}
global : Model -> Html Message
global model =
    text "Hello"
