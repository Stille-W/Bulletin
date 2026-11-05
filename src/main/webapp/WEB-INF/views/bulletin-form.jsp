<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>公佈事項表單</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
</head>
<body class="container mt-5">
    <h2 class="mb-4">
        <c:choose>
            <c:when test="${mode == 'view'}">檢視公佈事項</c:when>
            <c:when test="${mode == 'edit'}">${empty bulletin.id ? '新增公佈事項' : '編輯公佈事項'}</c:when>
        </c:choose>
    </h2>

    <form action="${pageContext.request.contextPath}/bulletin/save" method="post">
        <input type="hidden" name="id" value="${bulletin.id}" />

        <div class="mb-3">
            <label class="form-label">標題:</label>
            <input type="text" name="title" class="form-control" value="${bulletin.title}"
                ${mode == 'view' ? 'readonly' : 'required'} />
        </div>

        <div class="mb-3">
            <label class="form-label">發佈日期:</label>
            <input type="date" name="publishDate" class="form-control" value="<fmt:formatDate value='${bulletin.publishDate}' pattern='yyyy-MM-dd'/>"
                ${mode == 'view' ? 'readonly' : 'required'} />
        </div>

        <div class="mb-3">
            <label class="form-label">截止日期:</label>
            <input type="date" name="expireDate" class="form-control" value="<fmt:formatDate value='${bulletin.expireDate}' pattern='yyyy-MM-dd'/>"
                ${mode == 'view' ? 'readonly' : 'required'} />
        </div>

        <div class="mb-3">
            <label class="form-label">公佈者:</label>
            <input type="text" name="publisher" class="form-control" value="${bulletin.publisher}" readonly />
        </div>

        <div class="mb-3">
            <label class="form-label">公佈內容:</label>
            <div class="col-sm-10">
                <c:choose>
                    <c:when test="${mode == 'view'}">
                        <div class="p-3 border bg-light rounded" style="min-height: 200px;">
                            <c:out value="${bulletin.content}" escapeXml="false" />
                        </div>
                    </c:when>
                    <c:otherwise>
                        <textarea id="editor" name="content" class="form-control" rows="10">${bulletin.content}</textarea>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <c:if test="${mode != 'view'}">
            <button type="submit" class="btn btn-primary">儲存</button>
        </c:if>
        <a href="${pageContext.request.contextPath}/bulletin/list" class="btn btn-secondary">取消</a>
    </form>
    <c:if test="${mode != 'view'}">
        <script>
            if (typeof CKEDITOR !== 'undefined') {
                CKEDITOR.replace('editor');
            }
        </script>
    </c:if>
</body>
</html>