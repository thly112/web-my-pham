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
    <link href="/static/css/bootstrap.min.css" rel="stylesheet" />
    <link
      rel="stylesheet"
      href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css"
    />
  </head>
  <body>
    <%@ include file="/common/manager/header.jsp"%>
    <div>
      <decorator:head></decorator:head>
      <decorator:body></decorator:body>
    </div>
    <%@ include file="/common/manager/footer.jsp"%>

    <script src="/static/js/popper.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/templates/seller/js/index.js"></script>
  </body>
</html>
