module Gui.Tree exposing (render)

import Architecture exposing (Model, Message(..))
import File exposing (Path, File)
import Html exposing (Html, Attribute, a, div, text)
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Gui.Helper exposing (icon)


entryDirectory : Path -> ( Html Message, List (Attribute Message) )
entryDirectory path =
    let
        message =
            ChangeDirectory path
    in
        ( icon "folder", [ Attr.class "tree-elt folder", onClick message ] )


entryFile : Path -> ( Html Message, List (Attribute Message) )
entryFile path =
    let
        message =
            OpenFile path
    in
        ( icon "file", [ Attr.class "tree-elt not-folder", onClick message ] )


entry : Path -> File -> Html Message
entry path file =
    let
        ( fileIcon, attributes ) =
            if file.isDirectory then
                entryDirectory (path ++ [ file.name ])
            else
                entryFile (path ++ [ file.name ])
    in
        a attributes [ fileIcon, text file.name ]


parentFolder : Model -> List (Html Message)
parentFolder model =
    case List.reverse model.history.present of
        [] ->
            []

        [ _ ] ->
            []

        _ :: xs ->
            let
                path =
                    case xs of
                        [ "" ] ->
                            [ "Root" ]

                        _ ->
                            List.reverse xs

                message =
                    ChangeDirectory path
            in
                [ a
                    [ Attr.class "tree-elt folder parent", onClick message ]
                    [ icon "level-up", text (String.join "/" path) ]
                ]


render : Model -> Html Message
render model =
    let
        f =
            if model.showHidden then
                (\x -> x)
            else
                File.purgeHidden

        completeTree =
            (model.tree
                |> f
                |> List.map (entry model.history.present)
            )
    in
        div [] ((parentFolder model) ++ completeTree)
