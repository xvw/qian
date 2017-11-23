module Component.TreeView exposing (render)

{-| This module is a component to display the file system of a current Path
-}

import Message exposing (Message(..))
import File exposing (PathMember(..))
import Component.Helper exposing (iconCustom)
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Html
    exposing
        ( Html
        , text
        , ul
        , li
        , span
        )


{-| Render the Tree of Files.
-}
render : File.Path -> File.Tree -> Html Message
render currentPath tree =
    ul
        []
        (List.map mapTree tree)


{-| Render an item of the tree into a <li>
-}
mapTree : File.FromFinder -> Html Message
mapTree item =
    li
        [ onClick (OpenItem item) ]
        [ iconFor item.directory
        , span [ Attr.class "item-name" ] [ text item.name ]
        ]


{-| Render an icon specific to a folder of a file
-}
iconFor : Bool -> Html Message
iconFor isDirectory =
    if isDirectory then
        iconCustom "folder" [ "directory" ] []
    else
        iconCustom "file" [ "file" ] []
