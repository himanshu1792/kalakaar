<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/jquery.dataTables.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Kalakaar</title>
</head>
<body>
<form id="menuForm">

	<p style="position: relative; top: 0; width: 100%; text-align: center">
		<font size="6" color="brown" face="Droid Sans"><b><i><u>Kalakaar</u></i></b></font>
	</p>
	
	<table id="example" class="display menu"
		style="width: 40%; height: 40%">
		<thead>
			<tr><b>
				<th>NAME</th>
				<th>CODE</th>
				<th>PRICE</th>
				<th>TYPE</th>
				<th>QUANTITY</th>
				<th>ADD ITEM</th>
				</b>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${menuList}" var="menuItem" varStatus="item">
				<tr id="menu_row_${item.index}" name="menu_row_${item.index}">
					<td id="itemname_${item.index}" name="itemname_${item.index}">${menuItem.itemName}</td>
					<td id="itemCode_${item.index}" name="itemCode_${item.index}">${menuItem.itemCode}</td>				
					<td id="price_${item.index}" name="price_${item.index}">${menuItem.price}</td>
					<td id="type_${item.index}" name="type_${item.index}">${menuItem.type}</td>
					<td ><input type="text" id="quantity_${item.index}" name="quantity_${item.index}" style="width:50%" value="1"/></td>
					<td ><input type="button" id="add_${item.index}" name="add_${item.index}" value="Add" onclick="addRow('${item.index}')"/></td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
</form>
</body>
</html>

<script>
	$(document).ready(function() {
		$('#example').DataTable({
			"pagingType" : "full_numbers",
			"pageLength": 8
		});
		
		$('#example_wrapper').append('<table style="width: 40; height: 40%" border="1" id="selectedmenu"><tr><th >' + " NAME" + '</th><th >' + " PRICE" + '</th><th >' + " TYPE" + '</th><th >' + " QUANTITY" + '</th><th >' + " REMOVE" + '</th></tr></table>');
		
	});
	
	
	function addRow(index) {
		
		if($('#quantity_'+index).val()==0){
			alert("Quantity cannot be 0");
			return;
		}
		
	    $('#selectedmenu').append('<tr id="selectedItem_'+index+'"><td >' + $('#itemname_'+index).text() + '</td><td >' + $('#price_'+index).text() + '</td><td >' + $('#type_'+index).text() + '</td><td >' + $('#quantity_'+index).val() + '</td><td ><input type="button" value="remove" onclick="removeRow('+index+')"/></td></tr></table>');
	}
	
	
	function removeRow(index){
		$('#selectedItem_'+index).remove();
	}
	
	
</script>