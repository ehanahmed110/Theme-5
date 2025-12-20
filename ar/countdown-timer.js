// Countdown Timer for Cyber Monday
(function() {
  'use strict';
  
  // Set cyber Monday end date (7 days from now for demo)
  const cyberMondayEnd = new Date();
  cyberMondayEnd.setDate(cyberMondayEnd.getDate() + 7);
  cyberMondayEnd.setHours(23, 59, 59, 999);

  function updateAllCountdowns() {
    const now = new Date().getTime();
    const distance = cyberMondayEnd - now;

    if (distance > 0) {
      const days = Math.floor(distance / (1000 * 60 * 60 * 24));
      const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((distance % (1000 * 60)) / 1000);

      // Update all product card countdown timers
      document.querySelectorAll('.product-card-countdown').forEach((countdown) => {
        const numbers = countdown.querySelectorAll('.countdown-number');
        if (numbers.length >= 4) {
          numbers[0].textContent = String(days).padStart(2, '0');
          numbers[1].textContent = String(hours).padStart(2, '0');
          numbers[2].textContent = String(minutes).padStart(2, '0');
          numbers[3].textContent = String(seconds).padStart(2, '0');
        }
      });
    }
  }

  // Update every second
  setInterval(updateAllCountdowns, 1000);
  
  // Initial update
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', updateAllCountdowns);
  } else {
    updateAllCountdowns();
  }
})();
