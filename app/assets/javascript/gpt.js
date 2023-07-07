async function getSuggestionsFromGPT() {
  const systemMessage = 'Answer with only one json array, example: [ "First", "Second", ...], without any comments.';
  const userMessage = `Suggest ${$('#suggested-amount').val()} chapter names, without number, for a book titled "<%= @book.title %>"`;

  const response = await fetch('/gpt', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
    },
    body: JSON.stringify({
      system_message: systemMessage,
      user_message: userMessage,
    }),
  });

  if (response.ok) {
    const data = await response.json();
    if (data.message == null) {
      return ["Failed to fetch suggestions"];
    }
    return JSON.parse(data.message);
  } else {
    throw new Error('Failed to fetch suggestions from GPT.');
  }
}