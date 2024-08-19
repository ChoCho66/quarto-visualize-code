# Visualize-Code Extension For Quarto

This extension allows you to quickly visualize executable code blocks using [https://pythontutor.com](https://pythontutor.com). It's particularly useful for teaching.

## Installing

```bash
quarto add ChoCho66/quarto-visualize-code
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you should check in this directory.

## Using

This extension will visualize code blocks like the following using [pythontutor.com](pythontutor.com):

````
```{visualize-python}
for i in range(3):
    print(i)
```
````

The programming languages supported are `Python`, `C`, `C++`, `Javascript`, and `Java`.

You can set the width and height for all code blocks in the meta data. For example:

````
---
title: "Visualize-code Example"
format: 
  revealjs: default
filters:
  - visualize-code
visualize_code:
  - width: 70%
  - height: 500
---
````

You can also set the width and height for individual code blocks. For example:

````
```{visualize-python, width=50%, height=400}
for i in range(3):
    print(i)
```
````

Here is the source code for a minimal example: [example.qmd](example.qmd).

<!-- The rendered document can be viewed online. -->
