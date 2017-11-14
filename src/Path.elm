module Path
    exposing
        ( File
        , Path
        , Tree
        , Parent(..)
        , purgeHidden
        , filterBy
        , join
        , parent
        , child
        , split
        , unroll
        )


type alias File =
    { name : String
    , isHidden : Bool
    , isDirectory : Bool
    }


type alias Path =
    String


type alias Tree =
    { path : Path
    , entries : List File
    }


type Parent
    = AtRoot
    | Root
    | Folder Path


purgeHidden : Tree -> Tree
purgeHidden tree =
    { tree | entries = List.filter (\x -> not x.isHidden) tree.entries }


entryFilter : String -> File -> Bool
entryFilter pred file =
    let
        lowerSearch =
            String.toLower pred

        lowerName =
            String.toLower file.name
    in
        String.contains lowerSearch lowerName


filterBy : String -> Tree -> Tree
filterBy pred tree =
    if String.isEmpty pred then
        tree
    else
        { tree | entries = List.filter (entryFilter pred) tree.entries }


join : List String -> Path
join path =
    String.join "/" path


child : Path -> String -> String
child path file =
    join [ path, file ]


split : Path -> List String
split path =
    if path == "/" || path == "" then
        [ "" ]
    else
        String.split "/" path


parent : Path -> Parent
parent path =
    case List.reverse (split path) of
        [] ->
            AtRoot

        [ _ ] ->
            AtRoot

        [ _, _ ] ->
            Root

        _ :: xs ->
            Folder (join (List.reverse xs))


unrollReducer : String -> List ( Path, Path ) -> List ( Path, Path )
unrollReducer element path =
    case path of
        [] ->
            [ ( "", "Root" ) ]

        ( x, _ ) :: _ ->
            ( join [ x, element ], element ) :: path


unroll : Path -> List ( Path, Path )
unroll path =
    path
        |> split
        |> (List.foldl unrollReducer [])
        |> List.reverse
