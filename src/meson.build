dependencies = [
    gobject,
    glib,
    gdk
]

sources = files([
    'Image.vala',
    'AbstractOperation.vala',
    'ImageIO/Reader.vala',
    'ImageIO/Writer.vala'
])

shared_library(
    meson.project_name(),
    sources,
    dependencies: dependencies
)
