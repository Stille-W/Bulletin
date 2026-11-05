<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>瀏覽公佈事項</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <c:if test="${not empty message}">
            <script>
                alert("${message}");
            </script>
    </c:if>
    <div class="container mt-5">
        <h2 class="mb-4">瀏覽公佈事項</h2>
        <a href="${pageContext.request.contextPath}/bulletin/add" class="btn btn-primary mb-3">新增公布訊息</a>

        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>標題</th>
                    <th>發佈日期</th>
                    <th>截止日期</th>
                    <th>修改</th>
                    <th>刪除</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty bulletinList}">
                        <tr>
                            <td colspan="5" class="text-center text-muted">無資料</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="b" items="${bulletinList}">
                            <tr>
                                <td><a href="${pageContext.request.contextPath}/bulletin/view?id=${b.id}" class="btn btn-sm btn-info">${b.title}</a></td>
                                <td><fmt:formatDate value="${b.publishDate}" pattern="yyyy-MM-dd"/></td>
                                <td><fmt:formatDate value="${b.expireDate}" pattern="yyyy-MM-dd"/></td>
                                <td><a href="${pageContext.request.contextPath}/bulletin/edit?id=${b.id}" class="btn btn-sm btn-warning">修改</a></td>
                                <td><a href="${pageContext.request.contextPath}/bulletin/delete?id=${b.id}" class="btn btn-sm btn-danger" onclick="return confirm('確定要刪除嗎？');">刪除</a></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">

                    <!-- 上一頁按鈕 -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage - 1}">上一頁</a>
                    </li>

                    <!-- 頁碼迴圈 (從 0 到 總頁數-1) -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <!-- 下一頁按鈕 -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage + 1}">下一頁</a>
                    </li>

                </ul>
            </nav>
    </div>
</body>
</html>