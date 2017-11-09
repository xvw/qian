module View exposing (global)

import Architecture exposing (Model, Message(..))
import Html
    exposing
        ( Html
        , Attribute
        , i
        , text
        , div
        , main_
        , footer
        , header
        , ul
        , li
        , span
        , input
        , a
        )
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Zipper.History as History
import File exposing (File, Tree, Path)


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


global : Model -> Html Message
global model =
    div []
        [ header []
            [ makeToolbox model
            , makeHeader model
            ]
        , main_ [] (makeContent model)
        , footer [] (makeFooter model)
        ]


makeToolbox : Model -> Html Message
makeToolbox model =
    let
        linkHome =
            if model.history.present == model.home then
                i (fa "home" [ "disabled" ]) []
            else
                a
                    [ onClick (ChangeDirectory model.home) ]
                    [ i (fa "home" []) [] ]

        linkRoot =
            if model.history.present == [ "" ] then
                i (fa "hdd-o" [ "disabled" ]) []
            else
                a
                    [ onClick (ChangeDirectory [ "" ]) ]
                    [ i (fa "hdd-o" []) [] ]
    in
        div
            [ Attr.class "toolbox" ]
            [ linkRoot
            , linkHome
            ]


makeContent : Model -> List (Html Message)
makeContent model =
    model.tree
        |> File.purgeHidden
        |> List.map (renderItem model.history.present)


renderItem : Path -> File -> Html Message
renderItem pwd element =
    let
        ( attr, icon ) =
            if element.isDirectory then
                ( [ Attr.class "tree-elt folder"
                  , onClick (ChangeDirectory (pwd ++ [ element.name ]))
                  ]
                , i (fa "folder" []) []
                )
            else
                ( [ Attr.class "tree-elt not-folder" ], i (fa "file" []) [] )
    in
        div
            attr
            [ icon, text element.name ]


makeHeader : Model -> Html Message
makeHeader model =
    ul
        [ Attr.class "breadcrumb" ]
        ((makeBreadcrumb model model.history.present [] [])
            |> List.reverse
        )


makeBreadcrumb : Model -> Path -> Path -> List (Html Message) -> List (Html Message)
makeBreadcrumb model pwd marked acc =
    case pwd of
        [] ->
            acc

        [ elt ] ->
            (li [] (renderCrumb "" elt)) :: acc

        x :: xs ->
            let
                path =
                    marked ++ [ x ]
            in
                makeBreadcrumb
                    model
                    xs
                    path
                    ((clickableCrumb path x) :: acc)


renderCrumb : String -> String -> List (Html Message)
renderCrumb sep folder =
    let
        content =
            if String.isEmpty folder then
                text "Root"
            else
                text folder
    in
        [ content, span [] [ text sep ] ]


clickableCrumb : Path -> String -> Html Message
clickableCrumb pwd folder =
    li
        []
        [ a
            [ onClick (ChangeDirectory pwd) ]
            (renderCrumb "/" folder)
        ]


backButton : Model -> Html Message
backButton model =
    let
        ( class, message ) =
            if History.hasPast model.history then
                ( [ "enabled" ], [ onClick Backward ] )
            else
                ( [ "disabled" ], [] )
    in
        i ((fa "arrow-circle-left" class) ++ message) []


nextButton : Model -> Html Message
nextButton model =
    let
        ( class, message ) =
            if History.hasFuture model.history then
                ( [ "enabled" ], [ onClick Forward ] )
            else
                ( [ "disabled" ], [] )
    in
        i ((fa "arrow-circle-right" class) ++ message) []


makeFooter : Model -> List (Html Message)
makeFooter model =
    [ input
        [ Attr.placeholder "command"
        , Attr.type_ "text"
        ]
        []
    , div [] [ backButton model, nextButton model ]
    ]
