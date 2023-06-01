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
        Schema::create('_municipality', function (Blueprint $table) {
            $table->id();
            $table->String("MunicipalityId");
            $table->String("MunicipalityName");
            $table->String("PhoneNumber");
            $table->String("e-mail");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('_municipality');
    }
};
