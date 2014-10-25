unite-doxygen
=============

unite source of doxygen

## Depends

### external commandS

- xsltproc: included int [libxslt](http://xmlsoft.org/libxslt/)

### vim plugins

- [unite.vim](https://github.com/Shougo/unite.vim) 
- [vimproc](https://github.com/Shougo/vimproc.vim)

Usage
-----

0. Prepare your project documented with [Doxygen](http://www.doxygen.org)

0. Install [libxslt](http://xmlsoft.org/libxslt/)

1. Create `searchdata.xml` using doxygen:
   Enable (set to 'YES') following options in your `Doxyfile`

    - SEARCHENGINE
    - SERVER_BASED_SEARCH
    - EXTERNAL_SEARCH

   See also the document: [External Indexing and Searching](http://www.stack.nl/~dimitri/doxygen/manual/extsearch.html).
   Then you will find your `searchdata.xml` in OUTPUT_DIRECTORY (set in your `Doxyfile`).

2. Write the full path of OUTPUT_DIRECTORY in your `.vimrc`

  ```vim
  let g:unite_doxygen_home = "/full/path/of/OUTPUT_DIRECTORY"
  ```

3. Call `:Unite doxygen` in vim
