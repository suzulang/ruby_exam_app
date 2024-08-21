document.addEventListener('turbo:load', function() {
  const questions = document.querySelectorAll('.question');
  const progressBar = document.querySelector('.progress-bar');
  const progressText = document.querySelector('.progress-text');
  let answeredCount = 0;

  questions.forEach(question => {
    const options = question.querySelectorAll('input[type="radio"]');
    options.forEach(option => {
      option.addEventListener('change', function() {
        if (!question.classList.contains('answered')) {
          answeredCount++;
          question.classList.add('answered');
          updateProgress();
        }
      });
    });
  });

  function updateProgress() {
    const totalQuestions = questions.length;
    const percentage = (answeredCount / totalQuestions) * 100;
    progressBar.style.width = percentage + '%';
    progressText.textContent = `${answeredCount} / ${totalQuestions} 完成`;
  }

  updateProgress();

});