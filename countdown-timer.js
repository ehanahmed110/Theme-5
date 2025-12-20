// Countdown Timer for Cyber Monday Product Cards
function initProductCountdowns() {
  // Set Cyber Monday end date (7 days from now for demo)
  const cyberMondayEnd = new Date();
  cyberMondayEnd.setDate(cyberMondayEnd.getDate() + 7);

  function updateCountdowns() {
    const now = new Date().getTime();
    const distance = cyberMondayEnd - now;

    // Calculate time units
    const days = Math.floor(distance / (1000 * 60 * 60 * 24));
    const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((distance % (1000 * 60)) / 1000);

    // Find all countdown elements
    const countdownElements = document.querySelectorAll('.product-card-countdown');
    
    countdownElements.forEach(countdown => {
      const dayEl = countdown.querySelector('.countdown-box:nth-child(1) .countdown-number');
      const hourEl = countdown.querySelector('.countdown-box:nth-child(3) .countdown-number');
      const minEl = countdown.querySelector('.countdown-box:nth-child(5) .countdown-number');
      const secEl = countdown.querySelector('.countdown-box:nth-child(7) .countdown-number');

      if (dayEl) dayEl.textContent = String(days).padStart(2, '0');
      if (hourEl) hourEl.textContent = String(hours).padStart(2, '0');
      if (minEl) minEl.textContent = String(minutes).padStart(2, '0');
      if (secEl) secEl.textContent = String(seconds).padStart(2, '0');
    });

    // If countdown is finished
    if (distance < 0) {
      clearInterval(countdownInterval);
      countdownElements.forEach(countdown => {
        countdown.innerHTML = '<span style="font-size: 12px;">EXPIRED</span>';
      });
    }
  }

  // Update immediately
  updateCountdowns();

  // Update every second
  const countdownInterval = setInterval(updateCountdowns, 1000);
}

// Initialize when DOM is loaded
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initProductCountdowns);
} else {
  initProductCountdowns();
}
