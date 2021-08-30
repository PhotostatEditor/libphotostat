conf = configuration_data()
conf.set('prefix', get_option('prefix'))
conf.set('libdir', get_option ('libdir'))
conf.set('PROJECT_NAME', 'libphotostat')
conf.set('PROJECT_VERSION', '0.0.1')
conf.set('API_VERSION', API_VERSION)

sources = files([
  'library.vala'
  ])

liblibphotostat = library('libphotostat-' + API_VERSION,
  sources,
  vala_header: 'libphotostat.h',
  vala_vapi: 'libphotostat-' + API_VERSION + '.vapi',
  vala_gir: 'LibPhotostat-' + API_VERSION + '.gir',
  dependencies : dependencies,
  vala_args: [
    '--abi-stability'
    ],
  install: true,
  install_dir: [
    true,
    get_option('includedir') / 'libphotostat-' + API_VERSION / 'libphotostat',
    vapidir,
    g_ir_compiler.found()
  ]
)

if g_ir_compiler.found()
  custom_target('liblibphotostat-typelib',
    command: [
      g_ir_compiler,
      '--shared-library', 'liblibphotostat-@0@.so'.format (API_VERSION),
      '--output', '@OUTPUT@',
      meson.current_build_dir() / 'LibPhotostat-' + API_VERSION + '.gir'
    ],
    output: 'LibPhotostat-' + API_VERSION + '.typelib',
    depends: liblibphotostat,
    install: true,
    install_dir: join_paths(get_option('libdir'), 'girepository-1.0'))
endif

pkgconfig.generate(liblibphotostat,
  subdirs: 'libphotostat-' + API_VERSION,
  version: API_VERSION,
  name: 'libphotostat',
  filebase: 'libphotostat-' + API_VERSION,
  requires: PKGCONFIG_DEPS,
  description: 'Library used by the photostat project')

if get_option('enable_valadoc')
  valadoc = find_program('valadoc')
  libphotostat_docs = custom_target('libphotostat_apidocs',
    input: sources,
    install: true,
    # FIXME: Installing to tmp, so the target will be built
    #        the problem is we cannot access a subfolder of the
    #        buildtarget via the output parameter.
    #        Find a nicer solution
    install_dir: get_option('datadir') / 'devhelp' / 'books',
    command: [
      valadoc,
      '-o', meson.current_build_dir() / 'LibPhotostat-' + API_VERSION,
      '--doclet',
      'devhelp',
      '@INPUT@',
      '--force'
    ],
    output: 'LibPhotostat-' + API_VERSION)

  install_subdir(meson.current_build_dir() / 'LibPhotostat-' + API_VERSION / 'LibPhotostat-' + API_VERSION,
    install_dir: get_option('datadir') / 'devhelp' / 'books')
endif
