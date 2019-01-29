/**
 * emphParse parses text with emphasis tokens (i.e. text between double square
 * brackets) into an HTML string.
 *
 * @param text {string}
 * @returns {string}
 */
export default function emphParse(text) {
  let openIndex = text.indexOf("[[");

  while (openIndex !== -1) {
    const endIndex = text.indexOf("]");
    if (endIndex === -1) return text;

    let closeIndex = endIndex + 2;
    let type = "";
    if (text[endIndex + 1] == "(") {
      let typeStartIndex = endIndex + 2;
      let typeEndIndex = text.indexOf(")", typeStartIndex + 1);
      type = text.substr(typeStartIndex, typeEndIndex - typeStartIndex);
      closeIndex = typeEndIndex + 2;
    }

    const before = text.substr(0, openIndex);
    const after = text.substr(closeIndex);

    const firstCharIndex = openIndex + 2;
    const between = text
      .substr(firstCharIndex, endIndex - firstCharIndex)
      .trim();

    if (type) type = ` ${type}`;
    text = `${before}<span class="emphasis${type}">${between}</span>${after}`;
    openIndex = text.indexOf("[[");
  }

  return `<p>${text}</p>`;
}
