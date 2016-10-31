module Main exposing (..)

import Html exposing (text, Html, div)
import Html.Attributes exposing (class)
import Html.App as HA
import Parting


type alias Model =
    { parting : Parting.Model
    }


model : Model
model =
    { parting = Parting.model
    }


init : ( Model, Cmd Msg )
init =
    let
        ( str, msg ) =
            Parting.init
    in
        ( model, Cmd.map PartingMsg msg )


type Msg
    = PartingMsg Parting.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PartingMsg subMsg ->
            let
                ( updatedPartingModel, progressCmd ) =
                    Parting.update subMsg model.parting
            in
                ( { model | parting = updatedPartingModel }
                , Cmd.map PartingMsg progressCmd
                )


renderParting : Model -> Html Msg
renderParting model =
    HA.map PartingMsg (Parting.view model.parting)


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ renderParting model
        ]


main : Program Never
main =
    HA.program
        ({ init = init
         , view = view
         , update = update
         , subscriptions = \_ -> Sub.none
         }
        )
