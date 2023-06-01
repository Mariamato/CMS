<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('_schedule', function (Blueprint $table) {
            $table->id();
            
            $table->String("ScheduleId");
            $table->String("DateOfScheduleUpDated");
            $table->String("TimeOfScheduleUpDated");
            $table->String("StatusOfTheSchedule");
            $table->String("MunicipalityId");
 
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('_schedule');
    }
};
