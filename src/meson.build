dependencies = [
    gobject,
    glib,
    gdk
]

sources = files([
    'Image.vala',
    'AbstractOperation.vala',
    'ImageIO/Reader.vala',
    'ImageIO/Writer.vala',

    'PointOps/BrightnessContrast.vala',
    'PointOps/Inversion.vala',

    'Utils/Rectangle.vala',
    'Utils/Maths.vala'
])

shared_library(
    meson.project_name(),
    sources,
    dependencies: dependencies
)
