module Zipper.History
    exposing
        ( History
        , new
        , push
        , pop
        , present
        , backward
        , forward
        , hasPast
        , hasFuture
        )


type alias History a =
    { past : List a
    , future : List a
    }


new : () -> History a
new () =
    { past = []
    , future = []
    }


push : History a -> a -> History a
push zipper data =
    { past = data :: zipper.past, future = [] }


rewrite : History a -> a -> History a
rewrite zipper data =
    { zipper | past = data :: zipper.past }


present : History a -> Maybe a
present zipper =
    case zipper.past of
        [] ->
            Nothing

        x :: _ ->
            Just x


pop : History a -> ( Maybe a, History a )
pop zipper =
    case zipper.past of
        [] ->
            ( Nothing, zipper )

        x :: xs ->
            ( Just x, { zipper | past = xs } )


backward : History a -> History a
backward zipper =
    case zipper.past of
        [] ->
            zipper

        x :: xs ->
            { past = xs, future = x :: zipper.future }


forward : History a -> History a
forward zipper =
    case zipper.future of
        [] ->
            zipper

        x :: xs ->
            { past = x :: zipper.past, future = xs }


hasPast : History a -> Bool
hasPast zipper =
    not (List.isEmpty zipper.past)


hasFuture : History a -> Bool
hasFuture zipper =
    not (List.isEmpty zipper.future)
