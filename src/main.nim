import nigui, nimcrypto, threadpool

const BufferLength = 8192

proc digest*(HashType: typedesc, window: Window, path: string): MDigest[HashType.bits] =
  mixin init, update, finish, clear
  var ctx: HashType
  ctx.init()
  let f = open(path)
  var buffer = newString(BufferLength)
  while true:
    let length = readChars(f, buffer)
    if length == 0:
      break
    buffer.setLen(length)
    ctx.update(buffer)
    if length != BufferLength:
      break
  close(f)
  result = ctx.finish()
  ctx.clear()

proc getSha1(window: Window, textBox: TextBox, path: string) =
  textBox.text = $sha1.digest(window, path)

proc getSha2_256(window: Window, textBox: TextBox, path: string) =
  textBox.text = $sha256.digest(window, path)

proc getSha2_384(window: Window, textBox: TextBox, path: string) =
  textBox.text = $sha384.digest(window, path)

proc getSha2_512(window: Window, textBox: TextBox, path: string) =
  textBox.text = $sha512.digest(window, path)

proc getSha3_256(window: Window, textBox: TextBox, path: string) =
  textBox.text = $sha3_256.digest(window, path)

proc getSha3_384(window: Window, textBox: TextBox, path: string) =
  textBox.text = $sha3_384.digest(window, path)

proc getSha3_512(window: Window, textBox: TextBox, path: string) =
  textBox.text = $sha3_512.digest(window, path)

proc getKeccak_256(window: Window, textBox: TextBox, path: string) =
  textBox.text = $keccak_256.digest(window, path)

proc getKeccak_384(window: Window, textBox: TextBox, path: string) =
  textBox.text = $keccak_384.digest(window, path)

proc getKeccak_512(window: Window, textBox: TextBox, path: string) =
  textBox.text = $keccak_512.digest(window, path)

proc getBlake2_256(window: Window, textBox: TextBox, path: string) =
  textBox.text = $blake2_256.digest(window, path)

proc getBlake2_384(window: Window, textBox: TextBox, path: string) =
  textBox.text = $blake2_384.digest(window, path)

proc getBlake2_512(window: Window, textBox: TextBox, path: string) =
  textBox.text = $blake2_512.digest(window, path)

proc getRipemd_256(window: Window, textBox: TextBox, path: string) =
  textBox.text = $ripemd256.digest(window, path)

proc getRipemd_320(window: Window, textBox: TextBox, path: string) =
  textBox.text = $ripemd320.digest(window, path)


