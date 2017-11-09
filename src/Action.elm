module Action
    exposing
        ( changeDirectory
        )

import Zipper.History as History
import Architecture exposing (Model, Message(..), Pwd)


changeDirectory : Model -> Pwd -> ( Model, Cmd Message )
changeDirectory model newPwd =
    let
        history =
            model.history

        pwd =
            model.pwd
    in
        ( { model
            | pwd = newPwd
            , history = History.push history pwd
          }
        , Cmd.none
        )
