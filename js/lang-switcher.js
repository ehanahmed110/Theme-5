(function () {
  function currentFile() {
    // returns filename like 'index.html' or 'about.html'
    const p = location.pathname;
    const parts = p.split("/").filter(Boolean);
    if (parts.length === 0) return "index.html";
    const last = parts[parts.length - 1];
    // if current path is '/ar' or '/ar/' treat as index
    if (last === "ar") return "index.html";
    return last;
  }

  function buildPathFor(lang, file) {
    file = file || "index.html";
    // Determine if current URL path contains an "ar" folder segment
    var pathParts = location.pathname.split("/").filter(Boolean);
    var inAr = pathParts.indexOf("ar") !== -1;

    if (lang === "ar") {
      // if already in /ar/, link to the same filename in current folder
      return inAr ? file : "ar/" + file;
    }

    // lang === 'en'
    // if currently in /ar/ folder, link to parent (../file), else link to file in current folder
    return inAr ? "../" + file : file;
  }

  document.addEventListener("DOMContentLoaded", function () {
    const file = currentFile();
    const enBtns = document.querySelectorAll('[data-set-lang="en"]');
    const arBtns = document.querySelectorAll('[data-set-lang="ar"]');

    enBtns.forEach(function (btn) {
      try {
        btn.href = buildPathFor("en", file);
      } catch (e) {}
      // also ensure clicking works when href resolution is tricky (file://)
      btn.addEventListener("click", function (ev) {
        ev.preventDefault();
        window.location.href = buildPathFor("en", file);
      });
    });

    arBtns.forEach(function (btn) {
      try {
        btn.href = buildPathFor("ar", file);
      } catch (e) {}
      btn.addEventListener("click", function (ev) {
        ev.preventDefault();
        window.location.href = buildPathFor("ar", file);
      });
    });

    // optional: auto-detect and redirect based on browser language on first visit
    if (!localStorage.getItem("site-lang-detected")) {
      const userLang = (
        navigator.language ||
        navigator.userLanguage ||
        "en"
      ).toLowerCase();
      if (userLang.startsWith("ar")) {
        // if on english page and there's an ar equivalent, redirect — COMMENT OUT if you don't want auto-redirect
        // const arPath = buildPathFor('ar', file);
        // if(location.pathname !== arPath) location.replace(arPath);
      }
      localStorage.setItem("site-lang-detected", "1");
    }
  });

  // expose a global helper so existing inline onclick handlers work
  window.setLanguage = function (lang) {
    try {
      var file = currentFile();
      var target = buildPathFor(lang, file);
      window.location.href = target;
    } catch (e) {
      console.error("setLanguage error", e);
    }
  };
})();
