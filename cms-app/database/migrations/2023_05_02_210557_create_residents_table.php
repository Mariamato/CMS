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
        Schema::create('residents', function (Blueprint $table) {
            $table->id();
            
            $table->String("ResidentId");
            $table->String("ResidentName");
            $table->String("PhysicalAddress");
            $table->String("PhoneNumber");
            $table->String("e-mail");
            $table->String("PaymentStatus");
            $table->String("MuniciplId");
            $table->String("ServiceProviderId");
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('residents');
    }
};
