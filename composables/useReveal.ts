import { onMounted } from "vue";

export const useReveal = () => {
  onMounted(() => {
    if (!import.meta.client || !("IntersectionObserver" in window)) return;

    document.documentElement.classList.add("reveal-init");

    const observer = new IntersectionObserver(
      (entries) => {
        for (const entry of entries) {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-visible");
            observer.unobserve(entry.target);
          }
        }
      },
      { threshold: 0.12 }
    );

    document
      .querySelectorAll("[data-reveal]")
      .forEach((element) => observer.observe(element));
  });
};
