<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
{
    Schema::table('teachers', function (Blueprint $table) {
        $table->foreignId('major_id')
              ->after('gender')
              ->constrained()
              ->cascadeOnDelete();
    });
}

public function down()
{
    Schema::table('teachers', function (Blueprint $table) {
        $table->dropForeign(['major_id']);
        $table->dropColumn('major_id');
    });
}
};
