module Component.SearchBar exposing (render)

{-| Component for rendering the search bar
-}

import Message exposing (Message(..))
import Component.Helper exposing (icon)
import Html.Attributes as Attr
import Html.Events exposing (onInput)
import Html
    exposing
        ( Html
        , text
        , div
        , input
        )


{-| Render the search bar
-}
render : String -> Html Message
render content =
    div
        [ Attr.class "search-bar" ]
        [ div [] [ icon "search" ]
        , searchInput content
        ]


{-| Render the search input
-}
searchInput : String -> Html Message
searchInput content =
    input
        [ Attr.placeholder "search an item ..."
        , Attr.value content
        , Attr.autofocus True
        , onInput RecordSearchState
        ]
        []
