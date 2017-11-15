module Gui.Tree exposing (render)

import Architecture exposing (Model, Message(..))
import Path exposing (Path, File, Parent(..))
import Html exposing (Html, Attribute, a, div, text)
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Gui.Helper exposing (icon)
import Action


entryDirectory : Path -> ( Html Message, List (Attribute Message) )
entryDirectory path =
    let
        message =
            Patch (Action.changeDir path)
    in
        ( icon "folder", [ Attr.class "tree-elt folder", onClick message ] )


entryFile : Path -> ( Html Message, List (Attribute Message) )
entryFile path =
    let
        message =
            Patch (Action.openFile path)
    in
        ( icon "file", [ Attr.class "tree-elt not-folder", onClick message ] )


entry : Path -> File -> Html Message
entry path file =
    let
        fullPath =
            Path.join [ path, file.name ]

        ( fileIcon, attributes ) =
            if file.isDirectory then
                entryDirectory fullPath
            else
                entryFile fullPath
    in
        a attributes [ fileIcon, text file.name ]


parentFolder : Model -> List (Html Message)
parentFolder model =
    case Path.parent model.history.present of
        AtRoot ->
            []

        baseParent ->
            let
                ( parent, content ) =
                    case baseParent of
                        Root ->
                            ( "", "Root" )

                        Folder f ->
                            ( f, f )

                        _ ->
                            ( "never here", "never here" )

                message =
                    Patch (Action.changeDir parent)
            in
                [ a
                    [ Attr.class "tree-elt folder parent", onClick message ]
                    [ icon "level-up", text content ]
                ]


render : Model -> Html Message
render model =
    let
        completeTree =
            List.map (entry model.history.present) model.displayedTree.entries
    in
        div [] ((parentFolder model) ++ completeTree)
