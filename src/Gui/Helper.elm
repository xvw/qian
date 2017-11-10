module Gui.Helper exposing (fa, icon, iconCustom, boolToClass)

import Html
    exposing
        ( Html
        , Attribute
        , i
        )
import Html.Attributes as Attr


boolToClass : Bool -> String
boolToClass f =
    if f then
        "enabled"
    else
        "disabled"


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


icon : String -> Html msg
icon identifier =
    iconCustom identifier [] []


iconCustom : String -> List String -> List (Attribute msg) -> Html msg
iconCustom identifier classes attributes =
    i ((fa identifier classes) ++ attributes) []
