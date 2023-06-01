<?php

namespace App\Http\Controllers\Api;

use App\Models\Residents;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

class ResidentsController extends Controller
{
    public function index()
    {
        $residents = Residents::all();
        if ($residents->count() > 0) {
            return response()->json([
                'status' => 200,
                'Residents' => $residents,
            ], 200);
        } else {
            return response()->json([
                'status' => 404,
                'Residents' => 'not found now',
            ], 200);
        }
    }

    public function store(request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'ResidentId' => 'required | max:191',
                "ResidentName" => 'required |String | max:191',
                "PhysicalAddress" => 'required |String | max:191',
                "PhoneNumber" => 'required | digits:10',
                "e-mail" => 'required |email| max:191',
                "PaymentStatus" => 'required |boolean | max:191',
                "MuniciplId" => 'required | max:191',
                "ServiceProviderId" => 'required | max:191',
            ]
        );

        if ($validator->fails()) {
            return response()->json([
                'status' => 422,
                'error' => $validator->messages(),
            ], 422);
        } else {
            $residents = Residents::create([
                'ResidentId' => $request->ResidentId,
                "ResidentName" => $request->ResidentName,
                "PhysicalAddress" => $request->PhysicalAddress,
                "PhoneNumber" => $request->PhoneNumber,
                "e-mail" => $request->email,
                "PaymentStatus" => $request->PaymentStatus,
                "MuniciplId" => $request->MuniciplId,
                "ServiceProviderId" => $request->ServiceProviderId,
            ]);
        }
        if ($residents) {
            return response()->json([
                'Status' => 200,
                'Message' => 'Resident succesful created',
            ], 200);
        } else {
            return response()->json([
                'Status' => 500,
                'Message' => 'something went wrong',
            ], 500);
        }
    }

    public function show()
    {
        $residents = Residents::find();
        if ($residents) {
            return response()->json([
                'Status' => 200,
                'Resident' => $residents,
            ], 200);
        } else {
            return response()->json([
                'Status' => 404,
                'Message' => 'No such Resident',
            ], 404);
        }
    }

    public function edit($id)
    {
        $residents = Residents::find();
        if ($residents) {
            return response()->json([
                'Status' => 200,
                'Resident' => $residents,
            ], 200);
        } else {
            return response()->json([
                'Status' => 404,
                'Message' => 'No such Resident',
            ], 404);
        }
    }

    public function update(Request $request, int $id)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'ResidentId' => 'required | max:191',
                "ResidentName" => 'required |String | max:191',
                "PhysicalAddress" => 'required |String | max:191',
                "PhoneNumber" => 'required | digits:10',
                "e-mail" => 'required |email| max:191',
                "PaymentStatus" => 'required |boolean | max:191',
                "MuniciplId" => 'required | max:191',
                "ServiceProviderId" => 'required | max:191',
            ]
        );

        if ($validator->fails()) {
            return response()->json([
                'status' => 422,
                'error' => $validator->messages(),
            ], 422);
        } else {
            $residents = Residents::find($id);
            if ($residents) {
                $residents->updated([
                    'ResidentId' => $request->ResidentId,
                    "ResidentName" => $request->ResidentName,
                    "PhysicalAddress" => $request->PhysicalAddress,
                    "PhoneNumber" => $request->PhoneNumber,
                    "e-mail" => $request->email,
                    "PaymentStatus" => $request->PaymentStatus,
                    "MuniciplId" => $request->MuniciplId,
                    "ServiceProviderId" => $request->ServiceProviderId,
                ]);
                return response()->json([
                    'Status' => 200,
                    'Message' => 'Resident succesful updated ',
                ], 200);
            } else {
                return response()->json([
                    'Status' => 404,
                    'Message' => 'No such resident found',
                ], 500);
            }
        }
    }
    public function destroy($id)
    {
        $residents = Residents::find($id);
        if ($residents) {
            $residents -> delete();
            return response()->json([
                'Status' => 200,
                'Message' => 'Resident deleted succesful',
            ], 200);
        } else {
            return response()->json([
                'Status' => 404,
                'Message' => 'No such Resident',
            ], 404);
        }
    }
}
