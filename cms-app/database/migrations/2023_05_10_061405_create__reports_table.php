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
        Schema::create('_reports', function (Blueprint $table) {
            $table->id();

            $table->String("ReportId");
            $table->String("DateAndTimeOfService");
            $table->String("TaskCompleted");
            $table->String("QualityOfServiceProvided");
            $table->String("ReportStatus");
            $table->String("ServiceProviderId");
            $table->String("MunicipalityId");
            $table->String("ResidentID");

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('_reports');
    }
};
