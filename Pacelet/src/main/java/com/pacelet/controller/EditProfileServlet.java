package com.pacelet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile/edit")
public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Personal details
        request.setAttribute(
                "fullName",
                session.getAttribute("shippingFullName")
        );

        request.setAttribute(
                "phone",
                session.getAttribute("shippingPhone")
        );

        // Address details
        request.setAttribute(
                "pincode",
                session.getAttribute("shippingPincode")
        );

        request.setAttribute(
                "addressLine",
                session.getAttribute("shippingAddressLine")
        );

        request.setAttribute(
                "city",
                session.getAttribute("shippingCity")
        );

        request.setAttribute(
                "state",
                session.getAttribute("shippingState")
        );

        request.getRequestDispatcher(
                "/edit-profile.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName =
                request.getParameter("fullName");

        String phone =
                request.getParameter("phone");

        String pincode =
                request.getParameter("pincode");

        String addressLine =
                request.getParameter("addressLine");

        String city =
                request.getParameter("city");

        String state =
                request.getParameter("state");


        // =========================================
        // VALIDATION
        // =========================================

        if (
                fullName == null || fullName.isBlank()
                || phone == null || phone.isBlank()
                || pincode == null || pincode.isBlank()
                || addressLine == null || addressLine.isBlank()
                || city == null || city.isBlank()
                || state == null || state.isBlank()
        ) {

            request.setAttribute(
                    "error",
                    "Please fill all required fields."
            );

            setFormAttributes(
                    request,
                    fullName,
                    phone,
                    pincode,
                    addressLine,
                    city,
                    state
            );

            request.getRequestDispatcher(
                    "/edit-profile.jsp"
            ).forward(request, response);

            return;
        }


        // =========================================
        // PHONE VALIDATION
        // =========================================

        if (!phone.matches("\\d{10}")) {

            request.setAttribute(
                    "error",
                    "Please enter a valid 10-digit phone number."
            );

            setFormAttributes(
                    request,
                    fullName,
                    phone,
                    pincode,
                    addressLine,
                    city,
                    state
            );

            request.getRequestDispatcher(
                    "/edit-profile.jsp"
            ).forward(request, response);

            return;
        }


        // =========================================
        // PINCODE VALIDATION
        // =========================================

        if (!pincode.matches("\\d{6}")) {

            request.setAttribute(
                    "error",
                    "Please enter a valid 6-digit pincode."
            );

            setFormAttributes(
                    request,
                    fullName,
                    phone,
                    pincode,
                    addressLine,
                    city,
                    state
            );

            request.getRequestDispatcher(
                    "/edit-profile.jsp"
            ).forward(request, response);

            return;
        }


        // =========================================
        // UPDATE SESSION
        // =========================================

        HttpSession session =
                request.getSession();

        session.setAttribute(
                "shippingFullName",
                fullName.trim()
        );

        session.setAttribute(
                "shippingPhone",
                phone.trim()
        );

        session.setAttribute(
                "shippingPincode",
                pincode.trim()
        );

        session.setAttribute(
                "shippingAddressLine",
                addressLine.trim()
        );

        session.setAttribute(
                "shippingCity",
                city.trim()
        );

        session.setAttribute(
                "shippingState",
                state.trim()
        );


        // =========================================
        // BACK TO PROFILE
        // =========================================

        response.sendRedirect(
                request.getContextPath()
                        + "/profile"
        );
    }


    // =========================================
    // FORM ATTRIBUTES
    // =========================================

    private void setFormAttributes(
            HttpServletRequest request,
            String fullName,
            String phone,
            String pincode,
            String addressLine,
            String city,
            String state
    ) {

        request.setAttribute(
                "fullName",
                fullName
        );

        request.setAttribute(
                "phone",
                phone
        );

        request.setAttribute(
                "pincode",
                pincode
        );

        request.setAttribute(
                "addressLine",
                addressLine
        );

        request.setAttribute(
                "city",
                city
        );

        request.setAttribute(
                "state",
                state
        );
    }
}