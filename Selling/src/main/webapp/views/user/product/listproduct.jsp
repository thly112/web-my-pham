<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglist.jsp"%>
<%@ page import="java.lang.Math" %>

<!DOCTYPE html>
<html>

<head>
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/all.min.css">
<link
	href="${pageContext.request.contextPath}/templates/user/css/product/style.css"
	rel="stylesheet" type="text/css">
</head>

<body>
    <nav aria-label="breadcrumb" style="padding: 25px; padding-left: 100px; align-items: center;">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/Selling/user/home">Oriflame</a></li>
            <li class="breadcrumb-item"><a href="#">ListProduct</a></li>
        </ol>
    </nav>

    <!-- FILTER PRODUCTS -->
    <div class="dropdown-center" style="display: flex; justify-content: end; margin-right: 20px;">
        <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-filter filter-icon"></i> Lọc
        </button>
        <ul class="dropdown-menu">
            <h5 style="margin: 20px;">Sắp xếp theo</h5>
            <li><a class="dropdown-item d-flex align-items-center" href="topProduct"> <span>Mới nhất</span></a></li>
            <li><a class="dropdown-item d-flex align-items-center" href="filterDesc"> <span>Giá cao tới thấp</span></a></li>
            <li><a class="dropdown-item d-flex align-items-center" href="filterAsc"> <span>Giá thấp tới cao</span></a></li>
        </ul>
    </div>
    <!-- END FILTER PRODUCTS -->
    <div>
        <h1 style="text-align: center;">DANH SÁCH SẢN PHẨM</h1>
    </div>
    <!-- NAVIGATION BAR BEGIN -->
    <ul class="nav justify-content-center">
        <c:forEach var="i" items="${listC}">
            <li class="nav-item"><a class="nav-link" href="productByCategory?cid=${i.categoryId}"><c:out value="${i.categoryName}" /></a></li>
        </c:forEach>
    </ul>
    <div style="margin: 20px;">
        <div class="row justify-content-center">
            <c:if test="${list.size() > 0 }">
                <c:forEach var="i" items="${list}">
                    <div class="card col-md-3">
                        <a href="detailProduct?pid=${i.productId}"> <img src="${i.imageURL}" class="card-img-top" alt="..."></a>
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="ratings">
                                    <c:forEach begin="1" end="${ratingService.averageRating(i.productId) }">
                                        <i class="fa fa-star rating-color"></i>
                                    </c:forEach>
                                    <c:forEach begin="1" end="${5 - ratingService.averageRating(i.productId) }">
                                        <i class="fa fa-star"></i>
                                    </c:forEach>
                                </div>
                                <h5 class="review-count">${ratingService.findByProduct(i.productId).size()} Reviews</h5>
                            </div>
                            <h5 class="card-title card__Name">${i.productName}</h5>
                            <p class="card-text card__Text">${i.description}</p>
                            <p class="price card__Price">${i.price}</p>
                            <%-- Không hiển thị createdDate hoặc timestamp nếu có --%>
                            <%-- <p class="card-text">${i.createdDate}</p> --%>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${list.size() <= 0 }">
                <h1 style="text-align: center;">HIỆN CHƯA CÓ SẢN PHẨM LOẠI NÀY</h1>
            </c:if>
        </div>
    </div>
    <div class="row g-0 align-items-center pb-4">
        <div class="col-sm-6">
            <div class="float-sm-end">
                <ul class="pagination mb-sm-0">
                    <c:if test="${page <= 1 }">
                        <li class="page-item disabled"><a href="listProduct?page=${page - 1}" class="page-link"><i class="mdi mdi-chevron-left"></i></a></li>
                    </c:if>
                    <c:if test="${page > 1 }">
                        <li class="page-item"><a href="listProduct?page=${page - 1}" class="page-link"><i class="mdi mdi-chevron-left"></i></a></li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${num }">
                        <c:if test="${i == page }">
                            <li class="page-item active"><a href="listProduct?page=${i}" class="page-link">${i }</a></li>
                        </c:if>
                        <c:if test="${i != page }">
                            <li class="page-item"><a href="listProduct?page=${i}" class="page-link">${i }</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${page < num}">
                        <li class="page-item"><a href="listProduct?page=${page + 1}" class="page-link"><i class="mdi mdi-chevron-right"></i></a></li>
                    </c:if>
                    <c:if test="${page >= num}">
                        <li class="page-item disabled"><a href="listProduct?page=${page + 1}" class="page-link"><i class="mdi mdi-chevron-right"></i></a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- NAVIGATION BAR END -->

	<script
		src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
</body>

</html>