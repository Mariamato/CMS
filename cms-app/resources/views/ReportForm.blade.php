<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Submission of Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</head>

<body>
    <div class="container">

        <hi>Report</hi>
        <form action="submitReport" method="POST" enctype="multipart/form-data">
            @csrf

            <div>
                <label for="ReportId">Report Number:</label>
                <input type="text" id="ReportId" name="ReportId" required>
            </div>

            <div>
                <label for="TaskCompleted">Task Completed:</label>
                <input type="text" id="TaskCompleted" name="TaskCompleted" required>
            </div>

            <div>
                <label for="QualityOfServic">Quality Of Service Provided:</label>
                <textarea id="QualityOfService" name="QualityOfService" rows="4" required></textarea>
            </div>
            <div>
                <label for="DateOfService">Date Of provided Service:</label>
                <textarea id="DateOfService" name="DateOfService" rows="4" required></textarea>
            </div>
            <div>
                div>
                <label for="timeOfService">Time Of provided Service:</label>
                <textarea id="timeOfService" name="timeOfService" rows="4" required></textarea>
            </div>
            div>
            <label for="timeOfService">Time Of provided Service:</label>
            <textarea id="timeOfService" name="timeOfService" rows="4" required></textarea>
    </div>
    <div>
        <input type="submit" class="btn btn-primary">
    </div>

    </form>

</body>

</html>