<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Request for a pickup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </head>
    <body>
<div class="container">
    
    <hi>Report</hi>
    <form action="submit" method="POST" enctype="multipart/form-data">
    @csrf

    <div>
        <label for="Task">Task:</label>
        <input type="text" id="taskType" name="taskType" required>
    </div>

    <div>
        <label for="Location">Location:</label>
        <input type="text" id="location" name="location" required>
    </div>

    <div>
        <label for="Task Description">Task Description:</label>
        <textarea id="taskDescription" name="taskDescription" rows="4" required></textarea>
    </div>

<div>
    <input type="submit" class="btn btn-primary">
  </div>  

</form>

    </body>
</html>