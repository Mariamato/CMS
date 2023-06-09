<?php

namespace App\Http\Controllers;
use App\Models\TaskModel;
use Illuminate\Http\Request;
use Illuminate\Console\View\Components\Task;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class TaskController extends Controller
{
    public function Taskindex()
    {
        return view('TaskForm');
    }
    public function Submit(Request $request)
    {
        $validator=Validator::make($request->all(),
        [
            "taskType" => 'required | max:191 ',
            "location" => 'required| max : 191',
            "taskDescription" => 'required| max : 191',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'Validation error' => $validator->messages(),
            ], 400);
        } 
        $taskModel= new TaskModel;
        $taskModel->taskType=$request->input('taskType');
        $taskModel->location=$request->input('location');
        $taskModel->taskDescription=$request->input('taskDescription');
    return response()->json([
    'status'=>200,
    'message'=>'Task submitted successfully',
]);
    }
    
    public function ViewTask(Request $request)
    {
        
        $taskModel= TaskModel::all();
    return response()->json([
    'status'=>200,
    'TaskModel'=>$taskModel,
]);
    }


}
