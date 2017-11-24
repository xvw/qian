module Component.SearchBar exposing (render)

{-| Component for rendering the search bar
-}

import Component.Helper exposing (icon)
import Html.Attributes as Attr
import Html
    exposing
        ( Html
        , text
        , div
        , input
        )


{-| Render the search bar
-}
render : String -> Html msg
render content =
    div
        [ Attr.class "search-bar" ]
        [ div [] [ icon "search" ]
        , searchInput content
        ]


{-| Render the search input
-}
searchInput : String -> Html msg
searchInput content =
    input
        [ Attr.placeholder "search an item ..." ]
        []
