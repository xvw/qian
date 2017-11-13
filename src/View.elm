module View exposing (global)

import Architecture exposing (Model, Message(..))
import Html
    exposing
        ( Html
        , div
        , main_
        , footer
        , header
        )
import Gui.Toolbox as Toolbox
import Gui.Breadcrumb as Breadcrumb
import Gui.Command as Command
import Gui.Tree as Tree
import Gui.Seekbar as Seekbar


global : Model -> Html Message
global model =
    div []
        [ header []
            [ Toolbox.render model
            , Breadcrumb.render model
            ]
        , main_ [] [ Tree.render model ]
        , footer
            []
            [ Seekbar.render model
            , Command.render model
            ]
        ]
