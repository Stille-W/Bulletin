<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>系統發生錯誤</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5 text-center">
    <div class="alert alert-danger" role="alert">
        <h4 class="alert-heading">哎呀！系統出了一點狀況</h4>
        <p>我們已經記錄此問題，請稍後再試。</p>
    </div>
    <a href="${pageContext.request.contextPath}/bulletin/list" class="btn btn-primary">返回首頁</a>
</body>
</html>