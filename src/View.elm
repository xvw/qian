module View exposing (global)

{-| The entry point for the views
-}

import Model exposing (Model)
import Message exposing (Message)
import Html
    exposing
        ( Html
        , text
        , div
        , header
        , footer
        , main_
        )
import Html.Attributes as Attr
import Component.Breadcrumb as Breadcrumb
import Component.HistoryButtons as HistoryButtons
import Component.TreeView as TreeView
import Component.SearchBar as SearchBar
import Component.ToolBox as ToolBox


{-| The global view of the Application.
-}
global : Model -> Html Message
global model =
    let
        currentPath =
            Model.now model
    in
        div
            [ Attr.class "inner-app" ]
            [ header []
                [ Breadcrumb.render currentPath
                , HistoryButtons.render model.history
                ]
            , main_
                [ Attr.class "tree-view" ]
                [ TreeView.render currentPath model.currentTree ]
            , footer
                []
                [ SearchBar.render
                , ToolBox.render model
                ]
            ]
