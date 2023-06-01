<?php

use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use Illuminate\Validation\ValidationException;
use App\Http\Controllers\Api\ResidentsController;



Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::post('/sanctum/token', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required',
        'device_name' => 'required',
    ]);

    $user = User::where('email', $request->email)->first();

    if (! $user || ! Hash::check($request->password, $user->password)) {
        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }

    return $user->createToken($request->device_name)->plainTextToken;
});

Route::middleware('auth:sanctum')->get('/user/revoke', function (Request $request) {
    $user = $request -> user();
    $user -> tokens()->delete();
    return 'tokens are deleted';
});

Route::post('register',[\App\Http\Controllers\Api\AuthController::class, 'register']);
Route::post('login',[AuthController::class, 'login']);

Route::get('residents',[ResidentsController::class, 'index']);
Route::post('residents',[ResidentsController::class, 'store']);
Route::get('residents/{id}',[ResidentsController::class, 'show']);
Route::get('residents/{id}/edit',[ResidentsController::class, 'edit']);
Route::put('residents/{id}/edit',[ResidentsController::class, 'update']);
Route::put('residents/{id}/delete',[ResidentsController::class, 'destroy']);
