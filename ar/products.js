// ==================== PRODUCT PAGE JAVASCRIPT ====================
// This file handles all product page functionality: filters, countdown timers, color selection

document.addEventListener("DOMContentLoaded", function () {
  // ==================== SIDEBAR FUNCTIONALITY ====================
  const navToggle = document.getElementById("navToggle");
  const sidebar = document.getElementById("navSidebar");
  const sidebarClose = document.getElementById("sidebarClose");
  const sidebarOverlay = document.getElementById("sidebarOverlay");

  if (navToggle) {
    navToggle.addEventListener("click", function () {
      sidebar.classList.add("active");
      sidebarOverlay.classList.add("active");
      document.body.style.overflow = "hidden";
    });
  }

  function closeSidebar() {
    sidebar.classList.remove("active");
    sidebarOverlay.classList.remove("active");
    document.body.style.overflow = "";
  }

  if (sidebarClose) {
    sidebarClose.addEventListener("click", closeSidebar);
  }

  if (sidebarOverlay) {
    sidebarOverlay.addEventListener("click", closeSidebar);
  }

  // Sidebar dropdown functionality
  document.querySelectorAll(".sidebar-dropdown-toggle").forEach((toggle) => {
    toggle.addEventListener("click", function (e) {
      e.preventDefault();
      const parent = this.parentElement;
      const isActive = parent.classList.contains("active");

      document.querySelectorAll(".sidebar-dropdown").forEach((item) => {
        item.classList.remove("active");
      });

      if (!isActive) {
        parent.classList.add("active");
      }
    });
  });

  // Main nav dropdown
  document.querySelectorAll(".dropdown-toggle-custom").forEach((item) => {
    item.addEventListener("click", function (e) {
      e.preventDefault();
      let menu = this.nextElementSibling;
      menu.classList.toggle("show-dropdown");
    });
  });

  // ==================== COUNTDOWN TIMER ====================
  const cyberMondayEnd = new Date();
  cyberMondayEnd.setDate(cyberMondayEnd.getDate() + 7);
  cyberMondayEnd.setHours(23, 59, 59, 999);

  function updateCountdowns() {
    const now = new Date().getTime();
    const distance = cyberMondayEnd - now;

    if (distance > 0) {
      const days = Math.floor(distance / (1000 * 60 * 60 * 24));
      const hours = Math.floor(
        (distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
      );
      const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((distance % (1000 * 60)) / 1000);

      // Update all product card countdown timers
      document.querySelectorAll(".product-card-countdown").forEach((timer) => {
        const numbers = timer.querySelectorAll(".countdown-number");
        if (numbers.length === 4) {
          numbers[0].textContent = String(days).padStart(2, "0");
          numbers[1].textContent = String(hours).padStart(2, "0");
          numbers[2].textContent = String(minutes).padStart(2, "0");
          numbers[3].textContent = String(seconds).padStart(2, "0");
        }
      });
    }
  }

  setInterval(updateCountdowns, 1000);
  updateCountdowns();

  // ==================== COLOR FILTER FUNCTIONALITY ====================
  const colorFilters = document.querySelectorAll(".color-option");
  const allProducts = document.querySelectorAll(".product-grid-card");

  colorFilters.forEach((filter) => {
    filter.addEventListener("click", function () {
      // Toggle active state
      this.classList.toggle("active");

      // Get all active colors
      const activeColors = Array.from(
        document.querySelectorAll(".color-option.active")
      ).map((el) => el.title.toLowerCase());

      // Filter products
      filterProducts();
    });
  });

  // ==================== STORAGE FILTER FUNCTIONALITY ====================
  const storageFilters = document.querySelectorAll(".storage-checkbox");

  storageFilters.forEach((filter) => {
    filter.addEventListener("change", function () {
      filterProducts();
    });
  });

  // ==================== FILTER PRODUCTS ====================
  function filterProducts() {
    // Get active color filters
    const activeColors = Array.from(
      document.querySelectorAll(".color-option.active")
    ).map((el) => el.title.toLowerCase());

    // Get active storage filters  
    const activeStorages = Array.from(
      document.querySelectorAll(".storage-checkbox:checked")
    ).map((el) => el.id.replace("storage-", ""));

    let visibleCount = 0;

    allProducts.forEach((product) => {
      const productColors = (product.dataset.colors || "").split(",");
      const productStorage = product.dataset.storage;

      // Check color match (if any color filter is active)
      const colorMatch =
        activeColors.length === 0 ||
        productColors.some((color) =>
          activeColors.some((active) => color.toLowerCase().includes(active))
        );

      // Check storage match (if any storage filter is active)
      const storageMatch =
        activeStorages.length === 0 ||
        activeStorages.includes(productStorage);

      // Show/hide product
      if (colorMatch && storageMatch) {
        product.style.display = "block";
        visibleCount++;
      } else {
        product.style.display = "none";
      }
    });

    // Update product count
    const productCount = document.getElementById("productCount");
    if (productCount) {
      productCount.textContent = visibleCount;
    }
  }

  // ==================== PRODUCT COLOR DOTS ====================
  document.querySelectorAll(".product-color-dot").forEach((dot) => {
    dot.addEventListener("click", function () {
      const card = this.closest(".product-grid-card");
      if (!card) return;

      // Remove active from siblings
      card
        .querySelectorAll(".product-color-dot")
        .forEach((d) => d.classList.remove("active"));
      this.classList.add("active");

      // Update image
      const imgUrl = this.getAttribute("data-image");
      if (imgUrl) {
        const mainImg = card.querySelector(".product-main-image");
        if (mainImg) {
          mainImg.style.opacity = "0.5";
          setTimeout(() => {
            mainImg.src = imgUrl;
            mainImg.style.opacity = "1";
          }, 200);
        }
      }
    });
  });
});
