<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Edit</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"
            integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
            crossorigin="anonymous"></script>
</head>
<body>
<p>This is test text</p>
<c:forEach items="${users}" var="user">
    <table border="1">
        <p>Information about user with id ${user.id} (${user.role})</p>
        <form action="/update" method="POST" id="${user.id}>
            E-mail:<br/><input type=" text
        " name="email" value="${user.email}"/><br/>
        Phone:<br/><input type="text" name="phone" value="${user.phone}"/><br/>
        Address:<br/><input type="text" name="address" value="${user.address}"/><br/>
        <input type="submit" value="Update"/>
        </form>
    </table>
</c:forEach>
</body>
</html>