package orishop.controllers.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import orishop.models.AccountModels;
import orishop.models.CartModels;
import orishop.models.CategoryModels;
import orishop.models.CustomerModels;
import orishop.models.ProductModels;
import orishop.models.RatingModels;
import orishop.services.CategoryServiceImp;
import orishop.services.ICategoryService;
import orishop.services.IProductService;
import orishop.services.IRatingService;
import orishop.services.ProductServiceImp;
import orishop.services.RatingServiceImpl;


@WebServlet(urlPatterns = {"/user/product/listProduct", "/user/product/productByCategory", "/user/product/detailProduct", 
		"/user/product/manager", "/user/product/insert", "/user/product/update",
		"/user/product/delete", "/user/product/filterDesc", "/user/product/filterAsc", 
		"/user/product/topProduct", "/user/product/searchProduct", "/user/product/review",
		"/user/product/deleterating"})
public class UserProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	IProductService productService = new ProductServiceImp();
	ICategoryService categoryService = new CategoryServiceImp();
	IRatingService ratingService = new RatingServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String url = req.getRequestURI().toString();
			if (url.contains("listProduct")) {
				getListProduct(req, resp);
				
			} else if (url.contains("productByCategory")) {
				getProductByCategory(req, resp);
				
			}else if (url.contains("detailProduct")) {
				getDetailProduct(req, resp);
				
			}
