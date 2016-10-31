module Parting exposing (..)

{-| Parting functions and Msg.

# Model
@docs Model, init, model

# Message
@docs Msg

# Update function
@docs update

# View function
@docs view

# Main function
@docs main

# Common Helpers
@docs getParting, getRandomInt

# Static data
@docs partings
-}

import Html exposing (text, Html, div)
import Html.Attributes exposing (class)
import Html.App as HA
import Random
import Array


{-| Model
-}
type alias Model =
    String


{-| The inital model
-}
model : Model
model =
    ""


{-| Init the app and generate a random Int
-}
init : ( Model, Cmd Msg )
init =
    ( model, getRandomInt (List.length partings) )


{-| A list of availble partings
-}
partings : List String
partings =
    [ "Adieu"
    , "Adios"
    , "Arrivederci"
    , "Au revoir"
    , "Bye bye"
    , "Bye now"
    , "Bye"
    , "Catch ya"
    , "Catch you later"
    , "Farewell"
    , "Good-bye"
    , "Goodbye"
    , "Have a good one"
    , "later"
    , "Peace out"
    , "Peace"
    , "Sayonara"
    , "Seeya later"
    , "Seeya"
    , "So long"
    , "Ta-Ta"
    , "Take care"
    , "Tootles"
    ]


{-| Convert the partings list to an array and retrieve a value
-}
getParting : Int -> String -> String
getParting num model =
    let
        arr =
            Array.fromList partings
    in
        Array.get num arr
            |> Maybe.withDefault model


{-| Generate a Random int and send it to SetRandomInt
-}
getRandomInt : Int -> Cmd Msg
getRandomInt length =
    Random.generate SetRandomInt (Random.int 1 length)


{-| A union type representing The Elm Architect's `Msg`
-}
type Msg
    = SetRandomInt Int


{-| The Elm Architect's update function.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetRandomInt int ->
            ( getParting int model, Cmd.none )


{-| Render a parting element
-}
view : Model -> Html Msg
view model =
    div [ class "parting" ]
        [ text model
        ]


{-| The Elm Architect's main function.
-}
main : Program Never
main =
    HA.program
        ({ init = init
         , view = view
         , update = update
         , subscriptions = \_ -> Sub.none
         }
        )
