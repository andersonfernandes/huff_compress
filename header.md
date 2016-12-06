## Header Definition

- First two bytes 
  
  - 3  bits: trash size on the last byte
  - 3  bits: extension size(n)
  - 10 bits: tree size(i)

- Next n bytes: the extension characters

- Next i bytes: the tree bytes

- Last bytes: the compressed file bytes
