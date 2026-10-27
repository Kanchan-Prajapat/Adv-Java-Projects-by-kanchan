
function toggleMobileMenu() {
    const menu = document.getElementById("mobileMenu");

    if (menu && menu.classList.contains("open")) {
        closeMobileMenu();
    } else {
        openMobileMenu();
    }
}

function openMobileMenu() {
    const menu = document.getElementById("mobileMenu");
    const overlay = document.getElementById("mobileMenuOverlay");

    if (!menu || !overlay) return;

    menu.classList.add("open");
    overlay.classList.add("open");
    menu.setAttribute("aria-hidden", "false");

    document.body.classList.add("mobile-menu-open");
}

function closeMobileMenu() {
    const menu = document.getElementById("mobileMenu");
    const overlay = document.getElementById("mobileMenuOverlay");

    if (!menu || !overlay) return;

    menu.classList.remove("open");
    overlay.classList.remove("open");
    menu.setAttribute("aria-hidden", "true");

    document.body.classList.remove("mobile-menu-open");
}

document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
        closeMobileMenu();
    }
});
