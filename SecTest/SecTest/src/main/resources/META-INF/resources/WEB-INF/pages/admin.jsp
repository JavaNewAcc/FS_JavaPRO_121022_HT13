<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Prog.kiev.ua</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"
            integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
            crossorigin="anonymous"></script>
</head>
<body>
<div align="center">
    <h1>Secret page for admins only!</h1>
    <p>Click to go back: <a href="/">back</a></p>

    <p>Click to logout: <a href="/logout">LOGOUT</a></p>

    <button type="button" id="add_user">Add</button>
    <button type="button" id="delete_user">Delete</button>

    <table border="1">
        <c:forEach items="${users}" var="user">
            <tr id="${user.id}">
                <td><input type="checkbox" name="toDelete" value="${user.id}" id="check_${user.id}"></td>
                <td><c:out value="${user.login}"/></td>
                <td><c:out value="${user.role}"/></td>
                <td><c:out value="${user.email}"/></td>
                <td><c:out value="${user.phone}"/></td>
                <td><c:out value="${user.address}"/></td>
                <td>
                    <button type="button" id="edit_user_${user.id}">Edit</button>
                </td>
            </tr>
            <tr style="display: none" id="edit_row_${user.id}">
                <form id="editForm_${user.id}" action="/update" method="POST">
                    <td></td>
                    <td><input style="visibility: hidden" type="text" name="login" value="${user.login}"></td>
                    <td><input style="visibility: hidden" type="text" name="role" value="ROLE_${user.role}"></td>
                    <td><input type="text" name="email" value="${user.email}" placeholder="email"></td>
                    <td><input type="text" name="phone" value="${user.phone}" placeholder="phone"></td>
                    <td><input type="text" name="address" value="${user.address}" placeholder="address"></td>
                    <td>
                        <input type="submit" value="Update"/>
                    </td>
                </form>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
    $('#add_user').click(function () {
        window.location.href = "/register";
    });

    $('#delete_user').click(function () {
        var data = {'toDelete': []};
        $(":checked").each(function () {
            data['toDelete'].push($(this).val());
        });
        $.post("/delete", data, function (data, status) {
            window.location.reload();
        });
    });

    // -----------
    $('button[id^="edit_user_"]').click(function () {
        var userId = this.id.replace('edit_user_', '');
        $('#edit_row_' + userId).toggle();
    });
    // -----------
</script>
</body>
</html>
