module SearchState exposing (SearchState(..), nextStep)

{-| Expose some function to filter by fuzzy search
-}

import File


{-| Define the kind of navigation
-}
type SearchState
    = ToParent File.Path
    | ToHome
    | ToDir File.Item
    | StayHere String


{-| Define the next step using the current tree and the searchState
-}
nextStep : File.Path -> String -> File.Tree -> SearchState
nextStep path search currentTree =
    case search of
        "../" ->
            case File.parent path of
                Just x ->
                    ToParent x

                Nothing ->
                    StayHere search

        "~/" ->
            ToHome

        elt ->
            if String.endsWith "/" elt then
                case currentTree of
                    x :: _ ->
                        ToDir x

                    _ ->
                        StayHere elt
            else
                StayHere elt
