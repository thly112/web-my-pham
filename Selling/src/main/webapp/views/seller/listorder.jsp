<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/common/taglist.jsp"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Seller</title>
    <!--FONTAWESOME-->
    <link
      href="https://cdn.jsdelivr.net/gh/hung1001/font-awesome-pro@4cac1a6/css/all.css"
      rel="stylesheet"
      type="text/css"
    />

    <!--FONT GOOGLE-->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@300;400;600;700&dsplay=swap"
      rel="stylesheet"
    />

    <!--MAIN CSS-->
    <link
      href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css"
    />
  </head>
  <body>
    <%@ include file="/common/manager/header.jsp"%>
    <div class="container-fluid">
      <!--Menu-->
      <div class="row">
        <div class="col-lg-2 border-end">
          <div class="card mt-4">
            <div
              class="card-header"
              data-bs-toggle="collapse"
              href="#collapseExample1"
            >
              Quản lý đơn hàng
            </div>
            <div class="collapse" id="collapseExample1">
              <div class="card-body">
                <div class="list-group">
                  <a
                    href="listorder"
                    class="list-group-item list-group-item-action"
                    >Tất cả</a
                  >
                  <a href="#" class="list-group-item list-group-item-action"
                    >Đơn hủy</a
                  >
                  <a href="#" class="list-group-item list-group-item-action"
                    >Hoàn tiền</a
                  >
                </div>
              </div>
            </div>
          </div>
          <div class="card mt-3">
            <div
              class="card-header"
              data-bs-toggle="collapse"
              href="#collapseExample2"
            >
              Quản lý sản phẩm
            </div>
            <div class="collapse" id="collapseExample2">
              <div class="card-body">
                <div class="list-group">
                  <a
                    href="listproduct"
                    class="list-group-item list-group-item-action"
                    >Tất cả</a
                  >
                  <a href="#" class="list-group-item list-group-item-action"
                    >Thêm sản phẩm</a
                  >
                  <a href="#" class="list-group-item list-group-item-action"
                    >Sản phẩm và vi phạm</a
                  >
                  <a href="#" class="list-group-item list-group-item-action"
                    >Cài đặt sản phẩm</a
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-9 mt-3">
          <div class="row mt-3">
            <div class="col-12">
              <div class="card">
                <div class="card-body">
                  <!-- Đây có thể là DataTable -->
                  <table id="example" class="display" style="width: 100%">
                    <thead>
                      <tr>
                        <th>OrderId</th>
                        <th>Order Value</th>
                        <th>Order Data</th>
                        <th>Card Id</th>
                        <th>Customer Id</th>
                        <th>Payment Status</th>
                        <th>Order Status</th>
                        <th>Payment Method</th>
                        <th>Delivery Method</th>
                        <th>Employee Id</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="i" items="${listorder}">
                        <tr>
                          <td>
                            <a
                              href="detailorder?orderid=${i.orderID}"
                              class="text-dark text-decoration-none"
                              >${i.orderID}</a
                            >
                          </td>
                          <td>${i.orderValue}</td>
                          <td>${i.orderDate}</td>
                          <td>${i.cartID}</td>
                          <td>${i.customerID}</td>
                          <td>${i.paymentStatus}</td>
                          <td>${i.orderStatus}</td>
                          <td>${i.paymentMethod}</td>
                          <td>${i.deliveryMethod}</td>
                          <td>${i.employeeId}</td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/common/manager/footer.jsp"%>
    <script src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/templates/seller/js/index.js"></script>
  </body>
</html>
