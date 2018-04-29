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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Kalakaar</title>
</head>
<body>
	<form id="menuForm">

		<p style="position: relative; top: 0; width: 100%; text-align: center">
			<font size="6" color="brown" face="Droid Sans"><b><i><u>Kalakaar</u></i></b></font>
		</p>

		<div id="selectItemsDiv">
		
		
<input id="selectedTable" type="hidden" value="${tableNumber}"/>
			<table style="width: 40; height: 1%" border="1" id="selectedmenu">
				<tr>
					<th>NAME</th>
					<th>CODE</th>
					<th>PRICE</th>
					<th>TYPE</th>
					<th>QUANTITY</th>
					<th>REMOVE</th>
				</tr>
				<tbody>
					<c:forEach items="${orderList}" var="orderItem" varStatus="item">
						<tr id="selectedItem_${item.index}">
							<td id="itemnameadd_${item.index}"
								name="itemnameadd_${item.index}">${orderItem.itemName}</td>
							<td id="itemCodeadd_${item.index}"
								name="itemCodeadd_${item.index}">${orderItem.itemCode}</td>
							<td id="priceadd_${item.index}" name="priceadd_${item.index}">
								${orderItem.price}</td>
							<td id="typeadd_${item.index}" name="typeadd_${item.index}">
								${orderItem.type}</td>
							<td><input type="text" id="quantityadd_${item.index}"
								name="quantityadd_${item.index}" style="width: 20%"
								value="${orderItem.quantity}"
								onblur="updateQuantity('${item.index}')" /></td>
							<td><input type="button" value="remove"
								onclick="removeRow('${item.index}')" /></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>

			<span class="custom-dropdown big"> <select id="myselect" onchange="submitform()">
					<option value="1">Table 1</option>
					<option value="2">Table 2</option>
					<option value="3">Table 3</option>
					<option value="4">Table 4</option>
					<option value="5">Table 5</option>
					<option value="6">Table 6</option>
			</select>
			</span>

		</div>
		<table id="example" class="display menu"
			style="width: 40%; height: 2%">
			<thead>
				<tr>
					<b>
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
						<td><input type="text" id="quantity_${item.index}"
							name="quantity_${item.index}" style="width: 50%" value="1" /></td>
						<td><input type="button" id="add_${item.index}"
							name="add_${item.index}" value="Add"
							onclick="addRow('${item.index}')" /></td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
	</form>
</body>
</html>

<script>
	$(document).ready(
			function() {
				$('#example').DataTable({
					"pagingType" : "full_numbers",
					"pageLength" : 8
				});
				var tbl = $('#selectedTable').val();
				 $("#myselect option").each(function(i){
				        if($(this).val()==tbl){
				        	$(this).attr("selected", true);
				        }
				    });

			});

	function addRow(index) {
		
		var codeAlreadyPresent = false;
		
		$('#selectedmenu > tbody  > tr').each(function() {

			var $tds = $(this).find('td');
			var itemcode = $('#itemCode_' + index).text();
			if($tds.eq(1).text()==itemcode){
				codeAlreadyPresent  =true;
			}
		});

		if(codeAlreadyPresent){
			alert("Item already added. Modify it's quatity");
			
		}else{
		
		var item = {
			table_number : $( "#myselect" ).val() ,
			orders : [ {
				item_name : $('#itemname_' + index).text(),
				item_code : $('#itemCode_' + index).text(),
				price : $('#price_' + index).text(),
				type : $('#type_' + index).text(),
				quantity : $('#quantity_' + index).val()
			} ] 
		};

		$.ajax({
			url : 'addOrder',
			type : 'post',
			contentType: 'application/json',
			dataType : 'json',
			data : JSON.stringify(item),
			success : function(data) {

			},
		});

		if ($('#quantity_' + index).val() == 0) {
			alert("Quantity cannot be 0");
			return;
		}

		$('#selectedmenu')
				.append(
						'<tr id="selectedItem_'+index+'"><td id="itemnameadd_'+index+'" name="itemnameadd_'+index+'">'
								+ $('#itemname_' + index).text()
								+ '</td><td id="itemCodeadd_'+index+'" name="itemCodeadd_'+index+'">'
								+ $('#itemCode_' + index).text()
								+ '</td><td id="priceadd_'+index+'" name="priceadd_'+index+'">'
								+ $('#price_' + index).text()
								+ '</td><td id="typeadd_'+index+'" name="typeadd_'+index+'">'
								+ $('#type_' + index).text()
								+ '</td><td ><input type="text" id="quantityadd_'+index+'" name="quantityadd_'+index+'" style="width: 20%" value="'+$('#quantity_' + index).val()+'" onblur="updateQuantity('
								+ index + ')" />'
								+ '</td><td ><input type="button" value="remove" onclick="removeRow('
								+ index + ')"/></td></tr></table>');
		}
	}

	function removeRow(index) {
		
		var item = {
				table_number : $( "#myselect" ).val() ,
				orders : [ {
					item_name : $('#itemnameadd_' + index).text(),
					item_code : $('#itemCodeadd_' + index).text(),
					price : $('#priceadd_' + index).text(),
					type : $('#typeadd_' + index).text(),
					quantity : $('#quantityadd_' + index).val()
				} ] 
			};

			$.ajax({
				url : 'removeOrder',
				type : 'post',
				contentType: 'application/json',
				dataType : 'json',
				data : JSON.stringify(item),
				success : function(data) {

				},
			});
		
		
		
		$('#selectedItem_' + index).remove();
	}
	
	
	
function updateQuantity(index) {
	
		var item = {
				table_number : $( "#myselect" ).val() ,
				orders : [ {
					item_name : $('#itemnameadd_' + index).text(),
					item_code : $('#itemCodeadd_' + index).text(),
					price : $('#priceadd_' + index).text(),
					type : $('#typeadd_' + index).text(),
					quantity : $('#quantityadd_' + index).val()
				} ] 
			};

			$.ajax({
				url : 'modifyOrderQuatity',
				type : 'post',
				contentType: 'application/json',
				dataType : 'json',
				data : JSON.stringify(item),
				success : function(data) {

				},
			});
	}
	
	function submitform (){
		var tableNumber =  $( "#myselect" ).val();
		window.location.href = 'menu?tableNumber='+tableNumber;
		window.form[0].submit();
		
	}
	

</script>