
var gulp = require("gulp");
var elm = require("gulp-elm");

function multi() {
  return gulp
    .src("**/*.elm")
    .pipe(elm.make({ filetype: "html" }))
    .pipe(gulp.dest("./"));
}


function debug() {
  return gulp
    .src("**/*.elm")
    .pipe(elm.make({ filetype: "html", debug: true }))
    .pipe(gulp.dest("./"));
}

function pipe() {
  return gulp
    .src("index.elm")
    .pipe(elm())
    .pipe(gulp.dest("./"));
}


module.exports = {
  default: gulp.parallel(multi, pipe, debug),
  pipe,
  multi,
  debug
};
