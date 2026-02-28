<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Teacher extends Model
{
   protected $fillable = [
    'user_id',
    'name',
    'gender',
    'major',
    'year',
    'schedule',
    'phone',
    'faculty',
];
public function user()
{
    return $this->belongsTo(User::class);
}
}


