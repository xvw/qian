module Component.HistoryButtons exposing (render)

import Zipper.History as History exposing (History)
import File
import Model exposing (Model)
import Message exposing (Message(..))
import Html
    exposing
        ( Html
        , text
        )


render : History File.Path -> Html Message
render history =
    text "lol"
