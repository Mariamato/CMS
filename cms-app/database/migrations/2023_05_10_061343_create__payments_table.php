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
        Schema::create('_payments', function (Blueprint $table) {
            $table->id();

            $table->String("PaymentId");
            $table->String("AmountDued");
            $table->String("ControlNumber");
            $table->String("PaymentMethod");
            $table->String("PaymentStatus");
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
        Schema::dropIfExists('_payments');
    }
};
