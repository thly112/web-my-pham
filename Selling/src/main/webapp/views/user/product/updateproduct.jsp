<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@page
contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round"
    />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
    />
    <link
      href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    />
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <style>
      img {
        width: 200px;
        height: 120px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="table-wrapper">
        <div class="table-title">
          <div class="row">
            <div class="col-sm-6">
              <h2>Edit <b>Product</b></h2>
            </div>
            <div class="col-sm-6"></div>
          </div>
        </div>
      </div>
      <div id="editEmployeeModal">
        <div class="modal-dialog">
          <div class="modal-content">
            <form action="update" method="post">
              <div class="modal-header">
                <h4 class="modal-title">Edit Product</h4>
                <button
                  type="button"
                  class="close"
                  data-dismiss="modal"
                  aria-hidden="true"
                >
                  &times;
                </button>
              </div>
              <div class="modal-body">
                <div class="form-group">
                  <label>ID</label>
                  <input
                    value="${P.productID}"
                    name="productID"
                    type="text"
                    class="form-control"
                    readonly
                    required
                  />
                </div>
                <div class="form-group">
                  <label>Name</label>
                  <input
                    value="${P.productName}"
                    name="productName"
                    type="text"
                    class="form-control"
                    required
                  />
                </div>
                <div class="form-group">
                  <label>Image</label>
                  <input
                    value="${P.imageURL}"
                    name="imageURL"
                    type="text"
                    class="form-control"
                    required
                    style="object-fit: cover"
                  />
                </div>
                <div class="form-group">
                  <label>Stock</label>
                  <input
                    value="${P.stock}"
                    name="stock"
                    type="text"
                    class="form-control"
                    required
                  />
                </div>
                <div class="form-group">
                  <label>Amount</label>
                  <input
                    value="${P.amount}"
                    name="amount"
                    type="text"
                    class="form-control"
                    required
                  />
                </div>
                <div class="form-group">
                  <label>Price</label>
                  <input
                    value="${P.price}"
                    name="price"
                    type="text"
                    class="form-control"
                    required
                  />
                </div>
                <!--
                                <div class="form-group">
                                    <label>Title</label>
                                    <textarea name="title" class="form-control" required>${detail.title}</textarea>
                                </div>   -->
                <div class="form-group">
                  <label>Description</label>
                  <textarea name="description" class="form-control" required>
${P.description}</textarea
                  >
                </div>
                <div class="form-group">
                  <label for="category">Category</label>
                  <select
                    name="categoryID"
                    class="form-select"
                    aria-label="Default select example"
                  >
                    <c:forEach items="${listC}" var="o">
                      <option value="${o.categoryID}">${o.categoryName}</option>
                    </c:forEach>
                  </select>
                </div>
              </div>
              <div class="modal-footer">
                <input type="submit" class="btn btn-success" value="Edit" />
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <script src="js/manager.js" type="text/javascript"></script>
  </body>
</html>
