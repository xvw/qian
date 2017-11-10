module Action
    exposing
        ( changeHistory
        , toggleHidden
        )

import Zipper.History exposing (History)
import Architecture exposing (Model, Message(..))
import File exposing (Path)
import Port


changeHistory : Model -> (History Path -> History Path) -> ( Model, Cmd Message )
changeHistory model f =
    let
        newModel =
            { model | history = f model.history }
    in
        ( newModel, Port.ls newModel.history.present )


toggleHidden : Model -> ( Model, Cmd Message )
toggleHidden model =
    ( { model | showHidden = not model.showHidden }, Cmd.none )
