# resume

_My resume, written in Vue._

[![Travis CI][travis-img]][travis]

> GitHub Pages: https://stevenxie.github.io/resume/
>
> Resume data: https://stevenxie.github.io/resume/data.json

## Motivation

I initially built my resume using Sketch, a tool for vector illustrations and
UI design. This method produced really nice-looking results, but it was
difficult to maintain because of inconsistencies with the spacing of elements.

Because of this, I decided to rebuild by resume using a web framework (VueJS)
and modular components in order to maintain consistency in style and spacing,
and for ease of modifications; all the data for the resume can now be
represented as a single JSON object, and since the webapp only specifies the
layout of the resume, updating the JSON object will update the contents of
the resume.

## TODOs

- [x] Finish initial version.
- [ ] Integrate with dynamic data from the https://stevenxie.me API, for truly
      automated updates.

## Project setup

```bash
yarn install   # installs dependencies
yarn run serve # compiles and hot-reloads for development
yarn run build # compiles and minifies for production
yarn run lint  # lints and fixes files
```

[travis]: https://travis-ci.com/stevenxie/resume
[travis-img]: https://travis-ci.com/stevenxie/resume.svg?branch=master