//			else if (url.contains("insert")) {
//				doGet_Insert(req, resp);
//			}
			else if (url.contains("update")) {
				getUpdate(req, resp);
			} else if (url.contains("delete")) {
				getDelete(req, resp);
			} else if (url.contains("filterDesc")) {
				getFilterDesc(req, resp);
			} else if (url.contains("filterAsc")) {
				getFilterAsc(req, resp);
			} else if (url.contains("topProduct")) {
				getTopProduct(req, resp);
			} else if (url.contains("review")) {
				
			} else if (url.contains("product/deleterating")) {
				getDeleteRating(req, resp);
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
			req.setAttribute("error", "Không tìm thấy sản phẩm.");
			req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
		}
}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String url = req.getRequestURI().toString();
			if (url.contains("update")) {
				doPost_Update(req, resp);
			} else if (url.contains("insert")) {
				doPost_Insert(req, resp);
			} else if (url.contains("searchProduct")) {
				postSearchProduct(req, resp);
			} else if (url.contains("review")) {
				postReview(req, resp);
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
			req.setAttribute("error", "Không tìm thấy sản phẩm.");
			req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
		}

	}

	// Hàm phụ để kiểm tra và chuyển đổi ID thành số nguyên (dành cho bảo mật)
	private int validateAndParseId(String idParam, String paramName, HttpServletResponse resp) throws IOException {
		if (idParam == null || !idParam.matches("\\d+") || idParam.length() > 10) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid " + paramName + " format");
			return -1;
		}
		int id = Integer.parseInt(idParam);
		if (id <= 0) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, paramName + " must be a positive number");
			return -1;
		}
		return id;
	}
	private String sanitizeInput(String input) {
	    if (input == null) return "1"; 
	    String sanitized = input.replaceAll("[<>&'\\\"]", "");
	    if (sanitized.length() > 10 || !sanitized.matches("\\d+")) {
	        return "1"; 
	    }
	    return sanitized;
	}
	// Hàm phụ để kiểm tra và chuyển đổi số trang
	private int validateAndParsePage(String pageParam, int maxPage, HttpServletResponse resp) throws IOException {
	    if (maxPage == 0) return 1;
	    if (pageParam == null) return 1;
	    try {
	        int page = Integer.parseInt(pageParam);
	        if (page <= 0 || page > maxPage) {
	            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Page number must be between 1 and " + maxPage);
	            return -1;
	        }
	        return page;
	    } catch (NumberFormatException e) {
	        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page number format");
	        return -1;
	    }
	}

	
	private void postSearchProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String proName = req.getParameter("searchProduct");
		List<ProductModels> listProduct = productService.findProduct(proName);
		
		int pagesize = 10;
		int size = listProduct.size();
		int num = (size%pagesize==0 ? (size/pagesize) : (size/pagesize + 1));


		String pageParam = sanitizeInput(req.getParameter("page"));
		int page = validateAndParsePage(pageParam, num, resp);
		if (page == -1) return;

		int start,end;
		start = (page - 1) * pagesize;
		end = Math.min(page*pagesize, size);
		List<ProductModels> list = productService.getListEmpByPage(listProduct, start, end);
		req.setAttribute("list", list);
		req.setAttribute("page", page);
		req.setAttribute("num", num);
		req.setAttribute("count", listProduct.size());
		
		List<CategoryModels> listCate = categoryService.findAllCategory();
		
		req.setAttribute("list", list);
		req.setAttribute("listC", listCate);

		
		req.getRequestDispatcher("/views/user/product/listproduct.jsp").forward(req, resp);
	}

	private void getTopProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<ProductModels> listProduct = productService.findTopProduct(10);
		int pagesize = 10;
		int size = listProduct.size();
		int num = (size%pagesize==0 ? (size/pagesize) : (size/pagesize + 1));
		
		String pageParam = sanitizeInput(req.getParameter("page"));
		int page = validateAndParsePage(pageParam, num, resp);
		if (page == -1) return;

		int start,end;
		start = (page - 1) * pagesize;
		end = Math.min(page*pagesize, size);
		List<ProductModels> list = productService.getListEmpByPage(listProduct, start, end);
		req.setAttribute("list", list);
		req.setAttribute("page", page);
		req.setAttribute("num", num);
		req.setAttribute("count", listProduct.size());
		
		List<CategoryModels> listCate = categoryService.findAllCategory();
		
		req.setAttribute("list", list);
		req.setAttribute("listC", listCate);

		
		req.getRequestDispatcher("/views/user/product/listproduct.jsp").forward(req, resp);
		
	}

	private void getFilterAsc(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<ProductModels> listProduct = productService.filterProductAscByPrice();
		int pagesize = 10;
		int size = listProduct.size();
		int num = (size%pagesize==0 ? (size/pagesize) : (size/pagesize + 1));
		
		String pageParam = sanitizeInput(req.getParameter("page"));
		int page = validateAndParsePage(pageParam, num, resp);
		if (page == -1) return;

		int start,end;
		start = (page - 1) * pagesize;
		end = Math.min(page*pagesize, size);
		List<ProductModels> list = productService.getListEmpByPage(listProduct, start, end);
		req.setAttribute("list", list);
		req.setAttribute("page", page);
		req.setAttribute("num", num);
		req.setAttribute("count", listProduct.size());
		
		List<CategoryModels> listCate = categoryService.findAllCategory();
		
		req.setAttribute("list", list);
		req.setAttribute("listC", listCate);

		
		req.getRequestDispatcher("/views/user/product/listproduct.jsp").forward(req, resp);
		
	}
	
	private void getDetailProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String pidParam = sanitizeInput(req.getParameter("pid"));
			if (pidParam == null) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID format");
				return;
			}
			int id = validateAndParseId(pidParam, "Product ID", resp);
			if (id == -1) return;

			ProductModels pro = productService.findOne(id);
			if (pro == null) {
				resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
				return;
			}

			HttpSession session = req.getSession();
			session.setAttribute("productID", pro.getProductId());
			req.setAttribute("p", pro);
			req.getRequestDispatcher("/views/user/product/detailproduct.jsp").forward(req, resp);
		} catch (Exception e) {
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
			e.printStackTrace(); // Ghi log thay vì in ra console
		}
	}

	private void getProductByCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cidParam = sanitizeInput(req.getParameter("cid"));
	    int id = validateAndParseId(cidParam, "Category ID", resp);
	    if (id == -1) return;
		
		List<ProductModels> listProduct = productService.findByCategory(id);
		
		req.setAttribute("list", listProduct);
		int pagesize = 10;
		int size = listProduct.size();
		int num = (size%pagesize==0 ? (size/pagesize) : (size/pagesize + 1));
		
		String pageParam = sanitizeInput(req.getParameter("page"));
		int page = validateAndParsePage(pageParam, num, resp);
	    if (page == -1) return;
	    
		int start,end;
		start = (page - 1) * pagesize;
		end = Math.min(page*pagesize, size);
		List<ProductModels> list = productService.getListEmpByPage(listProduct, start, end);
		req.setAttribute("list", list);
		req.setAttribute("page", page);
		req.setAttribute("num", num);
		req.setAttribute("count", listProduct.size());
		
		List<CategoryModels> listCate = categoryService.findAllCategory();
		
		req.setAttribute("list", list);
		req.setAttribute("listC", listCate);

		
		req.getRequestDispatcher("/views/user/product/listproduct.jsp").forward(req, resp);
	}

	private void getFilterDesc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		List<ProductModels> listProduct = productService.filterProductDescByPrice();
		int pagesize = 10;
		int size = listProduct.size();
		int num = (size%pagesize==0 ? (size/pagesize) : (size/pagesize + 1));
		
		String pageParam = sanitizeInput(req.getParameter("page"));
		int page = validateAndParsePage(pageParam, num, resp);
		if (page == -1) return;

		int start,end;
		start = (page - 1) * pagesize;
		end = Math.min(page*pagesize, size);
		List<ProductModels> list = productService.getListEmpByPage(listProduct, start, end);
		req.setAttribute("list", list);
		req.setAttribute("page", page);
		req.setAttribute("num", num);
		req.setAttribute("count", listProduct.size());
		
		List<CategoryModels> listCate = categoryService.findAllCategory();
		
		req.setAttribute("list", list);
		req.setAttribute("listC", listCate);

		
		req.getRequestDispatcher("/views/user/product/listproduct.jsp").forward(req, resp);

	}

