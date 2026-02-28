<?php

namespace App\Livewire\Teachers;

use App\Models\User;
use App\Models\Teacher;
use Livewire\Component;
use Illuminate\Support\Facades\Hash;

class TeacherCreate extends Component
{
    public $name = '';
    public $email = '';
    public $password = '';
    public $role = 'teacher';

    public $gender = '';
    public $major = '';
    public $year = '';
    public $schedule = '';
    public $phone = '';
    public $faculty = '';

    protected $rules = [
        'name'     => 'required|string|max:255',
        'email'    => 'required|email|unique:users,email',
        'password' => 'required|min:8',
        'gender'   => 'required',
        'major'    => 'required',
        'year'     => 'required',
        'schedule' => 'required',
        'phone'    => 'required',
        'faculty'  => 'required',
    ];

    public function save()
    {
        $this->validate();

        // 1️⃣ Create User
        $user = User::create([
            'name'     => $this->name,
            'email'    => $this->email,
            'password' => Hash::make($this->password),
            'role'     => 'teacher',
        ]);

        // 2️⃣ Create Teacher
        Teacher::create([
            'user_id'   => $user->id,
            'name' => $this->name,
            'gender'    => $this->gender,
            'major'     => $this->major,
            'year'      => $this->year,
            'schedule'  => $this->schedule,
            'phone'     => $this->phone,
            'faculty'   => $this->faculty,
        ]);

        $this->reset();

        session()->flash('success', 'Teacher created successfully!');
    }

    public function render()
    {
        return view('livewire.teachers.teacher-create')
            ->layout('layouts.app');
    }
}
