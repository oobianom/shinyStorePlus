/* shinyStorePlus v1.4 | (c) Written by Obi Obianom, www.obianom.com | all rights reserved */

// Create Dexie database
const db = new Dexie('shinystoreplusmiscdara');
const observeonce = 'observeonce'
// Define database schema - add inputname as an indexed field
db.version(1).stores({
    inputData: '++id, inputname, value, timestamp'
});

// Function to clean up old entries (older than 30 days)
async function cleanupOldEntries() {
    try {
        const thirtyDaysAgo = new Date();
        thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

        await db.inputData
            .where('timestamp')
            .below(thirtyDaysAgo)
            .delete();

    } catch (error) {
        console.error("Error cleaning up old entries:", error);
    }
}

// Using document ready // or shiny:connected
document.addEventListener('DOMContentLoaded', async function() {


    Shiny.addCustomMessageHandler("stpobserveEventsOnce", function(e) {
        if (e == "restart") clearIndexedDB(observeonce)
        if (e == "start") {

            try {

                // First clean up old entries
                await cleanupOldEntries();


                // Get the most recent entry for observeonce
                const storedData = await db.inputData
                    .where('inputname')
                    .equals(observeonce)
                    .last();



                if (storedData) {
                    Shiny.setInputValue("shinystoreplusalreadyExecuted", true)
                } else {
                    saveToIndexedDB(observeonce)
                }
            } catch (error) {
                console.error("Error loading data:", error);
            }

        }
    });
});

// Function to save input value to IndexedDB
async function saveToIndexedDB(inputName) {
    try {


        // Store with inputname
        await db.inputData.add({
            inputname: inputName,
            value: true,
            timestamp: new Date()
        });
    } catch (error) {
        console.error("Error saving data:", error);
    }
}

// Function to clear IndexedDB
async function clearIndexedDB(inputName) {
    try {
        // Delete all entries for this input name
        await db.inputData
            .where('inputname')
            .equals(inputName)
            .delete();

        console.log("Cleared data from database");
    } catch (error) {
        console.error("Error clearing data:", error);
    }
}
