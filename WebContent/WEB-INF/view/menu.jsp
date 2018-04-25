<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.dataTables.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Kalakaar</title>
</head>
<body>
	<table id="example" class="display menu" style="width: 30%" >
		<thead>
			<tr>
				<th>Name</th>
				<th>Price</th>
				<th>Type</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach items="${menulist}" var="menuItem">
				<tr>
					<td>${menuItem.itemName}</td>
					<td>${menuItem.price}</td>
					<td>${menuItem.type}</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>

</body>
</html>

<script>

$(document).ready(function() {
    $('#example').DataTable( {
        "pagingType": "full_numbers"
    } );
} );

</script>