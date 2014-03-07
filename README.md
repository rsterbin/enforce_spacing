enforce\_spacing
================

Vim plugin for switching between tabs and spaces, and for stripping trailing whitespace

Use these buffer-level settings:

* `enforceTabs` - Set to 'y' to make sure all four-space indenting gets
  converted to tabs
* `enforceSpaces` - Set to 'y' to make sure all tab indenting gets converted to
  four-spaces
* `enforceNoTrailingWhitespace` - This is a directory listing, keyed by file
  extensions you might encounter.  If the current extension in the list
  matches, and the value in the directory listing is `y`, trailing whitespace
  will be removed when you save the buffer.
* `ignoreTrailingWhitespace` - This is also a directory listing, keyed by file
  name.  If the file's extension matches `enforceNoTrailingWhitespace`, but you
  don't want to strip whitespace in that file, add an entry in this directory,
  set to `y`.

