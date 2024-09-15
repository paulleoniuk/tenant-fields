# Custom Fields Management System
## Overview
This Rails application allows users to manage custom fields with different types, including text, number, single select, and multiple select.

## Key Points
JSON Column for Value: The value column in CustomFieldValue uses JSON format to handle various field types flexibly

## TODO
### Validation Enhancements:
* Add future validation to ensure options for select fields are mandatory.

### Refactoring:

* Move CustomFieldValue validations to a separate service as model is huge
* Make CustomField independent from Tenant to allow broader usage.


### Routes
PATCH /users/:id/update_value

Parameters:
* custom_field_id: ID of the custom field.
* value: New value for the custom field.
* id: User ID to update.
* Request Example:


``` curl -v -X PATCH "http://localhost:3000/users/1/update_value" -H "Content-Type: application/json" -d '{"custom_field_id": 1, "value": "New Value"}' ```
