/**
* Returns the movement speed data as read-only json string.
* @returns {struct}
*/
function GMMGet() {
	return json_stringify(static_get(__GMMConfig), true);
}