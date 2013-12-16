String.format = function() {
    // The string containing the format items (e.g. "{0}")
    // will and always has to be the first argument.
	var theString = arguments[0];
	
	// start with the second argument (i = 1)
	for (var i = 1; i < arguments.length; i++) {
		// "gm" = RegEx options for Global search (more than one instance)
		// and for Multiline search
		var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
		theString = theString.replace(regEx, arguments[i]);
    }
	
	return theString;
}

function to_lines(data, line_len) {
	start = 0;
	end = line_len;
	lines = [];
	do {
		current_line = data.slice(start, end);
		lines.push(current_line)
		start += line_len;
		end += line_len;
	}
	while (data.length + line_len > end);
	return lines;
}

function lineate(data, line_len) {
	lines = to_lines(data, line_len);
	output = "";
	for (var i = 0; i < lines.length; i++) {
		output += String.format("{0}. {1} {2}\n", i, lines[i], checksum(lines[i], i));
	}
	return output;
}

function delineate(lines) {
	data = ""
	for (var i = 0; i < lines.length; i++) {
		if (temp_data = validate_checksum(lines[i]) {
			data += temp_data;
		}
	}
}

function validate_checksum(data) {
	items = data.split(" ");
	line_no = parseInt(items[0].slice(0,items[0].length-1));
	str = items[1];
	check = items[2];
	if (checksum(str, line_no) == check)
		return str;
	else
		return false;
}

function checksum(data, line_no) {
	check_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789";
	data_len = data.length;
	sum = line_no + data_len;
	for (var i = 0; i < data_len; i++) {
		char_a = data.charCodeAt(i);
		char_b = data.charCodeAt((i+1)%data_len);
		sum += char_a*char_b;
	}
	check_val = sum % check_chars.length;
	return check_chars.charAt(check_val);
}
