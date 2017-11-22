module Component.Helper exposing (fa, icon, iconCustom)

{-| Provide some useful function to write the components
-}

import Html
    exposing
        ( Html
        , Attribute
        , i
        )
import Html.Attributes as Attr


{-| Create a list of attributes to promote a node to an FontAwesome Icon
-}
fa : String -> List String -> List (Attribute msg)
fa icon otherClasses =
    let
        classes =
            [ "fa", "fa-" ++ icon ]
                ++ otherClasses
                |> String.join " "
    in
        [ Attr.class classes
        , Attr.attribute "aria-hidden" "true"
        ]


{-| Create a FontAwesome Icon
-}
icon : String -> Html msg
icon identifier =
    iconCustom identifier [] []


{-| Create a FontAwesome Icon paramterizable
-}
iconCustom : String -> List String -> List (Attribute msg) -> Html msg
iconCustom identifier classes attributes =
    i ((fa identifier classes) ++ attributes) []
