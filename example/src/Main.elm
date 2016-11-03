module Main exposing (..)

import Html exposing (text, Html, div, span)
import Html.Attributes exposing (classList)
import Html.App as HA
import Parting
import Task
import Process
import Time


type alias Model =
    { parting : Parting.Model
    , visible : Bool
    }


model : Model
model =
    { parting = Parting.model
    , visible = False
    }


init : ( Model, Cmd Msg )
init =
    let
        ( str, msg ) =
            Parting.init
    in
        ( model, Cmd.batch [ Cmd.map PartingMsg msg, delayVisibility ] )


type Msg
    = PartingMsg Parting.Msg
    | Visible Bool
    | NoOp ()


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

        NoOp _ ->
            ( model, Cmd.none )

        Visible bool ->
            ( { model | visible = bool }, Cmd.none )


delayVisibility : Cmd Msg
delayVisibility =
    Task.perform NoOp Visible
        <| Process.sleep (1 * Time.second)
        `Task.andThen` \_ -> Task.succeed True


renderParting : Model -> Html Msg
renderParting model =
    HA.map PartingMsg (Parting.view model.parting)


view : Model -> Html Msg
view model =
    div
        [ classList
            [ ( "app", True )
            , ( "visible", model.visible )
            ]
        ]
        [ renderParting model
        , span [] [ text ", thanks for being awesome!" ]
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
