<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<c:if test="${not empty sessionScope.success}">
    <script>
        Swal.fire({
            icon: 'success',
            title: '<c:out value="${sessionScope.success}" />',
            showConfirmButton: false,
            timer: 1500
        });
    </script>
    <c:remove var="success" scope="session" />
</c:if>

<c:if test="${not empty sessionScope.error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: '<c:out value="${sessionScope.error}" />',
            confirmButtonText: 'OK'
        });
    </script>
    <c:remove var="error" scope="session" />
</c:if>
