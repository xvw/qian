module Component.Breadcrumb exposing (render)

{-| This module is a component to display a breadcrumb from a Model
-}

import Model exposing (Model)
import Message exposing (Message(..))
import File
import Html
    exposing
        ( Html
        , text
        )


{-| Render the breadcrumb.
-}
render : Model -> Html Message
render model =
    let
        crumbs =
            File.expandPath (Model.now model)
    in
        text "foo"
