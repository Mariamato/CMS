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
        Schema::create('_tasks', function (Blueprint $table) {
            $table->id();
            $table->String("TaskId");
            $table->String("TaskType");
            $table->String("Location");
            $table->String("priority");
            $table->String("Status");
            $table->String("DueTime");
            $table->String("ServiceProviderId");
            $table->String("MunicipalityId");
            $table->String("ScheduleId");
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('_tasks');
    }
};
