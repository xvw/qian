module Gui.Tree exposing (render)

import Architecture exposing (Model, Message(..))
import File exposing (Path, File)
import Html exposing (Html, Attribute, a, div, text)
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Gui.Helper exposing (icon)


entryDirectory : Path -> File -> ( Html Message, List (Attribute Message) )
entryDirectory path file =
    let
        message =
            ChangeDirectory (path ++ [ file.name ])
    in
        ( icon "folder", [ Attr.class "tree-elt folder", onClick message ] )


entryFile : Path -> File -> ( Html Message, List (Attribute Message) )
entryFile path file =
    ( icon "file", [ Attr.class "tree-elt not-folder" ] )


entry : Path -> File -> Html Message
entry path file =
    let
        ( fileIcon, attributes ) =
            if file.isDirectory then
                entryDirectory path file
            else
                entryFile path file
    in
        a attributes [ fileIcon, text file.name ]


render : Model -> Html Message
render model =
    let
        f =
            if model.showHidden then
                (\x -> x)
            else
                File.purgeHidden
    in
        div []
            (model.tree
                |> f
                |> List.map (entry model.history.present)
            )
