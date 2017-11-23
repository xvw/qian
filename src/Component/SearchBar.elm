module Component.SearchBar exposing (render)

{-| Component for rendering the search bar
-}

import Component.Helper exposing (iconCustom)
import Html.Attributes as Attr
import Html
    exposing
        ( Html
        , text
        , div
        )


{-| Render the search bar
-}
render : Html msg
render =
    div [ Attr.class "search-bar" ] [ text "search" ]
