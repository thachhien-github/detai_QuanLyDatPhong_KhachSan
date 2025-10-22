<%-- 
    Document   : alert
    Created on : Oct 15, 2025, 12:41:14 AM
    Author     : PC
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty sessionScope.success}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            position: "center",
            icon: "success",
            title: '${sessionScope.success}',
            showConfirmButton: false,
            timer: 1500,
            timerProgressBar: true
        });
    </script>
    <c:remove var="success" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.error}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            position: "center",
            icon: "error",
            title: '${sessionScope.error}',
            showConfirmButton: true,
            confirmButtonText: "OK"
        });
    </script>
    <c:remove var="error" scope="session"/>
</c:if>