if isMainModule:
  const buttonWidth = 72
  const labelWidth = 78
  const boxFontFamily = "Consolas"

  proc setFilePath(event: DropFilesEvent)
  proc deselectText(textBox: TextBox)

  proc selectText(textBox: TextBox) =
    deselectText(textBox)
    textBox.selectionStart = 0
    textBox.selectionEnd = 128

  app.init()

  var window = newWindow()
  window.title = "Hash Calculator"
  window.width = 1100
  window.height = 676
  window.onDropFiles = proc(event: DropFilesEvent) =
    setFilePath(event)

  var mainContainer = newLayoutContainer(Layout_Vertical)
  window.add(mainContainer)
  mainContainer.padding = 10
  mainContainer.spacing = 20

  var srcContainer = newLayoutContainer(Layout_Horizontal)
  mainContainer.add(srcContainer)

  var srcTextBox = newTextBox()
  srcContainer.add(srcTextBox)
  srcTextBox.fontFamily = boxFontFamily
  srcTextBox.onClick = proc(event: ClickEvent) =
    deselectText(srcTextBox)

  var srcButton = newButton("Open")
  srcContainer.add(srcButton)
  srcButton.minWidth = buttonWidth
  srcButton.heightMode = HeightMode_Fill
  srcButton.onClick = proc(event: ClickEvent) =
    var dialog = newOpenFileDialog()
    dialog.title = "Open File"
    dialog.multiple = false
    dialog.run()
    if dialog.files.len > 0:
      srcTextBox.text = dialog.files[0]

  var subContainer = newLayoutContainer(Layout_Vertical)
  mainContainer.add(subContainer)

  var sha1Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(sha1Container)

  var sha1Label = newLabel("SHA1:")
  sha1Container.add(sha1Label)
  sha1Label.minWidth = labelWidth
  sha1Label.heightMode = HeightMode_Fill

  var sha1TextBox = newTextBox()
  sha1Container.add(sha1TextBox)
  sha1TextBox.editable = false
  sha1TextBox.fontFamily = boxFontFamily
  sha1TextBox.onClick = proc(event: ClickEvent) =
    selectText(sha1TextBox)

  var sha1Button = newButton("Calc")
  sha1Container.add(sha1Button)
  sha1Button.minWidth = buttonWidth
  sha1Button.heightMode = HeightMode_Fill
  sha1Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getSha1(sha1TextBox, text(srcTextBox))

  var sha2_256Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(sha2_256Container)

  var sha2_256Label = newLabel("SHA2-256:")
  sha2_256Container.add(sha2_256Label)
  sha2_256Label.minWidth = labelWidth
  sha2_256Label.heightMode = HeightMode_Fill

  var sha2_256TextBox = newTextBox()
  sha2_256Container.add(sha2_256TextBox)
  sha2_256TextBox.editable = false
  sha2_256TextBox.fontFamily = boxFontFamily
  sha2_256TextBox.onClick = proc(event: ClickEvent) =
    selectText(sha2_256TextBox)

  var sha2_256Button = newButton("Calc")
  sha2_256Container.add(sha2_256Button)
  sha2_256Button.minWidth = buttonWidth
  sha2_256Button.heightMode = HeightMode_Fill
  sha2_256Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getSha2_256(sha2_256TextBox, text(srcTextBox))

  var sha2_384Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(sha2_384Container)

  var sha2_384Label = newLabel("SHA2-384:")
  sha2_384Container.add(sha2_384Label)
  sha2_384Label.minWidth = labelWidth
  sha2_384Label.heightMode = HeightMode_Fill

  var sha2_384TextBox = newTextBox()
  sha2_384Container.add(sha2_384TextBox)
  sha2_384TextBox.editable = false
  sha2_384TextBox.fontFamily = boxFontFamily
  sha2_384TextBox.onClick = proc(event: ClickEvent) =
    selectText(sha2_384TextBox)

  var sha2_384Button = newButton("Calc")
  sha2_384Container.add(sha2_384Button)
  sha2_384Button.minWidth = buttonWidth
  sha2_384Button.heightMode = HeightMode_Fill
  sha2_384Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getSha2_384(sha2_384TextBox, text(srcTextBox))

  var sha2_512Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(sha2_512Container)

  var sha2_512Label = newLabel("SHA2-512:")
  sha2_512Container.add(sha2_512Label)
  sha2_512Label.minWidth = labelWidth
  sha2_512Label.heightMode = HeightMode_Fill

  var sha2_512TextBox = newTextBox()
  sha2_512Container.add(sha2_512TextBox)
  sha2_512TextBox.editable = false
  sha2_512TextBox.fontFamily = boxFontFamily
  sha2_512TextBox.onClick = proc(event: ClickEvent) =
    selectText(sha2_512TextBox)

  var sha2_512Button = newButton("Calc")
  sha2_512Container.add(sha2_512Button)
  sha2_512Button.minWidth = buttonWidth
  sha2_512Button.heightMode = HeightMode_Fill
  sha2_512Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getSha2_512(sha2_512TextBox, text(srcTextBox))

  var sha3_256Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(sha3_256Container)

  var sha3_256Label = newLabel("SHA3-256:")
  sha3_256Container.add(sha3_256Label)
  sha3_256Label.minWidth = labelWidth
  sha3_256Label.heightMode = HeightMode_Fill

  var sha3_256TextBox = newTextBox()
  sha3_256Container.add(sha3_256TextBox)
  sha3_256TextBox.editable = false
  sha3_256TextBox.fontFamily = boxFontFamily
  sha3_256TextBox.onClick = proc(event: ClickEvent) =
    selectText(sha3_256TextBox)

  var sha3_256Button = newButton("Calc")
  sha3_256Container.add(sha3_256Button)
  sha3_256Button.minWidth = buttonWidth
  sha3_256Button.heightMode = HeightMode_Fill
  sha3_256Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getSha3_256(sha3_256TextBox, text(srcTextBox))

  var sha3_384Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(sha3_384Container)

  var sha3_384Label = newLabel("SHA3-384:")
  sha3_384Container.add(sha3_384Label)
  sha3_384Label.minWidth = labelWidth
  sha3_384Label.heightMode = HeightMode_Fill

  var sha3_384TextBox = newTextBox()
  sha3_384Container.add(sha3_384TextBox)
  sha3_384TextBox.editable = false
  sha3_384TextBox.fontFamily = boxFontFamily
  sha3_384TextBox.onClick = proc(event: ClickEvent) =
    selectText(sha3_384TextBox)

  var sha3_384Button = newButton("Calc")
  sha3_384Container.add(sha3_384Button)
  sha3_384Button.minWidth = buttonWidth
  sha3_384Button.heightMode = HeightMode_Fill
  sha3_384Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getSha3_384(sha3_384TextBox, text(srcTextBox))

  var sha3_512Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(sha3_512Container)

  var sha3_512Label = newLabel("SHA3-512:")
  sha3_512Container.add(sha3_512Label)
  sha3_512Label.minWidth = labelWidth
  sha3_512Label.heightMode = HeightMode_Fill

  var sha3_512TextBox = newTextBox()
  sha3_512Container.add(sha3_512TextBox)
  sha3_512TextBox.editable = false
  sha3_512TextBox.fontFamily = boxFontFamily
  sha3_512TextBox.onClick = proc(event: ClickEvent) =
    selectText(sha3_512TextBox)

  var sha3_512Button = newButton("Calc")
  sha3_512Container.add(sha3_512Button)
  sha3_512Button.minWidth = buttonWidth
  sha3_512Button.heightMode = HeightMode_Fill
  sha3_512Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getSha3_512(sha3_512TextBox, text(srcTextBox))

  var keccak_256Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(keccak_256Container)

  var keccak_256Label = newLabel("Keccak-256:")
  keccak_256Container.add(keccak_256Label)
  keccak_256Label.minWidth = labelWidth
  keccak_256Label.heightMode = HeightMode_Fill

  var keccak_256TextBox = newTextBox()
  keccak_256Container.add(keccak_256TextBox)
  keccak_256TextBox.editable = false
  keccak_256TextBox.fontFamily = boxFontFamily
  keccak_256TextBox.onClick = proc(event: ClickEvent) =
    selectText(keccak_256TextBox)

  var keccak_256Button = newButton("Calc")
  keccak_256Container.add(keccak_256Button)
  keccak_256Button.minWidth = buttonWidth
  keccak_256Button.heightMode = HeightMode_Fill
  keccak_256Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getKeccak_256(keccak_256TextBox, text(srcTextBox))

  var keccak_384Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(keccak_384Container)

  var keccak_384Label = newLabel("Keccak-384:")
  keccak_384Container.add(keccak_384Label)
  keccak_384Label.minWidth = labelWidth
  keccak_384Label.heightMode = HeightMode_Fill

  var keccak_384TextBox = newTextBox()
  keccak_384Container.add(keccak_384TextBox)
  keccak_384TextBox.editable = false
  keccak_384TextBox.fontFamily = boxFontFamily
  keccak_384TextBox.onClick = proc(event: ClickEvent) =
    selectText(keccak_384TextBox)

  var keccak_384Button = newButton("Calc")
  keccak_384Container.add(keccak_384Button)
  keccak_384Button.minWidth = buttonWidth
  keccak_384Button.heightMode = HeightMode_Fill
  keccak_384Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getKeccak_384(keccak_384TextBox, text(srcTextBox))

  var keccak_512Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(keccak_512Container)

  var keccak_512Label = newLabel("Keccak-512:")
  keccak_512Container.add(keccak_512Label)
  keccak_512Label.minWidth = labelWidth
  keccak_512Label.heightMode = HeightMode_Fill

  var keccak_512TextBox = newTextBox()
  keccak_512Container.add(keccak_512TextBox)
  keccak_512TextBox.editable = false
  keccak_512TextBox.fontFamily = boxFontFamily
  keccak_512TextBox.onClick = proc(event: ClickEvent) =
    selectText(keccak_512TextBox)

  var keccak_512Button = newButton("Calc")
  keccak_512Container.add(keccak_512Button)
  keccak_512Button.minWidth = buttonWidth
  keccak_512Button.heightMode = HeightMode_Fill
  keccak_512Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getKeccak_512(keccak_512TextBox, text(srcTextBox))

  var blake2_256Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(blake2_256Container)

  var blake2_256Label = newLabel("Blake2-256:")
  blake2_256Container.add(blake2_256Label)
  blake2_256Label.minWidth = labelWidth
  blake2_256Label.heightMode = HeightMode_Fill

  var blake2_256TextBox = newTextBox()
  blake2_256Container.add(blake2_256TextBox)
  blake2_256TextBox.editable = false
  blake2_256TextBox.fontFamily = boxFontFamily
  blake2_256TextBox.onClick = proc(event: ClickEvent) =
    selectText(blake2_256TextBox)

  var blake2_256Button = newButton("Calc")
  blake2_256Container.add(blake2_256Button)
  blake2_256Button.minWidth = buttonWidth
  blake2_256Button.heightMode = HeightMode_Fill
  blake2_256Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getBlake2_256(blake2_256TextBox, text(srcTextBox))

  var blake2_384Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(blake2_384Container)

  var blake2_384Label = newLabel("Blake2-384:")
  blake2_384Container.add(blake2_384Label)
  blake2_384Label.minWidth = labelWidth
  blake2_384Label.heightMode = HeightMode_Fill

  var blake2_384TextBox = newTextBox()
  blake2_384Container.add(blake2_384TextBox)
  blake2_384TextBox.editable = false
  blake2_384TextBox.fontFamily = boxFontFamily
  blake2_384TextBox.onClick = proc(event: ClickEvent) =
    selectText(blake2_384TextBox)

  var blake2_384Button = newButton("Calc")
  blake2_384Container.add(blake2_384Button)
  blake2_384Button.minWidth = buttonWidth
  blake2_384Button.heightMode = HeightMode_Fill
  blake2_384Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getBlake2_384(blake2_384TextBox, text(srcTextBox))

  var blake2_512Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(blake2_512Container)

  var blake2_512Label = newLabel("Blake2-512:")
  blake2_512Container.add(blake2_512Label)
  blake2_512Label.minWidth = labelWidth
  blake2_512Label.heightMode = HeightMode_Fill

  var blake2_512TextBox = newTextBox()
  blake2_512Container.add(blake2_512TextBox)
  blake2_512TextBox.editable = false
  blake2_512TextBox.fontFamily = boxFontFamily
  blake2_512TextBox.onClick = proc(event: ClickEvent) =
    selectText(blake2_512TextBox)

  var blake2_512Button = newButton("Calc")
  blake2_512Container.add(blake2_512Button)
  blake2_512Button.minWidth = buttonWidth
  blake2_512Button.heightMode = HeightMode_Fill
  blake2_512Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getBlake2_512(blake2_512TextBox, text(srcTextBox))

  var ripemd_256Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(ripemd_256Container)

  var ripemd_256Label = newLabel("Ripemd-256:")
  ripemd_256Container.add(ripemd_256Label)
  ripemd_256Label.minWidth = labelWidth
  ripemd_256Label.heightMode = HeightMode_Fill

  var ripemd_256TextBox = newTextBox()
  ripemd_256Container.add(ripemd_256TextBox)
  ripemd_256TextBox.editable = false
  ripemd_256TextBox.fontFamily = boxFontFamily
  ripemd_256TextBox.onClick = proc(event: ClickEvent) =
    selectText(ripemd_256TextBox)

  var ripemd_256Button = newButton("Calc")
  ripemd_256Container.add(ripemd_256Button)
  ripemd_256Button.minWidth = buttonWidth
  ripemd_256Button.heightMode = HeightMode_Fill
  ripemd_256Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getRipemd_256(ripemd_256TextBox, text(srcTextBox))

  var ripemd_320Container = newLayoutContainer(Layout_Horizontal)
  subContainer.add(ripemd_320Container)

  var ripemd_320Label = newLabel("Ripemd-320:")
  ripemd_320Container.add(ripemd_320Label)
  ripemd_320Label.minWidth = labelWidth
  ripemd_320Label.heightMode = HeightMode_Fill

  var ripemd_320TextBox = newTextBox()
  ripemd_320Container.add(ripemd_320TextBox)
  ripemd_320TextBox.editable = false
  ripemd_320TextBox.fontFamily = boxFontFamily
  ripemd_320TextBox.onClick = proc(event: ClickEvent) =
    selectText(ripemd_320TextBox)

  var ripemd_320Button = newButton("Calc")
  ripemd_320Container.add(ripemd_320Button)
  ripemd_320Button.minWidth = buttonWidth
  ripemd_320Button.heightMode = HeightMode_Fill
  ripemd_320Button.onClick = proc(event: ClickEvent) =
    if srcTextBox.text.len > 0:
      spawn window.getRipemd_320(ripemd_320TextBox, text(srcTextBox))

  window.show()
  app.run()

  proc setFilePath(event: DropFilesEvent) =
    srcTextBox.text = $event.files[0]

  proc deselectText(textBox: TextBox) =
    if textBox != sha1TextBox: sha1TextBox.selectionEnd = 0
    if textBox != sha2_256TextBox: sha2_256TextBox.selectionEnd = 0
    if textBox != sha2_384TextBox: sha2_384TextBox.selectionEnd = 0
    if textBox != sha2_512TextBox: sha2_512TextBox.selectionEnd = 0
    if textBox != sha3_256TextBox: sha3_256TextBox.selectionEnd = 0
    if textBox != sha3_384TextBox: sha3_384TextBox.selectionEnd = 0
    if textBox != sha3_512TextBox: sha3_512TextBox.selectionEnd = 0
    if textBox != keccak_256TextBox: keccak_256TextBox.selectionEnd = 0
    if textBox != keccak_384TextBox: keccak_384TextBox.selectionEnd = 0
    if textBox != keccak_512TextBox: keccak_512TextBox.selectionEnd = 0
    if textBox != blake2_256TextBox: blake2_256TextBox.selectionEnd = 0
    if textBox != blake2_384TextBox: blake2_384TextBox.selectionEnd = 0
    if textBox != blake2_512TextBox: blake2_512TextBox.selectionEnd = 0
    if textBox != ripemd_256TextBox: ripemd_256TextBox.selectionEnd = 0
    if textBox != ripemd_320TextBox: ripemd_320TextBox.selectionEnd = 0