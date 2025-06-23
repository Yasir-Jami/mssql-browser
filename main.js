const sqlQueryField = document.querySelector(".main-container__input-field");
const runButton = document.querySelector(".main-container__run-button");
const sqlForm = document.querySelector(".main-container");

// Submit action
sqlForm.addEventListener("submit", (e) => {
  e.preventDefault(); // prevent form submission and refresh
  const textarea = document.querySelector(".main-container__text-area");
  if (textarea.value.length == 0) return;
  const userText = textarea.value;

  const headers = new Headers();  
  headers.append("Content-Type", "application/json");
  headers.append("Accept", "application/json");

  const result = getQueryResults(userText, headers);

  if (result) {
    //textarea.value = ''; // Clear text on success
  }
});

async function getQueryResults(userText, headers) {
    const url = "http://localhost:3000/query";
    try {
      const response = await fetch(url, {
        method: "POST", 
        headers,
        body: JSON.stringify(userText),
      });

      console.log(response);
      if (!response.ok) {
        console.error("Error:", response.status);
        throw new Error(`Response Status: ${response.status}`);
      }
      const json = await response.json();
      console.log(json);
      textarea.value = ''; // Clear text on successful return
    }
    catch (error) {
      console.error(error.message);
    } 
  }