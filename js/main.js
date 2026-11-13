/*
 * yasinustun.ustunsoft.com — küçük iyileştirmeler
 * İçerik JS olmadan da tam okunur. Bu dosya yalnızca:
 *   1) tema değiştirici (sistem tercihi + localStorage)
 *   2) mobil menü
 *   3) footer yılı
 * Not: İlk boyamada tema titremesini önlemek için <head> içinde küçük bir
 * satır içi betik data-theme özniteliğini zaten ayarlar.
 */
(function () {
  "use strict";

  var root = document.documentElement;
  var STORAGE_KEY = "theme";
  var THEME_COLORS = { light: "#ffffff", dark: "#13202d" };
  var darkQuery = window.matchMedia ? window.matchMedia("(prefers-color-scheme: dark)") : null;

  function readStoredTheme() {
    try {
      var value = window.localStorage.getItem(STORAGE_KEY);
      return value === "light" || value === "dark" ? value : null;
    } catch (e) {
      return null;
    }
  }

  function storeTheme(value) {
    try {
      window.localStorage.setItem(STORAGE_KEY, value);
    } catch (e) {
      /* Gizli mod vb.: seçim yalnızca bu sayfa açıkken geçerli olur. */
    }
  }

  function currentTheme() {
    var attr = root.getAttribute("data-theme");
    if (attr === "light" || attr === "dark") return attr;
    return darkQuery && darkQuery.matches ? "dark" : "light";
  }

  /* 1) Tema --------------------------------------------------------------- */
  var themeToggle = document.querySelector(".theme-toggle");

  function syncTheme() {
    var theme = currentTheme();
    var metas = document.querySelectorAll('meta[name="theme-color"]');
    for (var i = 0; i < metas.length; i++) metas[i].setAttribute("content", THEME_COLORS[theme]);

    if (themeToggle) {
      var label = theme === "dark" ? themeToggle.getAttribute("data-label-light") : themeToggle.getAttribute("data-label-dark");
      themeToggle.setAttribute("aria-label", label);
      themeToggle.setAttribute("title", label);
    }
  }

  if (themeToggle) {
    themeToggle.addEventListener("click", function () {
      var next = currentTheme() === "dark" ? "light" : "dark";
      root.setAttribute("data-theme", next);
      storeTheme(next);
      syncTheme();
    });
  }

  if (darkQuery) {
    var onSystemChange = function () {
      if (!readStoredTheme()) {
        root.removeAttribute("data-theme");
        syncTheme();
      }
    };
    if (darkQuery.addEventListener) darkQuery.addEventListener("change", onSystemChange);
    else if (darkQuery.addListener) darkQuery.addListener(onSystemChange);
  }

  syncTheme();

  /* 2) Mobil menü --------------------------------------------------------- */
  var menuToggle = document.querySelector(".menu-toggle");
  var nav = document.getElementById("site-nav");

  if (menuToggle && nav) {
    var setMenu = function (open) {
      nav.classList.toggle("is-open", open);
      menuToggle.setAttribute("aria-expanded", open ? "true" : "false");
      menuToggle.setAttribute(
        "aria-label",
        open ? menuToggle.getAttribute("data-label-close") : menuToggle.getAttribute("data-label-open")
      );
    };

    menuToggle.addEventListener("click", function () {
      setMenu(menuToggle.getAttribute("aria-expanded") !== "true");
    });

    nav.addEventListener("click", function (event) {
      if (event.target.closest && event.target.closest("a")) setMenu(false);
    });

    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape" && menuToggle.getAttribute("aria-expanded") === "true") {
        setMenu(false);
        menuToggle.focus();
      }
    });

    document.addEventListener("click", function (event) {
      if (
        menuToggle.getAttribute("aria-expanded") === "true" &&
        !nav.contains(event.target) &&
        !menuToggle.contains(event.target)
      ) {
        setMenu(false);
      }
    });

    if (window.matchMedia) {
      var desktopQuery = window.matchMedia("(min-width: 54em)");
      var onDesktop = function () {
        if (desktopQuery.matches) setMenu(false);
      };
      if (desktopQuery.addEventListener) desktopQuery.addEventListener("change", onDesktop);
      else if (desktopQuery.addListener) desktopQuery.addListener(onDesktop);
    }
  }

  /* 3) Yıl ---------------------------------------------------------------- */
  var year = String(new Date().getFullYear());
  var yearNodes = document.querySelectorAll("[data-year]");
  for (var j = 0; j < yearNodes.length; j++) yearNodes[j].textContent = year;
})();
