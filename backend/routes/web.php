<?php

use Illuminate\Support\Facades\Route;
use App\Livewire\Users\UserIndex;
Route::get('/', function () {
    return view('auth.login');
});

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->name('dashboard');
});

Route::get('/test-flux', function () {
    return view('components.chart-message');
});



Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('/users', UserIndex::class)->name('users.index');
});

