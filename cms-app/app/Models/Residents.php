<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Residents extends Model
{
    use HasFactory;

    protected $table = "residents";

    protected $fillable = [
        "ResidentId",
        "ResidentName",
        "PhysicalAddress",
        "PhoneNumber",
        "e-mail",
        "PaymentStatus",
        "MuniciplId",
        "ServiceProviderId",
    ];
}
