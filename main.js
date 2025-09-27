const sqlQueryField = $(".main-container__input-field");
const runButton = $(".main-container__run-button");
const sqlForm = $(".main-container");
const queryResultsRadioButton = $(".query-container__results-radio-button");
const queryLogsRadioButton = $(".query-container__logs-radio-button");

const rawQueryUrl = "http://localhost:3000/rawquery";
const storedProcedureUrl = "http://localhost:3000/storedprocedure";

// Submit action
sqlForm.on("submit", async (e) => {
  e.preventDefault(); // prevent form submission
  const textarea = $(".main-container__text-area");
  if (textarea.value.length == 0) throw new Error("No text inputted");
  const userText = textarea.value;

  // Headers
  const headers = new Headers();  
  headers.append("Content-Type", "application/json");
  headers.append("Accept", "application/json");
  // Run function and wait for results
  const result = await getQueryResults(userText, headers);
  console.log(result);

  if (result) {
    queryResultsRadioButton.show();
    queryLogsRadioButton.show();
    textarea.value = ''; // Clear text on successful query
    displayQueryResults(result);
    
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
queryResultsRadioButton.on("click", () => {
  console.log("Results selected");
  // Display query results
});

queryLogsRadioButton.on("click", () => {
  console.log("Logs selected");
  // Display logs
});

// Create table and populate rows
function displayQueryResults(queryResult) {
  // Should probably limit to first 100 results and allow user to show more
  const records = queryResult.recordsets; // Array of records
  const container = $(".query-container__results-rows");
  
}


function createLogEntry(query) {
  // Clean up query text - clear any newlines or replace with line breaks
  console.log(query);
  
}