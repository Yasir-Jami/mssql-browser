const sqlQueryField = document.querySelector(".main-container__input-field");
const runButton = document.querySelector(".main-container__run-button");
const sqlForm = document.querySelector(".main-container");
const queryResultsRadioButton = document.querySelector(".query-container__logs-radio-button");
const queryLogsRadioButton = document.querySelector(".query-container__results-radio-button");

const rawQueryUrl = "http://localhost:3000/rawquery";
const storedProcedureUrl = "http://localhost:3000/storedprocedure";

// Submit action
sqlForm.addEventListener("submit", async (e) => {
  e.preventDefault(); // prevent form submission
  const textarea = document.querySelector(".main-container__text-area");
  if (textarea.value.length == 0) throw new Error("No text inputted");
  const userText = textarea.value;

  const headers = new Headers();  
  headers.append("Content-Type", "application/json");
  headers.append("Accept", "application/json");
  const result = await getQueryResults(userText, headers);

  if (result) {
    //queryResultsRadioButton.setAttribute('display') = true;
    textarea.value = ''; // Clear text on successful query
    
    //createLogEntry(userText);
    //displayQueryResults(result);
  }
});

/**
 * Queries database and returns as 
 * @param {string} userQuery Text inputted by user
 * @param {object} headers Fetch API Headers
 */
async function getQueryResults(userQuery, headers) {
    const url = rawQueryUrl;
    try {
      const response = await fetch(url, {
        method: "POST", 
        headers,
        body: JSON.stringify({text: userQuery}),
      });

      if (!response.ok) {
        console.error("Response not OK:", response.status);
        throw new Error(`Response Status: ${response.status}`);
      }

      const result = await response.json();
      return result;
    }
    catch (error) {
      console.error(error.message);
      return error;
    } 
}

// Query Container Methods
queryResultsRadioButton.addEventListener("click", () => {
  console.log("Results selected");
  // Display populated rows
});

queryLogsRadioButton.addEventListener("click", () => {
  console.log("Logs selected");
  // Display logs
});

function displayQueryResults(queryResult) {

}


function createLogEntry(query) {
  // Clean up query - clear any newlines or replace with line breaks
  console.log(query);
  
}