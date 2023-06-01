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
        Schema::create('_service_poviders', function (Blueprint $table) {
            $table->id();
            $table->String("ServiceProviderId");
            $table->String("ServiceProviderName");
            $table->String("location");
            $table->String("PhoneNumber");
            $table->String("e-mail");
            $table->String("speciality");
            $table->String("MuniciplId");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('_service_poviders');
    }
};
