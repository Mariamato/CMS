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
        Schema::create('_service_provider_view_schedules', function (Blueprint $table) {
            $table->id();

            $table->String("ServiceProviderId");
            $table->String("ScheduleID");

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('_service_provider_view_schedules');
    }
};
