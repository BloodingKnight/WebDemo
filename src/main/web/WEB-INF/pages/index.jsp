<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>WebDemo</title>
</head>
<body>
<h1>Index Page</h1>
<span style="position: relative; float: right">Welcome! <shiro:principal/></span>
<hr />
</body>
</html>
