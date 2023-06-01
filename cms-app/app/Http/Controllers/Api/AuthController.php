<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use Illuminate\Http\Request;
use App\Models\Residents;
use Dotenv\Exception\ValidationException;
use Symfony\Component\Mime\Email;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    /*public function register(Request $request){
    $validator = Validator::make(
        $request->all(),
        [

            "FullName" => 'required |String | max:191',
            "Location" => 'required |String | max:191 |unique:users,Location',
            "PhoneNumber" => 'required | digits:10',
            "email" => 'required |email| max:191 |unique:users,email',
            "MunicipalityName" => 'required| max:191',
            "password" => 'required| min : 8',

        ]
    );

    if ($validator->fails()) {
        return response()->json([
            'status' => 422,
            'error' => $validator->messages(),
        ], 422);
    } else {
        $user = User::create([

            "FullName" => $request->FullName,
            "Location" => $request->Location,
            "PhoneNumber" => $request->PhoneNumber,
            "email" => $request->email,
            "MunicipalityName" => $request->MunicipalityName,
            "password" => Hash :: make($request -> password),
        ]);
        $token = $user -> createToken($user->email.'_token')->plainTextToken;
        return response()->json([
            'Status' => 200,
            'FullName' => $user->FullName,
            'MunicipalityName' => $request->MunicipalityName,
            'Location' => $request->Location,
            'token'=>$token,
            'Message' => 'User succesfull Registered',
        ], 200);
    }
 }

 public function login(Request $request){
    $validator = Validator::make(
        $request->all(),
        [
            "email" => 'required |email| max:191',
            "Password" => 'required ',
        ]
    );

    if ($validator->fails()) {
        return response()->json([
            'status' => 422,
            'error' => $validator->messages(),
        ], 422);
    }
    else {
        $user = User::where('email',$request->email)->first();
       if(!$user || ! Hash :: check($request->password,$user->password)){
       response()->json([
            'status' => 401,
            'message' => 'invalid Credentials',
        ], 401);
       }
       else{
        $token = $user -> createToken($user->email.'_token')->plainTextToken;
        return response()->json([
            'Status' => 200,
            'FullName' => $user->FullName,
            'Message' => 'Logged in succesfully',
        ], 200);
       }
    }

 }*/
    public function register(Request $request)
    {

        $userType = $request->header('user_type');

        switch ($userType) {
            case 'Municipality':
                return $this->RegisterMunicipality($request);
                break;

            case 'ServiceProvider':
                return $this->registerServiceProvider($request);
                break;

            case 'Resident':
                return $this->registerResident($request);
                break;

            default:
                return response()->json(['message' => 'Invalid user type'], 400);

        }

        //return response()->json(['message' => 'Registration successful']);
    }

    private function registerMunicipality(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                "FullName" => 'String | max:191',
                "MunicipalityName" => 'required| max:191',
                "Location" => 'required |String | max:191 |unique:users,Location',
                "PhoneNumber" => 'required | digits:10',
                "email" => 'required |email| max:191 |unique:users,email',
                "password" => 'required| min : 8',

            ]
        );

        if ($validator->fails()) {
            return response()->json([
                'status' => 422,
                'error' => $validator->messages(),
            ], 422);
        } else {
            $user = User::create([

                "MunicipalityName" => $request->MunicipalityName,
                "Location" => $request->Location,
                "PhoneNumber" => $request->PhoneNumber,
                "email" => $request->email,
                "password" => Hash::make($request->password),
            ]);
            $token = $user->createToken($user->email . '_token')->plainTextToken;
            return response()->json([
                'Status' => 200,
                'MunicipalityName' => $request->MunicipalityName,
                'Location' => $request->Location,
                'token' => $token,
                'Message' => 'Municipality Staff succesfully Registered',
            ], 200);
        }
    }

    private function registerServiceProvider(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [

                "FullName" => 'required |String | max:191',
                "Location" => 'required |String | max:191 |unique:users,Location',
                "PhoneNumber" => 'required | digits:10',
                "email" => 'required |email| max:191 |unique:users,email',
                "MunicipalityName" => 'required| max:191',
                "password" => 'required| min : 8',
                "Speciality" => 'required |String | max:191',

            ]
        );

        if ($validator->fails()) {
            return response()->json([
                'status' => 422,
                'error' => $validator->messages(),
            ], 422);
        } else {
            $user = User::create([

                "FullName" => $request->FullName,
                "Location" => $request->Location,
                "PhoneNumber" => $request->PhoneNumber,
                "email" => $request->email,
                "MunicipalityName" => $request->MunicipalityName,
                "password" => Hash::make($request->password),
                "Speciality" => $request->Speciality,
            ]);
            $token = $user->createToken($user->email . '_token')->plainTextToken;

            return response()->json([
                'Status' => 200,
                'FullName' => $user->FullName,
                'MunicipalityName' => $request->MunicipalityName,
                'Location' => $request->Location,
                'Speciality' => $request->Speciality,
                'token' => $token,
                'Message' => 'Service Provider succesfully Registered',
            ], 200);
        }
    }

    private function registerResident(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [

                "FullName" => 'required |String | max:191',
                "Location" => 'required |String | max:191 |unique:users,Location',
                "PhoneNumber" => 'required | digits:10',
                "email" => 'required |email| max:191 |unique:users,email',
                "MunicipalityName" => 'required| max:191',
                "password" => 'required| min : 8',

            ]
        );

        if ($validator->fails()) {
            return response()->json([
                'status' => 422,
                'error' => $validator->messages(),
            ], 422);
        } else {
            $user = User::create([

                "FullName" => $request->FullName,
                "Location" => $request->Location,
                "PhoneNumber" => $request->PhoneNumber,
                "email" => $request->email,
                "MunicipalityName" => $request->MunicipalityName,
                "password" => Hash::make($request->password),
            ]);
            $token = $user->createToken($user->email . '_token')->plainTextToken;
            return response()->json([
                'Status' => 200,
                'FullName' => $user->FullName,
                'MunicipalityName' => $request->MunicipalityName,
                'Location' => $request->Location,
                'token' => $token,
                'Message' => 'Resident successfully Registered',
            ], 200);
        }
    }
}
