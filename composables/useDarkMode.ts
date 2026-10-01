import { ref } from "vue";

// Shared singleton so every page has the same theme state.
const isDarkMode = ref(true);

export const useDarkMode = () => {
  const applyTheme = () => {
    if (import.meta.client) {
      document.documentElement.setAttribute(
        "data-theme",
        isDarkMode.value ? "dark" : "light"
      );
      document.documentElement.setAttribute(
        "data-bs-theme",
        isDarkMode.value ? "dark" : "light"
      );
    }
  };

  const toggleTheme = () => {
    isDarkMode.value = !isDarkMode.value;
    if (import.meta.client) {
      localStorage.setItem("darkMode", String(isDarkMode.value));
      applyTheme();
    }
  };

  const initTheme = () => {
    if (import.meta.client) {
      const saved = localStorage.getItem("darkMode");
      if (saved !== null) {
        isDarkMode.value = saved === "true";
      }
      applyTheme();
    }
  };

  return { isDarkMode, toggleTheme, initTheme };
};
