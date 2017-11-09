module File exposing (File, Path, Tree, purgeHidden)


type alias File =
    { name : String
    , isHidden : Bool
    , isDirectory : Bool
    }


type alias Path =
    List String


type alias Tree =
    List File


purgeHidden : Tree -> Tree
purgeHidden =
    List.filter (\x -> not x.isHidden)
