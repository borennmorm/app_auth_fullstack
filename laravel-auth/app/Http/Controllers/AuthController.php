<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $rules =[
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
        ];

        $validator = Validator::make($request->all(), $rules);

        if($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;
        $response = ['user' => $user, 'token' => $token];

        return response()->json($response, 200);
    }

    public function login(Request $request)
    {
        // Validation rules
        $rules =[
            'email' => 'required|string|email|max:255',
            'password' => 'required|string|min:8',
        ];

        // Validate the request
        $request->validate($rules);

        // Find user by email
        $user = User::where('email', $request->email)->first();

        // Check if the user exists and the password is correct
        if($user && Hash::check($request->password, $user->password)) {
            // Create token
            $token = $user->createToken('auth_token')->plainTextToken;
            $response = ['user' => $user, 'token' => $token];
            return response()->json($response, 200);
        }

        // Return error if credentials are incorrect
        $response = ['message' => 'Incorrect email or password'];
        return response()->json($response, 400);
    }




    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Successfully logged out',
        ]);
    }



}
