/**
 * emphParse parses text with emphasis tokens (i.e. text between double square
 * brackets) into an HTML string.
 *
 * @param text {string}
 * @returns {string}
 */
function emphParse(text) {
  let searchPos = 0;
  let openIndex = text.indexOf("[[", searchPos);

  while (openIndex !== -1) {
    const closeIndex = text.indexOf("]]");
    if (closeIndex === -1) return text;

    const before = text.substr(0, openIndex);
    const after = text.substr(closeIndex + 2);

    const firstCharIndex = openIndex + 2;
    const between = text
      .substr(firstCharIndex, closeIndex - firstCharIndex)
      .trim();

    text = `<p>${before}<span class="emphasis">${between}</span>${after}</p>`;
    openIndex = text.indexOf("[[", searchPos);
  }

  return text;
}

export default emphParse;
