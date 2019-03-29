Sepidiv Argon
======
used for hierarchical data storing <\br>
=== Usage ===
------
* `-a | --add [class,sub,item]`
··· add a class, sub or item
* `-r | --remove [class,sub,item]`
··· remove a class, sub or item
* `-p | --place "PATH"`
··· path to an item or sub. path be like CLASS=>SUBCLASS=>ITEM or CLASS=>SUBCLASS=>SUBSUBCLASS
* `-w | --find-place [item]`
··· find path to an item
* `-f | --file-name`
··· declare file name
* `-h | --help`
··· show a simple help
=== ISSUES ===
------
* name of two 'things' can not be a substr
* code is spagetti -- which ain't a bug
* sometimes, findPlace produces garbage
* place can not be declared without quotation marks
=== CONTRIBUTE ===
------
:/
pull requests are welcome.
=== INSTALLATION ===
------
All dependencies are included in coreutils and binutils --- i suppose ---