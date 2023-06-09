<?php

namespace App\Http\Controllers;
use App\Models\Report;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class ReportController extends Controller
{
    public function Reportindex()
    {
        return view('ReportForm');
    }
    public function submitReport(Request $request)
    {
        $validator=Validator::make($request->all(),
        [
            "ReportId"=> 'required | max:191 ',
            "TaskCompleted"=> 'required | max:191 ',
            "DateOfService"=> 'required | max:191 ',
            "TimeOfService"=> 'required | max:191 ',
            "QualityOfService"=> 'required | max:191 ',
            "Location"=> 'required | max:191 ',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'Validation error' => $validator->messages(),
            ], 400);
        } 
        $report= new Report;
        $report->taskType=$request->input('ReportId');
        $report->location=$request->input('TaskCompleted');
        $report->taskDescription=$request->input('DateOfService');
        $report->taskType=$request->input('TimeOfService');
        $report->location=$request->input('QualityOfService');
        $report->taskDescription=$request->input('Location');
    return response()->json([
    'status'=>200,
    'message'=>'Task submitted successfully',
]);
    }
    
    public function ViewReport(Request $request)
    {
        
        $report= Report::all();
    return response()->json([
    'status'=>200,
    'Report'=>$report,
]);
    }


}
