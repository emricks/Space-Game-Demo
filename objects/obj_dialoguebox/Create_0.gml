// Store the array of IDs and current progress
dialogue_ids = [];
current_index = 0;
is_active = false;
cooldown = 0;

dialogues = {
    "0": "heya.",
    "1": "i'm sans.\nsans the skeleton.",
    "2": "these here entrances let\nyou go to planets."
};

// Function to start a new sequence
start_sequence = function(_ids) {
    dialogue_ids = _ids;
    current_index = 0;
    is_active = true;
};