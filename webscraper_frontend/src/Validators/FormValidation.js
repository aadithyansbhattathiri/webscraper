export default function validate(values) {
    let errors = {};
    if (!values.url) {
      errors.url = "*(URL is required)";
    }
    if (!values.provider) {
        errors.provider = "*(Provider is required)";
      }

    return errors;
  }
  
  