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
import Component.Breadcrumb as Breadcrumb
import Component.HistoryButtons as HistoryButtons


{-| The global view of the Application.
-}
global : Model -> Html Message
global model =
    div
        [ Attr.class "inner-app" ]
        [ header []
            [ Breadcrumb.render model
            , HistoryButtons.render model.history
            ]
        , main_ [] []
        , footer [] [ text "footer" ]
        ]
