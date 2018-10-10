module Zipper.Tabs exposing
    ( Tabs
    , backward
    , current
    , deleteCurrent
    , deleteNext
    , fold
    , forward
    , fromList
    , hasCurrent
    , map
    , pop
    , push
    , shift
    )


type Tabs a
    = Tabs
        { left : List a
        , right : List a
        }


make : List a -> List a -> Tabs a
make left right =
    Tabs
        { left = left
        , right = right
        }


new : () -> Tabs a
new () =
    make [] []


fromList : List a -> Tabs a
fromList aList =
    case aList of
        x :: xs ->
            make [ x ] xs

        [] ->
            make [] []


push : Tabs a -> a -> Tabs a
push (Tabs zipper) value =
    make
        (value :: zipper.left)
        zipper.right


current : Tabs a -> Maybe a
current (Tabs zipper) =
    List.head zipper.left


backward : Tabs a -> Maybe (Tabs a)
backward (Tabs zipper) =
    case zipper.left of
        [] ->
            Nothing

        x :: xs ->
            Just (make xs (x :: zipper.right))


forward : Tabs a -> Maybe (Tabs a)
forward (Tabs zipper) =
    case zipper.right of
        [] ->
            Nothing

        x :: xs ->
            Just (make (x :: zipper.left) xs)


hasCurrent : Tabs a -> Bool
hasCurrent zipper =
    case current zipper of
        Nothing ->
            False

        Just _ ->
            True


pop : Tabs a -> ( Maybe a, Tabs a )
pop (Tabs zipper) =
    case zipper.left of
        [] ->
            ( Nothing, Tabs zipper )

        x :: xs ->
            ( Just x, make xs zipper.right )


shift : Tabs a -> ( Maybe a, Tabs a )
shift (Tabs zipper) =
    case zipper.right of
        [] ->
            ( Nothing, Tabs zipper )

        x :: xs ->
            ( Just x, make zipper.left xs )


deleteCurrent : Tabs a -> Tabs a
deleteCurrent =
    Tuple.second << pop


deleteNext : Tabs a -> Tabs a
deleteNext =
    Tuple.second << shift


map : (a -> b) -> Tabs a -> Tabs b
map f (Tabs zipper) =
    make
        (List.map f zipper.left)
        (List.map f zipper.right)


fold : (a -> b -> b) -> b -> Tabs a -> b
fold reducer init (Tabs zipper) =
    zipper.left
        |> List.foldl reducer init
        |> (\x -> List.foldl reducer x zipper.right)