//	private void doGet_Insert(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		List<CategoryModel> listCate = categoryService.findAllCategory();
//		req.setAttribute("listC", listCate);
//		req.getRequestDispatcher("/views/Product/insertProduct.jsp").forward(req, resp);
//		
//	}

	private void getDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String pidParam = sanitizeInput(req.getParameter("pid"));
	    int id = validateAndParseId(pidParam, "Product ID", resp);
	    if (id == -1) return;
	    
		ProductModels product = productService.findOne(id);
		productService.deleteProduct(product);
		resp.sendRedirect(req.getContextPath() + "/product/listproduct");

	}

	private void doPost_Insert(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		ProductModels product = new ProductModels();

		try {

			BeanUtils.populate(product, req.getParameterMap());

			product.setCategory(categoryService.findOne(product.getCategoryId()));

			productService.insertProduct(product);

		} catch (Exception e) {
			// TODO: handle exception
			
		}

		resp.sendRedirect(req.getContextPath() + "/product/manager");
	}

	private void doPost_Update(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		ProductModels product = new ProductModels();

		try {

			BeanUtils.populate(product, req.getParameterMap());

			product.setCategory(categoryService.findOne(product.getCategoryId()));

			productService.updateProduct(product);

		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(req.getContextPath() + "/product/manager");

	}

	// Chưa check
	private void getUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pidParam = sanitizeInput(req.getParameter("pid"));
	    int id = validateAndParseId(pidParam, "Product ID", resp);
	    if (id == -1) return;

		ProductModels product = productService.findOne(id);

		List<CategoryModels> listcate = categoryService.findAllCategory();

		req.setAttribute("P", product);
		req.setAttribute("listC", listcate);
		req.getRequestDispatcher("/views/Product/updateproduct.jsp").forward(req, resp);
	}

	private void getListProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<ProductModels> listProduct = productService.findAllProduct();
		int pagesize = 10;
		int size = listProduct.size();
		int num = (size%pagesize==0 ? (size/pagesize) : (size/pagesize + 1));

		String pageParam = sanitizeInput(req.getParameter("page"));
		if (pageParam == null) {
		resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page format");
		return;
		}
		int page = validateAndParsePage(pageParam, num, resp);
	    if (page == -1) return;
		
		int start,end;
		start = (page - 1) * pagesize;
		end = Math.min(page*pagesize, size);
		List<ProductModels> list = productService.getListEmpByPage(listProduct, start, end);
		req.setAttribute("list", list);
		req.setAttribute("page", page);
		req.setAttribute("num", num);
		req.setAttribute("count", listProduct.size());
		
		List<CategoryModels> listCate = categoryService.findAllCategory();
		
		req.setAttribute("list", list);
		req.setAttribute("listC", listCate);

		req.getRequestDispatcher("/views/user/product/listproduct.jsp").forward(req, resp);
	}
	
	private void postReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		HttpSession session = req.getSession();
		
		int id = (int) session.getAttribute("productID");
		ProductModels product = productService.findOne(id);
		CustomerModels customer = (CustomerModels) session.getAttribute("customer");
		String test = req.getParameter("review");
		String t = req.getParameter("rating");
		System.out.println("Review: " + test);
		System.out.println("Rating: " + t);
		RatingModels rating = ratingService.findOne(customer.getCustomerId(), product.getProductId());
		try {
			if(rating != null) {
				BeanUtils.populate(rating, req.getParameterMap());
				ratingService.update(rating);
				ratingService.delete(id);
			} else {
				rating = new RatingModels();
				BeanUtils.populate(rating, req.getParameterMap());
				rating.setCustomerId(customer.getCustomerId());
				rating.setProductId(product.getProductId());
				ratingService.insert(rating);
			}
		} catch (Exception ex) {
			//ex.printStackTrace();
		}

		req.setAttribute("p", product);
		
		session = req.getSession(true);
		session.setAttribute("productID", product.getProductId());
		req.getRequestDispatcher("/views/user/product/detailproduct.jsp").forward(req, resp);
	}
	
	private void getDeleteRating(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		String pidParam = sanitizeInput(req.getParameter("pid"));
	    int id = validateAndParseId(pidParam, "Product ID", resp);
	    if (id == -1) return;
	    
		ProductModels product = productService.findOne(id);
		HttpSession session = req.getSession();
		CustomerModels customer = (CustomerModels) session.getAttribute("customer");
		
		RatingModels rating = ratingService.findOne(customer.getCustomerId(), id);
		List<CategoryModels> listcate = categoryService.findAllCategory();
		
		ratingService.delete(rating.getRatingId());
		req.setAttribute("p", product);
		
		session = req.getSession(true);
		session.setAttribute("productID", product.getProductId());
		req.getRequestDispatcher("/views/user/product/detailproduct.jsp").forward(req, resp);
	}

}
