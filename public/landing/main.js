// Scroll animation using Intersection Observer API
const observerOptions = {
  threshold: 0.1,
  rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.style.opacity = '1';
      entry.target.style.transform = 'translateY(0)';
    }
  });
}, observerOptions);

// Observe all feature cards for animation
document.querySelectorAll('.feature-card').forEach(card => {
  card.style.opacity = '0';
  card.style.transform = 'translateY(20px)';
  card.style.transition = 'all 0.6s ease-out';
  observer.observe(card);
});

// Form submission handler
function handleFormSubmit(event) {
  event.preventDefault();

  const form = event.target;
  const email = form.querySelector('input[type="email"]').value;
  const messageEl = document.getElementById('formMessage');

  // Simple email validation
  if (!isValidEmail(email)) {
    messageEl.textContent = 'Email không hợp lệ';
    messageEl.className = 'form-message error';
    return;
  }

  // Simulate form submission (replace with actual API call)
  messageEl.textContent = 'Đang xử lý...';
  messageEl.className = 'form-message';

  setTimeout(() => {
    messageEl.textContent = '✓ Cảm ơn! Chúng tôi sẽ liên hệ sớm.';
    messageEl.className = 'form-message success';
    form.reset();

    // Clear message after 3 seconds
    setTimeout(() => {
      messageEl.textContent = '';
      messageEl.className = 'form-message';
    }, 3000);
  }, 500);
}

// Email validation helper
function isValidEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

// Smooth scroll for anchor links (fallback for browsers without scroll-behavior)
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function(e) {
    const href = this.getAttribute('href');
    if (href !== '#') {
      e.preventDefault();
      const target = document.querySelector(href);
      if (target) {
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    }
  });
});

// Optional: Add scroll event listener for header shadow on scroll
let lastScrollTop = 0;
const header = document.querySelector('.header');

window.addEventListener('scroll', () => {
  const scrollTop = window.scrollY;

  if (scrollTop > 0) {
    header.style.boxShadow = '0 4px 12px rgba(0, 0, 0, 0.15)';
  } else {
    header.style.boxShadow = '0 1px 3px rgba(0, 0, 0, 0.1)';
  }

  lastScrollTop = scrollTop;
});
