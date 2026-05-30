project('tinyfw', 'c')

c = meson.get_compiler('c')

cc = c.get_id()
ld = c.get_linker_id()
info = {}
info += {'compiler': cc}
info += {'linker': ld}

c_flags = [
  '-nostdlib',
  '-nostartfiles',
  '-nodefaultlibs',
  '-fno-pic',
  '-fno-pie',
  '-fomit-frame-pointer',
  '-fno-builtin',
]

info += {'cflags': c_flags}

ld_flags = [
  '--oformat=binary',
]

info += {'ld_flags': ld_flags}

summary(info, section:'tiny firmware')

bios_o = custom_target(
  input: [ 'bios.S' ],
  output: [ 'bios.o' ],
  command: [ cc, c_flags, '-c', '@INPUT@', '-o', '@OUTPUT@' ],
)

bios_bin = custom_target(
  input: [ 'bios.ld' ],
  output: [ 'bios.bin' ],
  command: [ ld, ld_flags, '-T', '@INPUT@', bios_o.full_path(), '-o', '@OUTPUT@'],
  depends: [ bios_o ],
  build_by_default: true,
)
